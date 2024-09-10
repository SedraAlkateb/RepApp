part of 'place_visit_bloc.dart';

@immutable
sealed class PlaceVisitEvent extends Equatable{
}
class PharmacyByPlace extends PlaceVisitEvent{
final  int placeId;
  PharmacyByPlace(this.placeId);
  @override


  List<Object?> get props => [placeId];

}
class DoctorByPlace extends PlaceVisitEvent{
  final  int placeId;
  DoctorByPlace(this.placeId);
  @override


  List<Object?> get props => [placeId];

}
class HospitalByPlace extends PlaceVisitEvent{
  final  int placeId;
  HospitalByPlace(this.placeId);
  @override


  List<Object?> get props => [placeId];

}


class BrandFlagEvent extends PlaceVisitEvent{

  BrandFlagEvent();
  @override


  List<Object?> get props => [];

}
class SelectBrandEvent extends PlaceVisitEvent{
final  BrandModel brandModel;
  SelectBrandEvent(this.brandModel);
  @override


  List<Object?> get props => [];

}