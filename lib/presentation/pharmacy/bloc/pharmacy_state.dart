part of 'pharmacy_bloc.dart';

@immutable
sealed class PharmacyState {}

final class PharmacyInitial extends PharmacyState {}
final class AllPharmacyState extends PharmacyState {
  final List<PharmacyModel> pharmacy;
  AllPharmacyState(this.pharmacy);
  @override
  List<Object?> get props =>[pharmacy];
}
final class AllPharmacyErrorState extends PharmacyState {
  final Failure failure;
  AllPharmacyErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllPharmacyLoadingState extends PharmacyState {
  @override
  AllPharmacyLoadingState();
  @override
  List<Object?> get props =>[];
}