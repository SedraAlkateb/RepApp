part of 'order_bloc.dart';

@immutable
sealed class OrderState extends Equatable {}

final class OrderInitial extends OrderState {
  @override
  List<Object?> get props => [];
}

// حالات إرسال الطلب (Pharmacy Order)
final class PharmacyOrderLoadingState extends OrderState {
  @override
  List<Object?> get props => [];
}

final class PharmacyOrderState extends OrderState {
  final Message1Response message;
  PharmacyOrderState(this.message);
  @override
  List<Object?> get props => [message];
}

final class PharmacyOrderErrorState extends OrderState {
  final Failure failure;
  PharmacyOrderErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

// حالات جلب البراندات وإدارة القائمة (Brand Order & List Management)
final class BrandOrderLoadingState extends OrderState {
  @override
  List<Object?> get props => [];
}

final class BrandOrderState extends OrderState {
  final List<BrandModel> brands;           // قائمة الدروب داون الثابتة
  final List<OrderDetails> selectedItems; // القائمة التي تظهر في الـ ListView

  // نمرر قائمة فارغة كقيمة افتراضية للـ selectedItems
  BrandOrderState(this.brands, {this.selectedItems = const []});

  @override
  List<Object?> get props => [brands, selectedItems];
}

final class BrandOrderErrorState extends OrderState {
  final Failure failure;
  BrandOrderErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}