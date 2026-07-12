part of 'plan_management_bloc.dart';

enum PlanStatus { initial, loading, success, error, submitting, submitSuccess }

class PlanManagementState extends Equatable {
  // ======= 🟢 أولاً: الحالات الخاصة بالخطة المستقبلية (Create / Future Plan) =======
  final PlanStatus futureStatus;
  final List<PlanBrandSp> futureBrands;       // القائمة الأصلية المستقبلية
  final List<PlanBrandSp> searchFutureBrands; // قائمة البحث المستقبلية للمستقبل
  final Failure? futureFailure;
  final bool isEnable;                        // متغير قفل وفتح الحقول

  // ======= 🔵 ثانياً: الحالات الخاصة بالخطة الفعالة (View Active Plan) =======
  final PlanStatus activeStatus;
  final List<ActivePlanBrandModel> activeBrands;       // 👈 الموديل المخصص للخطة الفعالة
  final List<ActivePlanBrandModel> searchActiveBrands; // قائمة البحث الفعالة
  final Failure? activeFailure;

  const PlanManagementState({
    this.futureStatus = PlanStatus.initial,
    this.futureBrands = const [],
    this.searchFutureBrands = const [],
    this.futureFailure,
    this.isEnable = true,

    this.activeStatus = PlanStatus.initial,
    this.activeBrands = const [],
    this.searchActiveBrands = const [],
    this.activeFailure,
  });

  // دالة copyWith المحدثة لضمان الفصل الكامل بين الحالتين
  PlanManagementState copyWith({
    PlanStatus? futureStatus,
    List<PlanBrandSp>? futureBrands,
    List<PlanBrandSp>? searchFutureBrands,
    Failure? futureFailure,
    bool? isEnable,

    PlanStatus? activeStatus,
    List<ActivePlanBrandModel>? activeBrands,
    List<ActivePlanBrandModel>? searchActiveBrands,
    Failure? activeFailure,
  }) {
    return PlanManagementState(
      futureStatus: futureStatus ?? this.futureStatus,
      futureBrands: futureBrands ?? this.futureBrands,
      searchFutureBrands: searchFutureBrands ?? this.searchFutureBrands,
      futureFailure: futureFailure ?? this.futureFailure,
      isEnable: isEnable ?? this.isEnable,

      activeStatus: activeStatus ?? this.activeStatus,
      activeBrands: activeBrands ?? this.activeBrands,
      searchActiveBrands: searchActiveBrands ?? this.searchActiveBrands,
      activeFailure: activeFailure ?? this.activeFailure,
    );
  }

  @override
  List<Object?> get props => [
    futureStatus,
    futureBrands,
    searchFutureBrands,
    futureFailure,
    isEnable,
    activeStatus,
    activeBrands,
    searchActiveBrands,
    activeFailure,
  ];
}