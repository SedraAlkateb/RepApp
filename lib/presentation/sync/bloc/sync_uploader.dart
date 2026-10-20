import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/sync/bloc/sync_state.dart';
import 'package:domina_app/presentation/sync/bloc/sync_support.dart';
import 'package:domina_app/domain/usecase/all_exception_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_exception_usecase.dart';
import 'package:domina_app/domain/usecase/check_active_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_plan_brand_sql_usecase.dart';
import 'package:domina_app/domain/usecase/is_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/plan_brand_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/visit_hospital_usecase.dart';

/// أقصى عدد لمرات إعادة الرفع لو أُضيفت زيارات جديدة أثناء الرفع.
const int _maxUploadPasses = 3;

/// مرحلة الرفع من المزامنة: الاستثناءات ← الزيارات ← (رفع الخطة).
/// منقولة حرفياً من SyncBloc؛ شروط الخطة (otherstatus/flag) لا تُغيَّر.
class SyncUploader {
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
  final CheckActiveBrandPlanUsecase checkActiveBrandPlanUsecase;

  SyncUploader({
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
  });

  Future<UploadOutcome> upload(Emitter<SyncState> emit) async {
    emit(const SyncInProgress(SyncPhase.uploading));

    // الشرط كما كان: يُقيَّم مرة واحدة قبل أي تعديل.
    final uploadPlan = UserInfo.otherstatus == 5 && UserInfo.flag == 0;

    final exceptions = unwrapOrEmit(
        await allExceptionSqlUsecase.execute(), emit, '14');
    if (exceptions == null) return UploadOutcome.failed;

    var planBrands = <PlanBrandModel>[];
    if (uploadPlan) {
      final result = unwrapOrEmit(await getPlanBrandSqlUsecase.execute(), emit, '10');
      if (result == null) return UploadOutcome.failed;
      planBrands = result;
    }

    if (exceptions.isNotEmpty) {
      final result = await allExceptionUsecase
          .execute(ExceptionRequestBody(exceptions, repId: UserInfo.repId));
      if (failedOrEmit(result, emit, '1')) return UploadOutcome.failed;
    }

    // الزيارات: نكرر الرفع إذا أُضيفت زيارات جديدة أثناءه، ولا نتابع
    // (ولا نحذف شيئاً) قبل التأكد أنه لا زيارات غير مرسلة.
    for (var pass = 0;; pass++) {
      final brandDoctors =
          unwrapOrEmit(await getBrandsDoctorVisitsSqlUsecase.execute(), emit, '14');
      if (brandDoctors == null) return UploadOutcome.failed;
      final brandHospitals =
          unwrapOrEmit(await getBrandsHospitalVisitsSqlUsecase.execute(), emit, '13');
      if (brandHospitals == null) return UploadOutcome.failed;
      final doctors = unwrapOrEmit(await getDoctorVisitsSqlUsecase.execute(), emit, '12');
      if (doctors == null) return UploadOutcome.failed;
      final hospitals =
          unwrapOrEmit(await getHospitalVisitsSqlUsecase.execute(), emit, '11');
      if (hospitals == null) return UploadOutcome.failed;

      final hasDoctors = doctors.isNotEmpty || brandDoctors.isNotEmpty;
      final hasHospitals = hospitals.isNotEmpty || brandHospitals.isNotEmpty;
      if (!hasDoctors && !hasHospitals) break;

      if (pass >= _maxUploadPasses) {
        emit(SyncFailureState(
            Failure(0, 'تعذر إكمال رفع كل الزيارات، أعد المحاولة 15')));
        return UploadOutcome.failed;
      }

      if (hasDoctors) {
        final result = await visitDoctorUsecase
            .execute(VisitDoctorRequestBody(doctors, brandDoctors,
                repPlanId: UserInfo.activePlanId,
                representativeId: UserInfo.repId));
        if (result.isLeft()) {
          final failure = result.fold((f) => f, (_) => null)!;
          emit(SyncFailureState(
              Failure(failure.code, '${failure.massage} 2')));
          return UploadOutcome.failed;
        }
        // نُعلِّم فقط ما رُفع فعلاً؛ ما أُضيف أثناء الرفع يُرفع في الدورة التالية.
        final marked = unwrapOrEmit(
            await updateFlagDoctorSqlUsecase.execute(
                visitIds: doctors.map((v) => v.id).toList(),
                brandIds: brandDoctors.map((v) => v.id).toList()),
            emit,
            '2');
        if (marked == null) return UploadOutcome.failed;
        if (!marked) return _markFailed(emit, '2');
      }

      if (hasHospitals) {
        final result = await visitHospitalUsecase
            .execute(VisitHospitalRequestBody(hospitals, brandHospitals,
                repPlanId: UserInfo.activePlanId,
                representativeId: UserInfo.repId));
        if (failedOrEmit(result, emit, '3')) return UploadOutcome.failed;
        final marked = unwrapOrEmit(
            await updateFlagHospitalSqlUsecase.execute(
                visitIds: hospitals.map((v) => v.id).toList(),
                brandIds: brandHospitals.map((v) => v.id).toList()),
            emit,
            '4');
        if (marked == null) return UploadOutcome.failed;
        if (!marked) return _markFailed(emit, '4');
      }
    }

    if (!uploadPlan) return UploadOutcome.done;

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
      return UploadOutcome.failed;
    }

    if (UserInfo.isChange == false) {
      final result =
          await planBrandUsecase.execute(RepPlanBrandBody(planBrands, 5));
      if (failedOrEmit(result, emit, '6')) return UploadOutcome.failed;
    }

    final flagResult = await isPlanSqlUsecase.execute(UserInfo.repId, 1);
    if (failedOrEmit(flagResult, emit, '7')) return UploadOutcome.failed;
    UserInfo.flag = 1;

    return UserInfo.isChange == true
        ? UploadOutcome.planChanged
        : UploadOutcome.done;
  }

  UploadOutcome _markFailed(Emitter<SyncState> emit, String tag) {
    // لا نعيد المحاولة تلقائياً كي لا تتكرر الزيارات على السيرفر.
    emit(SyncFailureState(
        Failure(0, 'تم رفع الزيارات لكن تعذر تعليمها كمرسلة $tag')));
    return UploadOutcome.failed;
  }
}
