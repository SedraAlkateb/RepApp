import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domina_app/analytics/analytics_service.dart';
import 'package:domina_app/app/logger/app_logger.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/sync/bloc/sync_diagnostics.dart';
import 'package:domina_app/presentation/sync/bloc/sync_event.dart';
import 'package:domina_app/presentation/sync/bloc/sync_state.dart';
import 'package:domina_app/presentation/sync/bloc/sync_support.dart';
import 'package:domina_app/domain/usecase/all_brands_sp_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/async_data_sql_usecase.dart';
import 'package:domina_app/domain/usecase/check_active_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/get_visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/get_visit_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/update_active_sql_usecase.dart';

final _log = AppLogger.get('SyncDownloader');

/// مرحلة التحميل والاستبدال الذرّي من المزامنة. منقولة حرفياً من SyncBloc:
/// لا تُحذف البيانات المحلية قبل نجاح التحميل، وشروط الخطة كما هي.
class SyncDownloader {
  final AnalyticsService analyticsService;
  final SyncDiagnostics diagnostics;

  final CheckActiveBrandPlanUsecase checkActiveBrandPlanUsecase;
  final UpdateActiveSqlUsecase updateActiveSqlUsecase;
  final AllBrandsUsecase allBrandsUsecase;
  final GetVisitDoctorUsecase getVisitDoctorUsecase;
  final GetVisitHospitalUsecase getVisitHospitalUsecase;
  final AllPlanBrandsUsecase allPlanBrandsUsecase;
  final AllDoctorUsecase allDoctorUsecase;
  final AllHospitalUsecase allHospitalUsecase;
  final AllPlaceUsecase allPlaceUsecase;
  final AllSpeUsecase allSpeUsecase;
  final AllHospialSpUsecase allHospialSpUsecase;
  final AllBrandsSpUsecase allBrandsSpUsecase;
  final AsyncDataSqlUsecase asyncDataSqlUsecase;
  final EditIsLoginSqlUsecase editIsLoginSqlUsecase;

  bool _keepPlanBrand = false;
  LoginModel? _checkActiveModel;
  bool _planStateChanged = false;

  SyncDownloader({
    required this.analyticsService,
    required this.diagnostics,
    required this.checkActiveBrandPlanUsecase,
    required this.updateActiveSqlUsecase,
    required this.allBrandsUsecase,
    required this.getVisitDoctorUsecase,
    required this.getVisitHospitalUsecase,
    required this.allPlanBrandsUsecase,
    required this.allDoctorUsecase,
    required this.allHospitalUsecase,
    required this.allPlaceUsecase,
    required this.allSpeUsecase,
    required this.allHospialSpUsecase,
    required this.allBrandsSpUsecase,
    required this.asyncDataSqlUsecase,
    required this.editIsLoginSqlUsecase,
  });

  /// هل تغيّرت حالة الخطة المحلية أثناء هذا التحميل؟ (يحدد canLeave عند الفشل)
  bool get planStateChanged => _planStateChanged;

  void resetPlanState() => _planStateChanged = false;

