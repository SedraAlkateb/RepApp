import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domina_app/analytics/analytics_service.dart';
import 'package:domina_app/app/logger/app_logger.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_sp_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/all_exception_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_exception_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/async_data_sql_usecase.dart';
import 'package:domina_app/domain/usecase/check_active_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/delete_all_sql_usecase.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/get_visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/get_visit_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_plan_brand_sql_usecase.dart';
import 'package:domina_app/domain/usecase/is_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/plan_brand_usecase.dart';
import 'package:domina_app/domain/usecase/update_active_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/visit_hospital_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:meta/meta.dart';

part 'sync_event.dart';
part 'sync_state.dart';

final _log = AppLogger.get('SyncBloc');

/// أقصى عدد لمرات إعادة الرفع لو أُضيفت زيارات جديدة أثناء الرفع.
const int _maxUploadPasses = 3;

class _StepFailure implements Exception {
  final Failure failure;
  _StepFailure(this.failure);
}

enum _UploadOutcome { done, planChanged, failed }

/// لقطة من حقول الخطة/الشروط في UserInfo لاستعادتها أو مقارنتها.
/// لا تُغيَّر أي شروط للخطة هنا؛ تُستخدم فقط لمعرفة هل تغيّرت حالة الخطة
/// المحلية قبل فشل التحميل.
class _PlanSnapshot {
  final int activePlanId;
  final int? otherPlanId;
  final int? otherstatus;
  final String? startDate;
  final String? endDate;
  final String? otherStartDate;
  final String? otherEndDate;
  final int flag;
  final int flag1;
  final int percentage;
  final int recipesCount;
  final int totalReci;
  final int remainReci;
  final int usedReci;
  final String groupTitle;
  final int? totHos;
  final int? totDoc;

  _PlanSnapshot()
      : activePlanId = UserInfo.activePlanId,
        otherPlanId = UserInfo.otherPlanId,
        otherstatus = UserInfo.otherstatus,
        startDate = UserInfo.startDate,
        endDate = UserInfo.endDate,
        otherStartDate = UserInfo.otherStartDate,
        otherEndDate = UserInfo.otherEndDate,
        flag = UserInfo.flag,
        flag1 = UserInfo.flag1,
        percentage = UserInfo.percentage,
        recipesCount = UserInfo.recipesCount,
        totalReci = UserInfo.totalReci,
        remainReci = UserInfo.remainReci,
        usedReci = UserInfo.usedReci,
        groupTitle = UserInfo.groupTitle,
        totHos = UserInfo.totHos,
        totDoc = UserInfo.totDoc;

  /// هل الحقول التي تحدد حالة الخطة وشروطها متطابقة مع [other]؟
  bool samePlanState(_PlanSnapshot other) =>
      activePlanId == other.activePlanId &&
      otherPlanId == other.otherPlanId &&
      otherstatus == other.otherstatus &&
      startDate == other.startDate &&
      endDate == other.endDate &&
      otherStartDate == other.otherStartDate &&
      otherEndDate == other.otherEndDate &&
      flag == other.flag &&
      flag1 == other.flag1;

  void restore() {
    UserInfo.activePlanId = activePlanId;
    UserInfo.otherPlanId = otherPlanId;
    UserInfo.otherstatus = otherstatus;
    UserInfo.startDate = startDate;
    UserInfo.endDate = endDate;
    UserInfo.otherStartDate = otherStartDate;
    UserInfo.otherEndDate = otherEndDate;
    UserInfo.flag = flag;
    UserInfo.flag1 = flag1;
    UserInfo.percentage = percentage;
    UserInfo.recipesCount = recipesCount;
    UserInfo.totalReci = totalReci;
    UserInfo.remainReci = remainReci;
    UserInfo.usedReci = usedReci;
    UserInfo.groupTitle = groupTitle;
    UserInfo.totHos = totHos;
    UserInfo.totDoc = totDoc;
    UserInfo.initializeUserPlan();
  }
}

