part of 'plan_management_bloc.dart';

enum PlanStatus { initial, loading, success, error, submitting, submitSuccess }

class PlanManagementState extends Equatable {
  final PlanStatus status;
  final List<PlanBrandSp> brands; // القائمة الحالية (المعدلة بالكميات)
  final Failure? failure;
  final bool isEnable; // 🚀 المتغير المسؤول عن قفل وفتح الحقول في الـ UI

  const PlanManagementState({
    this.status = PlanStatus.initial,
    this.brands = const [],
    this.failure,
    this.isEnable = true, // القيمة الافتراضية تكون مفتوحة لحين فحصها
  });

  // 🟢 دالة copyWith اليدوية بعد تصحيح خطأ الـ Syntax
  PlanManagementState copyWith({
    PlanStatus? status,
    List<PlanBrandSp>? brands,
    Failure? failure,
    bool? isEnable, // تمرير القيمة بشكل برمجى صحيح
  }) {
    return PlanManagementState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      failure: failure ?? this.failure,
      isEnable: isEnable ?? this.isEnable,
    );
  }

  @override
  List<Object?> get props => [status, brands, failure, isEnable]; // إضافة isEnable هنا لضمان تحسس التغيير وريفريش الـ UI
}