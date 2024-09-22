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
  final int pharmacyId;
  SelectBrandEvent(this.brandModel,this.pharmacyId);
  @override


  List<Object?> get props => [brandModel];

}

class InsertVisitPharmacyEvent extends VisitPlaceEvent{
  final  VisitPharmacyModel visitPharmacyModel;
  InsertVisitPharmacyEvent(this.visitPharmacyModel);
  @override


  List<Object?> get props => [visitPharmacyModel];

}
class InsertBrandVisitEvent extends VisitPlaceEvent{
  VisitPharmacyModel visitPharmacyModel;
  InsertBrandVisitEvent(this.visitPharmacyModel);
  @override
  List<Object?> get props => [];

}
class InsertVisitDoctorEvent extends VisitPlaceEvent{
  final  VisitDoctorModel visitDoctorModel;
  InsertVisitDoctorEvent(this.visitDoctorModel);
  @override


  List<Object?> get props => [visitDoctorModel];

}
class EditAmountBrandEvent extends VisitPlaceEvent{
  final  int index;
  final int brand;
  EditAmountBrandEvent(this.index,this.brand);
  @override


  List<Object?> get props => [index,brand];

}
class RemoveBrandEvent extends VisitPlaceEvent {
 
  final  BrandModel brandModel;
  RemoveBrandEvent(this.brandModel);
  
  @override
  
  List<Object?> get props => [brandModel];
}