part of 'place_visit_bloc.dart';

@immutable
sealed class PlaceVisitState extends Equatable {}

final class PlaceVisitInitial extends PlaceVisitState {
  @override
  List<Object?> get props => [];
}
final class AllPharmacyByPlaceState extends PlaceVisitState {
  final List<PharmacyModel> pharmacy;
  AllPharmacyByPlaceState(this.pharmacy);
  @override
  List<Object?> get props =>[pharmacy];
}
final class AllPharmacyByPlaceErrorState extends PlaceVisitState {
  final Failure failure;
  AllPharmacyByPlaceErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllPharmacyByPlaceLoadingState extends PlaceVisitState {
  @override
  AllPharmacyByPlaceLoadingState();
  @override
  List<Object?> get props =>[];
}

final class BrandFlagState extends PlaceVisitState {
  final List<BrandModel> brands;
  BrandFlagState(this.brands);
  @override
  List<Object?> get props =>[brands];
}
final class BrandFlagErrorState extends PlaceVisitState {
  final Failure failure;
  BrandFlagErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
class SelectBrandState extends PlaceVisitState{
  @override
  final List<BrandModel> brands;
  SelectBrandState(this.brands);
  List<Object?> get props => [brands];

}