  Future<void> downloadAndReplace(Emitter<SyncState> emit) async {
    emit(const SyncInProgress(SyncPhase.downloading));

    // كان الحذف يحصل مباشرة بعد الرفع ويقرأ flag1 حينها؛ نلتقطه بنفس اللحظة:
    // خطة المندوب المحفوظة offline (flag1 != 0) لا تُحذف.
    _keepPlanBrand = UserInfo.flag1 != 0;
    final before = PlanSnapshot();

    // --- أ) الخطة الحالية من السيرفر (كانت PlanIsActiveEvent) ---
    final active = await checkActiveBrandPlanUsecase.execute(UserInfo.repId);
    final activeFailure = active.fold<Failure?>((failure) => failure, (data) {
      _checkActiveModel = data;
      UserInfo.activePlanId = data.activePlanId ?? -5;
      UserInfo.otherPlanId = data.otherPlanId ?? 0;
      UserInfo.otherstatus = data.otherStatus ?? -1;
      UserInfo.percentage = data.percentage;
      UserInfo.recipesCount = data.recipesCount;
      UserInfo.startDate = data.startDate;
      UserInfo.endDate = data.endDate;
      UserInfo.totalReci = data.totalReci;
      UserInfo.remainReci = data.remainReci;
      UserInfo.groupTitle = data.groupTitle;

      UserInfo.totHos = data.totHos;
      UserInfo.totDoc = data.totDoc;

      UserInfo.usedReci = data.usedReci;
      UserInfo.otherStartDate = data.otherStartDate;
      UserInfo.otherEndDate = data.otherEndDate;
      if (UserInfo.otherstatus == -1) {
        UserInfo.flag1 = 0;
      }
      UserInfo.initializeUserPlan();
      return null;
    });
    if (activeFailure != null) {
      emit(SyncFailureState(activeFailure));
      return;
    }

    // --- ب) تحديث سجل المندوب محلياً (كان UpdateRepEvent) ---
    final model = _checkActiveModel!;
    final updated = await updateActiveSqlUsecase.execute(
        UserInfo.repId,
        model.otherPlanId ?? 9,
        model.activePlanId ?? -5,
        model.otherStatus ?? 9,
        model.startDate ?? '',
        model.endDate ?? '',
        model.otherStartDate ?? '',
        model.otherEndDate ?? '');
    final updateFailure = updated.fold<Failure?>((failure) => failure, (_) {
      if (model.otherStatus != null) {
        UserInfo.flag = model.otherStatus == 0 ? 0 : 1;
        UserInfo.flag1 = model.otherStatus == -1 ? 0 : model.flag1;
      } else {
        UserInfo.flag1 = 0;
      }
      UserInfo.initializeUserPlan();
      return null;
    });
    if (updateFailure != null) {
      // لم يُكتب شيء بقاعدة البيانات: نعيد الذاكرة كما كانت.
      before.restore();
      emit(SyncFailureState(updateFailure));
      return;
    }
    _planStateChanged = !PlanSnapshot().samePlanState(before);

    // تدقيق: مقارنة حالة الخطة المحلية (أوفلاين، قبل هذا التحميل) مع حالتها
    // بعد التحقق من السيرفر (أونلاين) — نفس القيمة المستخدمة بمنطق المزامنة
    // أعلاه، هون بس نرسلها كحدث إحصائي بدون أي تأثير على القرار نفسه.
    unawaited(
      analyticsService.logEvent(
        name: 'plan_audit',
        parameters: {
          'changed': _planStateChanged.toString(),
        },
      ),
    );

    // --- ج) تحميل كل البيانات بالتوازي (بدل 10 طلبات متتالية) ---
    final SyncPayload payload;
    try {
      payload = await _downloadAll(emit);
    } on StepFailure catch (e) {
      await _failAfterPlanUpdate(emit, e.failure);
      return;
    }

    // --- د) حفظ محلي: حذف القديم + إدخال الجديد بمعاملة واحدة ---
    emit(const SyncInProgress(SyncPhase.saving));
    final saved = await asyncDataSqlUsecase.execute(
      payload.brands,
      payload.places,
      payload.spec,
      payload.doctors,
      payload.hospitals,
      payload.hospitalSps,
      payload.brandSpModel,
      payload.visitHospital,
      payload.visitDoctor,
      planBrands: payload.planBrands.isNotEmpty ? payload.planBrands : null,
      replaceExisting: true,
      keepPlanBrand: _keepPlanBrand,
    );
    final saveFailure = saved.fold<Failure?>((failure) => failure, (_) => null);
    if (saveFailure != null) {
      try {
        await diagnostics.recordError(
          Exception('Database Save Failed'),
          StackTrace.current,
          reason: 'Local DB save error: ${saveFailure.massage}',
          fatal: false,
        );
      } catch (e) {
        _log.warning('crashlytics report failed (db save)', e);
      }
      await _failAfterPlanUpdate(emit, saveFailure);
      return;
    }

    // --- هـ) اكتمل: المندوب جاهز للعمل ---
    final edited = await editIsLoginSqlUsecase.execute(UserInfo.repId, 2);
    final editFailure = edited.fold<Failure?>((failure) => failure, (_) => null);
    if (editFailure != null) {
      // البيانات محفوظة وسليمة، فقط حالة الدخول لم تُحدَّث.
      emit(SyncFailureState(editFailure));
      return;
    }
    UserInfo.isLogging = 2;
    emit(const SyncSuccess(SyncMode.sync));
  }

