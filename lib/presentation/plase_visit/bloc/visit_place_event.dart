part of 'visit_place_bloc.dart';

@immutable
sealed class VisitPlaceEvent extends Equatable{
}
class PharmacyByPlace extends VisitPlaceEvent{
  final  int placeId;
  final current;
  PharmacyByPlace(this.placeId,this.current);
  @override


  List<Object?> get props => [placeId,current];

}
class DoctorByPlace extends VisitPlaceEvent{
  final  int placeId;
  final current;
  DoctorByPlace(this.placeId,this.current);
  @override


  List<Object?> get props => [placeId,current];

}
class HospitalByPlace extends VisitPlaceEvent{
  final  int placeId;
  final current;
  HospitalByPlace(this.placeId,this.current);
  @override


  List<Object?> get props => [placeId,current];

}
class BrandFlagEvent extends VisitPlaceEvent{

  BrandFlagEvent();
  @override


  List<Object?> get props => [];

}
class SelectBrandEvent extends VisitPlaceEvent{
  final  BrandModel brandModel;
  SelectBrandEvent(this.brandModel);
  @override


  List<Object?> get props => [brandModel];

}