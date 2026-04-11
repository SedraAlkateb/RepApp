part of 'order_bloc.dart';

@immutable
sealed class OrderState extends Equatable{}

final class OrderInitial extends OrderState {
  @override
  List<Object?> get props => [];
}

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

final class BrandOrderLoadingState extends OrderState {
  @override
  List<Object?> get props => [];
}
final class BrandOrderState extends OrderState {
  final List<BrandModel> brands;
  BrandOrderState(this.brands);
  @override
  List<Object?> get props => [brands];
}
final class BrandOrderErrorState extends OrderState {
  final Failure failure;
  BrandOrderErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}