  /// فشل بعد أن كُتبت حالة الخطة الجديدة محلياً. إذا تغيّرت فعلاً لا يجوز
  /// العمل ببيانات الخطة القديمة: نُبقي التطبيق بحالة "تحميل مطلوب" (isLogging=1)
  /// كما كان يحدث سابقاً بعد الحذف. وإذا لم تتغيّر يبقى المندوب يعمل بما لديه.
  Future<void> _failAfterPlanUpdate(
      Emitter<SyncState> emit, Failure failure) async {
    if (_planStateChanged) {
      try {
        await editIsLoginSqlUsecase.execute(UserInfo.repId, 1);
        UserInfo.isLogging = 1;
      } catch (error) {
        _log.severe('failed to mark download required', error);
      }
      emit(SyncFailureState(failure, canLeave: false));
    } else {
      emit(SyncFailureState(failure));
    }
  }

  Future<SyncPayload> _downloadAll(Emitter<SyncState> emit) async {
    final withPlanBrands = UserInfo.flag1 == 0;
    final total = withPlanBrands ? 10 : 9;
    var done = 0;
    var cancelled = false;

    Future<T> step<T>(
      String name,
      int number,
      Future<Either<Failure, T>> Function() call, {
      int Function(T data)? count,
    }) async {
      final watch = Stopwatch()..start();
      try {
        final result = await call();
        watch.stop();
        final failure = result.fold<Failure?>((f) => f, (_) => null);
        if (failure != null) {
          unawaited(logSyncStep(
            stepName: name,
            loadingNumber: number,
            success: false,
            durationMs: watch.elapsedMilliseconds,
            failure: failure,
          ));
          throw StepFailure(failure);
        }
        final data = result.getOrElse(() => throw StateError('unreachable'));
        unawaited(logSyncStep(
          stepName: name,
          loadingNumber: number,
          success: true,
          durationMs: watch.elapsedMilliseconds,
          count: count?.call(data),
        ));
        done++;
        if (!cancelled && !emit.isDone) {
          emit(SyncInProgress(SyncPhase.downloading, done: done, total: total));
        }
        return data;
      } on StepFailure {
        rethrow;
      } catch (error, stackTrace) {
        watch.stop();
        final failure = Failure(-5, error.toString());
        await recordSyncError(diagnostics, error, stackTrace, name);
        unawaited(logSyncStep(
          stepName: name,
          loadingNumber: number,
          success: false,
          durationMs: watch.elapsedMilliseconds,
          failure: failure,
        ));
        throw StepFailure(failure);
      }
    }

    final brands = step<List<BrandModel>>('brands', 1,
        () => allBrandsUsecase.execute(UserInfo.activePlanId),
        count: (d) => d.length);
    final visitDoctor = step<VisitDoctorBase>(
        'visit_doctor',
        2,
        () => getVisitDoctorUsecase.execute(
            UserInfo.activePlanId.toString(), UserInfo.repId.toString()));
    final visitHospital = step<VisitHospitalBase>(
        'visit_hospital',
        3,
        () => getVisitHospitalUsecase.execute(
            UserInfo.activePlanId, UserInfo.repId));
    final planBrands = withPlanBrands
        ? step<List<PlanBrandModel>>(
            'plan_brands',
            4,
            () => allPlanBrandsUsecase.execute(Rep(UserInfo.activePlanId, 0,
                otherRepId: UserInfo.otherPlanId)),
            count: (d) => d.length)
        : Future.value(<PlanBrandModel>[]);
    final doctors = step<List<DoctorModel>>(
        'doctors', 5, () => allDoctorUsecase.execute(UserInfo.repId),
        count: (d) => d.length);
    final hospitals = step<List<HospitalModel>>(
        'hospitals', 6, () => allHospitalUsecase.execute(UserInfo.repId),
        count: (d) => d.length);
    final places = step<List<PlaceModel>>(
        'places', 7, () => allPlaceUsecase.execute(UserInfo.repId),
        count: (d) => d.length);
    final spec = step<List<SpecDModel>>(
        'spec', 8, () => allSpeUsecase.execute(UserInfo.repId),
        count: (d) => d.length);
    final hospitalSps = step<List<HospitalSpModel>>('hospital_sps', 9,
        () => allHospialSpUsecase.execute(UserInfo.repId),
        count: (d) => d.length);
    final brandSps = step<List<BrandSpModel>>(
        'brand_sps', 10, () => allBrandsSpUsecase.execute(UserInfo.repId),
        count: (d) => d.length);

    try {
      await Future.wait<Object?>([
        brands,
        visitDoctor,
        visitHospital,
        planBrands,
        doctors,
        hospitals,
        places,
        spec,
        hospitalSps,
        brandSps,
      ], eagerError: true);
    } catch (_) {
      // أول فشل يوقف الباقي (نتجاهل نتائجهم ولا نُصدر حالات بعد الآن).
      cancelled = true;
      rethrow;
    }

    diagnostics.log('✅ [SYNC DOWNLOAD COMPLETED SUCCESSFULLY]');
    return SyncPayload(
      brands: await brands,
      places: await places,
      spec: await spec,
      doctors: await doctors,
      hospitals: await hospitals,
      hospitalSps: await hospitalSps,
      brandSpModel: await brandSps,
      planBrands: await planBrands,
      visitDoctor: await visitDoctor,
      visitHospital: await visitHospital,
    );
  }

