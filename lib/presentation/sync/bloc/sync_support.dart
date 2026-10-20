import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domina_app/app/logger/app_logger.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/sync/bloc/sync_diagnostics.dart';
import 'package:domina_app/presentation/sync/bloc/sync_state.dart';

final _log = AppLogger.get('SyncSupport');

class StepFailure implements Exception {
  final Failure failure;
  StepFailure(this.failure);
}

enum UploadOutcome { done, planChanged, failed }

/// لقطة من حقول الخطة/الشروط في UserInfo لاستعادتها أو مقارنتها.
/// لا تُغيَّر أي شروط للخطة هنا؛ تُستخدم فقط لمعرفة هل تغيّرت حالة الخطة
/// المحلية قبل فشل التحميل.
class PlanSnapshot {
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

  PlanSnapshot()
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
  bool samePlanState(PlanSnapshot other) =>
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

/// يفكّ Either: عند الفشل يُصدر حالة الفشل (برقم الخطوة) ويرجع null.
T? unwrapOrEmit<T>(Either<Failure, T> result, Emitter<SyncState> emit, String tag) {
  return result.fold<T?>((failure) {
    emit(SyncFailureState(Failure(0, '${failure.massage} $tag')));
    return null;
  }, (data) => data);
}

/// لنتائج لا قيمة لها: يُصدر حالة الفشل ويرجع true عند الفشل.
bool failedOrEmit(
    Either<Failure, Object?> result, Emitter<SyncState> emit, String tag) {
  return result.fold<bool>((failure) {
    emit(SyncFailureState(Failure(0, '${failure.massage} $tag')));
    return true;
  }, (_) => false);
}

/// تسجيل خطأ في Crashlytics دون أن يكسر المزامنة إن فشل التسجيل نفسه.
Future<void> recordSyncError(SyncDiagnostics diagnostics, Object error,
    StackTrace stackTrace, String reason) async {
  try {
    await diagnostics.recordError(error, stackTrace,
        reason: reason, fatal: false);
  } catch (e) {
    _log.warning('crashlytics recordError failed', e);
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