/// مزامنة موحّدة: رفع الزيارات → (رسالة تغيّر الخطة) → تحميل واستبدال البيانات،
/// أو رفع → حذف كل شيء (تسجيل الخروج).
///
/// - لا يعمل إلا مزامنة واحدة في التطبيق كله ([_running]) حتى لو فُتحت صفحتان
///   (مثلاً من إشعار انتهاء الخطة) فلا تتكرر الزيارات على السيرفر.
/// - لا تُحذف البيانات المحلية إلا بعد التأكد أن لا زيارات غير مرسلة.
/// - الحذف والإدخال بمعاملة واحدة فلا تبقى قاعدة فارغة إذا فشل التحميل.
/// - شروط الخطة (otherstatus/flag/flag1 وأنواع المستخدمين) منقولة كما هي.
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final AnalyticsService analyticsService;

  // ---- رفع ----
  final AllExceptionSqlUsecase allExceptionSqlUsecase;
  final AllExceptionUsecase allExceptionUsecase;
  final GetBrandsDoctorVisitsSqlUsecase getBrandsDoctorVisitsSqlUsecase;
  final GetBrandsHospitalVisitsSqlUsecase getBrandsHospitalVisitsSqlUsecase;
  final GetDoctorVisitsSqlUsecase getDoctorVisitsSqlUsecase;
  final GetHospitalVisitsSqlUsecase getHospitalVisitsSqlUsecase;
  final GetPlanBrandSqlUsecase getPlanBrandSqlUsecase;
  final VisitDoctorUsecase visitDoctorUsecase;
  final VisitHospitalUsecase visitHospitalUsecase;
  final PlanBrandUsecase planBrandUsecase;
  final UpdateFlagDoctorSqlUsecase updateFlagDoctorSqlUsecase;
  final UpdateFlagHospitalSqlUsecase updateFlagHospitalSqlUsecase;
  final IsPlanSqlUsecase isPlanSqlUsecase;

  // ---- تحميل ----
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

  // ---- حالة الدخول / الحذف ----
  final EditIsLoginSqlUsecase editIsLoginSqlUsecase;
  final DeleteAllSqlUsecase deleteAllSqlUsecase;

  /// حارس عام: مزامنة واحدة فقط في نفس الوقت مهما تعددت الصفحات/الـ blocs.
  static bool _running = false;

  /// نوع العملية المنتظرة لموافقة المندوب على رسالة تغيّر الخطة.
  SyncMode? _pendingMode;

  bool _keepPlanBrand = false;
  LoginModel? _checkActiveModel;
  bool _planStateChanged = false;

  SyncBloc({
    required this.analyticsService,
    required this.allExceptionSqlUsecase,
    required this.allExceptionUsecase,
    required this.getBrandsDoctorVisitsSqlUsecase,
    required this.getBrandsHospitalVisitsSqlUsecase,
    required this.getDoctorVisitsSqlUsecase,
    required this.getHospitalVisitsSqlUsecase,
    required this.getPlanBrandSqlUsecase,
    required this.visitDoctorUsecase,
    required this.visitHospitalUsecase,
    required this.planBrandUsecase,
    required this.updateFlagDoctorSqlUsecase,
    required this.updateFlagHospitalSqlUsecase,
    required this.isPlanSqlUsecase,
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
    required this.deleteAllSqlUsecase,
  }) : super(const SyncInitial()) {
    on<SyncStartEvent>(_onStart);
    on<SyncPlanAckEvent>(_onPlanAck);
  }

  // ===========================================================
  // نقاط الدخول
  // ===========================================================

  Future<void> _onStart(SyncStartEvent event, Emitter<SyncState> emit) async {
    if (_running) return;
    _running = true;
    var waitingForAck = false;
    try {
      await _setCrashContext(event.mode.name);
      _planStateChanged = false;

      switch (event.mode) {
        case SyncMode.forcedLogout:
          await _cleanAndLogout(emit, event.mode);
          break;

        case SyncMode.logout:
        case SyncMode.sync:
          // isLogging 1/4 = تحميل فقط (أول دخول أو تحميل غير مكتمل سابق):
          // لا يوجد ما يُرفع، ورفع الخطة هنا سيكون خطأً.
          final downloadOnly = event.mode == SyncMode.sync &&
              (UserInfo.isLogging == 1 || UserInfo.isLogging == 4);

          if (!downloadOnly) {
            final outcome = await _upload(emit);
            if (outcome == _UploadOutcome.failed) return;
            if (outcome == _UploadOutcome.planChanged) {
              _pendingMode = event.mode;
              waitingForAck = true;
              emit(const SyncPlanChangedState());
              return;
            }
          }
          await _finish(event.mode, emit);
          break;
      }
    } catch (error, stackTrace) {
      await _recordError(error, stackTrace, 'Fatal exception in sync');
      emit(SyncFailureState(Failure(-9, error.toString()),
          canLeave: !_planStateChanged));
    } finally {
      if (!waitingForAck) _running = false;
    }
  }

  Future<void> _onPlanAck(
      SyncPlanAckEvent event, Emitter<SyncState> emit) async {
    final mode = _pendingMode;
    if (mode == null) return;
    _pendingMode = null;
    try {
      await _finish(mode, emit);
    } catch (error, stackTrace) {
      await _recordError(error, stackTrace, 'Fatal exception in sync (ack)');
      emit(SyncFailureState(Failure(-9, error.toString()),
          canLeave: !_planStateChanged));
    } finally {
      _running = false;
    }
  }

  Future<void> _finish(SyncMode mode, Emitter<SyncState> emit) {
    return mode == SyncMode.sync
        ? _downloadAndReplace(emit)
        : _cleanAndLogout(emit, mode);
  }

  // ===========================================================
  // 1) الرفع
  // ===========================================================

  Future<_UploadOutcome> _upload(Emitter<SyncState> emit) async {
    emit(const SyncInProgress(SyncPhase.uploading));

    // الشرط كما كان: يُقيَّم مرة واحدة قبل أي تعديل.
    final uploadPlan = UserInfo.otherstatus == 5 && UserInfo.flag == 0;

    final exceptions = _ok(
        await allExceptionSqlUsecase.execute(), emit, '14');
    if (exceptions == null) return _UploadOutcome.failed;

    var planBrands = <PlanBrandModel>[];
    if (uploadPlan) {
      final result = _ok(await getPlanBrandSqlUsecase.execute(), emit, '10');
      if (result == null) return _UploadOutcome.failed;
      planBrands = result;
    }

    if (exceptions.isNotEmpty) {
      final result = await allExceptionUsecase
          .execute(ExceptionRequestBody(exceptions));
      if (_failed(result, emit, '1')) return _UploadOutcome.failed;
    }

    // الزيارات: نكرر الرفع إذا أُضيفت زيارات جديدة أثناءه، ولا نتابع
    // (ولا نحذف شيئاً) قبل التأكد أنه لا زيارات غير مرسلة.
    for (var pass = 0;; pass++) {
      final brandDoctors =
          _ok(await getBrandsDoctorVisitsSqlUsecase.execute(), emit, '14');
      if (brandDoctors == null) return _UploadOutcome.failed;
      final brandHospitals =
          _ok(await getBrandsHospitalVisitsSqlUsecase.execute(), emit, '13');
      if (brandHospitals == null) return _UploadOutcome.failed;
      final doctors = _ok(await getDoctorVisitsSqlUsecase.execute(), emit, '12');
      if (doctors == null) return _UploadOutcome.failed;
      final hospitals =
          _ok(await getHospitalVisitsSqlUsecase.execute(), emit, '11');
      if (hospitals == null) return _UploadOutcome.failed;

      final hasDoctors = doctors.isNotEmpty || brandDoctors.isNotEmpty;
      final hasHospitals = hospitals.isNotEmpty || brandHospitals.isNotEmpty;
      if (!hasDoctors && !hasHospitals) break;

      if (pass >= _maxUploadPasses) {
        emit(SyncFailureState(
            Failure(0, 'تعذر إكمال رفع كل الزيارات، أعد المحاولة 15')));
        return _UploadOutcome.failed;
      }

      if (hasDoctors) {
        final result = await visitDoctorUsecase
            .execute(VisitDoctorRequestBody(doctors, brandDoctors));
        if (result.isLeft()) {
          final failure = result.fold((f) => f, (_) => null)!;
          emit(SyncFailureState(
              Failure(failure.code, '${failure.massage} 2')));
          return _UploadOutcome.failed;
        }
        // نُعلِّم فقط ما رُفع فعلاً؛ ما أُضيف أثناء الرفع يُرفع في الدورة التالية.
        final marked = _ok(
            await updateFlagDoctorSqlUsecase.execute(
                visitIds: doctors.map((v) => v.id).toList(),
                brandIds: brandDoctors.map((v) => v.id).toList()),
            emit,
            '2');
        if (marked == null) return _UploadOutcome.failed;
        if (!marked) return _markFailed(emit, '2');
      }

      if (hasHospitals) {
        final result = await visitHospitalUsecase
            .execute(VisitHospitalRequestBody(hospitals, brandHospitals));
        if (_failed(result, emit, '3')) return _UploadOutcome.failed;
        final marked = _ok(
            await updateFlagHospitalSqlUsecase.execute(
                visitIds: hospitals.map((v) => v.id).toList(),
                brandIds: brandHospitals.map((v) => v.id).toList()),
            emit,
            '4');
        if (marked == null) return _UploadOutcome.failed;
        if (!marked) return _markFailed(emit, '4');
      }
    }

    if (!uploadPlan) return _UploadOutcome.done;

    // ---- رفع الخطة (منقول كما هو) ----
    final isPlan = await checkActiveBrandPlanUsecase.execute(UserInfo.repId);
    final checkFailure = isPlan.fold<Failure?>((failure) => failure, (data) {
      UserInfo.isChange = data.otherStatus != 0;
      UserInfo.otherstatus = data.otherStatus ?? -1;
      UserInfo.startDate = data.startDate;
      UserInfo.endDate = data.endDate;
      UserInfo.otherStartDate = data.otherStartDate;
      UserInfo.otherEndDate = data.otherEndDate;
      if (UserInfo.otherstatus == -1) {
        UserInfo.flag1 = 0;
      }
      return null;
    });
    if (checkFailure != null) {
      emit(SyncFailureState(Failure(0, '${checkFailure.massage} 5')));
      return _UploadOutcome.failed;
    }

    if (UserInfo.isChange == false) {
      final result =
          await planBrandUsecase.execute(RepPlanBrandBody(planBrands, 5));
      if (_failed(result, emit, '6')) return _UploadOutcome.failed;
    }

    final flagResult = await isPlanSqlUsecase.execute(UserInfo.repId, 1);
    if (_failed(flagResult, emit, '7')) return _UploadOutcome.failed;
    UserInfo.flag = 1;

    return UserInfo.isChange == true
        ? _UploadOutcome.planChanged
        : _UploadOutcome.done;
  }

  _UploadOutcome _markFailed(Emitter<SyncState> emit, String tag) {
    // لا نعيد المحاولة تلقائياً كي لا تتكرر الزيارات على السيرفر.
    emit(SyncFailureState(
        Failure(0, 'تم رفع الزيارات لكن تعذر تعليمها كمرسلة $tag')));
    return _UploadOutcome.failed;
  }

  // ===========================================================
  // 2) التحميل + الاستبدال الذرّي
  // ===========================================================

  Future<void> _downloadAndReplace(Emitter<SyncState> emit) async {
    emit(const SyncInProgress(SyncPhase.downloading));

    // كان الحذف يحصل مباشرة بعد الرفع ويقرأ flag1 حينها؛ نلتقطه بنفس اللحظة:
    // خطة المندوب المحفوظة offline (flag1 != 0) لا تُحذف.
    _keepPlanBrand = UserInfo.flag1 != 0;
    final before = _PlanSnapshot();

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
    _planStateChanged = !_PlanSnapshot().samePlanState(before);

    // --- ج) تحميل كل البيانات بالتوازي (بدل 10 طلبات متتالية) ---
    final SyncPayload payload;
    try {
      payload = await _downloadAll(emit);
    } on _StepFailure catch (e) {
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
        await FirebaseCrashlytics.instance.recordError(
          Exception('Database Save Failed'),
          StackTrace.current,
          reason: 'Local DB save error: ${saveFailure.massage}',
          fatal: false,
        );
      } catch (_) {}
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
          throw _StepFailure(failure);
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
      } on _StepFailure {
        rethrow;
      } catch (error, stackTrace) {
        watch.stop();
        final failure = Failure(-5, error.toString());
        await _recordError(error, stackTrace, name);
        unawaited(logSyncStep(
          stepName: name,
          loadingNumber: number,
          success: false,
          durationMs: watch.elapsedMilliseconds,
          failure: failure,
        ));
        throw _StepFailure(failure);
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

    FirebaseCrashlytics.instance
        .log('✅ [SYNC DOWNLOAD COMPLETED SUCCESSFULLY]');
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

  // ===========================================================
  // 3) تسجيل الخروج: حذف كل البيانات المحلية
  // ===========================================================

  Future<void> _cleanAndLogout(Emitter<SyncState> emit, SyncMode mode) async {
    emit(const SyncInProgress(SyncPhase.cleaning));
    final result = await deleteAllSqlUsecase.execute();
    result.fold(
      (failure) => emit(SyncFailureState(failure)),
      (_) {
        UserInfo.flag1 = 0;
        UserInfo.isLogging = 0;
        emit(SyncSuccess(mode));
      },
    );
  }

  // ===========================================================
  // أدوات مساعدة
  // ===========================================================

  /// يفكّ Either: عند الفشل يُصدر حالة الفشل (برقم الخطوة) ويرجع null.
  T? _ok<T>(Either<Failure, T> result, Emitter<SyncState> emit, String tag) {
    return result.fold<T?>((failure) {
      emit(SyncFailureState(Failure(0, '${failure.massage} $tag')));
      return null;
    }, (data) => data);
  }

  /// لنتائج لا قيمة لها: يُصدر حالة الفشل ويرجع true عند الفشل.
  bool _failed(
      Either<Failure, Object?> result, Emitter<SyncState> emit, String tag) {
    return result.fold<bool>((failure) {
      emit(SyncFailureState(Failure(0, '${failure.massage} $tag')));
      return true;
    }, (_) => false);
  }

  Future<void> _setCrashContext(String mode) async {
    try {
      await FirebaseCrashlytics.instance
          .setUserIdentifier('${UserInfo.repId}${UserInfo.name}');
      await FirebaseCrashlytics.instance.setCustomKey('sync_mode', mode);
    } catch (error) {
      _log.warning('crashlytics context failed', error);
    }
  }

  Future<void> _recordError(
      Object error, StackTrace stackTrace, String reason) async {
    try {
      await FirebaseCrashlytics.instance
          .recordError(error, stackTrace, reason: reason, fatal: false);
    } catch (_) {}
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
      final crashlytics = FirebaseCrashlytics.instance;
      crashlytics.log(
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
        await crashlytics.setCustomKey('last_successful_sync_step', stepName);
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
        await crashlytics.recordError(
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

/// البيانات المحمّلة من السيرفر بانتظار حفظها محلياً.
class SyncPayload {
  final List<BrandModel> brands;
  final List<PlaceModel> places;
  final List<SpecDModel> spec;
  final List<DoctorModel> doctors;
  final List<HospitalModel> hospitals;
  final List<HospitalSpModel> hospitalSps;
  final List<BrandSpModel> brandSpModel;
  final List<PlanBrandModel> planBrands;
  final VisitDoctorBase visitDoctor;
  final VisitHospitalBase visitHospital;

  const SyncPayload({
    required this.brands,
    required this.places,
    required this.spec,
    required this.doctors,
    required this.hospitals,
    required this.hospitalSps,
    required this.brandSpModel,
    required this.planBrands,
    required this.visitDoctor,
    required this.visitHospital,
  });
}