  Future<void> logSyncStep({
    required String stepName,
    required int loadingNumber,
    required bool success,
    required int durationMs,
    int? count,
    Failure? failure,
  }) async {
    try {
      diagnostics.log(
          '🔄 [SYNC STEP $loadingNumber: $stepName] | Success: $success | Duration: ${durationMs}ms | Items: ${count ?? 0}');

      if (success) {
        final Map<String, Object> parameters = {
          'step_name': stepName,
          'loading_number': loadingNumber.toString(),
          'duration_ms': durationMs,
        };
        if (count != null) {
          parameters['items_count'] = count.toString();
        } else {
          parameters['success'] = 'true';
        }
        await analyticsService.logEvent(
            name: 'sync_step_completed', parameters: parameters);
        await diagnostics.setCustomKey('last_successful_sync_step', stepName);
      } else {
        await analyticsService.logEvent(
          name: 'sync_step_failed',
          parameters: {
            'step_name': stepName,
            'items_count': count.toString(),
            'loading_number': loadingNumber.toString(),
            'duration_ms': durationMs,
            'error_code': failure?.code.toString() ?? 'unknown',
            'error_message': failure?.massage ?? 'unknown_error',
          },
        );
        await diagnostics.recordError(
          Exception('Sync Step Failed: $stepName'),
          StackTrace.current,
          reason:
              'Step: $stepName failed with Code: ${failure?.code} - Msg: ${failure?.massage}',
          fatal: false,
        );
      }
    } catch (error) {
      // حماية المزامنة من أي خطأ في إرسال الـ logs.
      _log.warning('Logging Error (Crashlytics/Analytics)', error);
    }
  }
}
