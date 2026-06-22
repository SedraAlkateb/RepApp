part of 'plan_management_bloc.dart';

enum PlanStatus { initial, loading, success, error, submitting, submitSuccess }

class PlanManagementState extends Equatable {
  final PlanStatus status;
  final List<PlanBrandSp> brands; // القائمة الحالية (المعدلة بالكميات)
  final Failure? failure;

  const PlanManagementState({
    this.status = PlanStatus.initial,
    this.brands = const [],
    this.failure,
  });

  // دالة copyWith اليدوية لتحديث متغيرات معينة والحفاظ على الباقي
  PlanManagementState copyWith({
    PlanStatus? status,
    List<PlanBrandSp>? brands,
    Failure? failure,
  }) {
    return PlanManagementState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, brands, failure];
}