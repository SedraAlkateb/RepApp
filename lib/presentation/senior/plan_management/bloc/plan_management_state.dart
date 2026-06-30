part of 'plan_management_bloc.dart';

enum PlanStatus { initial, loading, success, error, submitting, submitSuccess }

class PlanManagementState extends Equatable {
  final PlanStatus status;
  final List<PlanBrandSp> brands;       // 1. القائمة الأصلية الكاملة القادمة من الـ API
  final List<PlanBrandSp> searchBrands; // 2. 🚀 القائمة المفلترة المخصصة للعرض والبحث في الـ UI
  final Failure? failure;
  final bool isEnable;                  // المتغير المسؤول عن قفل وفتح الحقول في الـ UI

  const PlanManagementState({
    this.status = PlanStatus.initial,
    this.brands = const [],
    this.searchBrands = const [], // القيمة الافتراضية مصفوفة فارغة
    this.failure,
    this.isEnable = true,
  });

  // 🟢 دالة copyWith المحدثة لدعم مصفوفة البحث
  PlanManagementState copyWith({
    PlanStatus? status,
    List<PlanBrandSp>? brands,
    List<PlanBrandSp>? searchBrands, // 👈 استقبال مصفوفة البحث المفلترة
    Failure? failure,
    bool? isEnable,
  }) {
    return PlanManagementState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      searchBrands: searchBrands ?? this.searchBrands, // 👈 إسناد القيمة الجديدة أو الحفاظ على الحالية
      failure: failure ?? this.failure,
      isEnable: isEnable ?? this.isEnable,
    );
  }

  @override
  // 💡 تم إضافة searchBrands هنا لكي يتحسس الـ BlocBuilder أي تغيير يحدث أثناء تصفية البحث ويرسم الكروت فوراً
  List<Object?> get props => [status, brands, searchBrands, failure, isEnable];
}