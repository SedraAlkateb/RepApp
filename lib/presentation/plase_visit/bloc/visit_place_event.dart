part of 'visit_place_bloc.dart';

@immutable
abstract class VisitPlaceEvent extends Equatable{
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
class SelectSpecEvent extends VisitPlaceEvent{
  final int spec;
  SelectSpecEvent(this.spec);
  @override
  List<Object?> get props => [spec];
}
class InsertVisitPharmacyEvent extends VisitPlaceEvent{
  final  VisitPharmacyModel visitPharmacyModel;
  InsertVisitPharmacyEvent(this.visitPharmacyModel);
  @override
  List<Object?> get props => [visitPharmacyModel];
}
class InsertBrandVisitEvent extends VisitPlaceEvent{
  final VisitPharmacyModel visitPharmacyModel;
  InsertBrandVisitEvent(this.visitPharmacyModel);
  @override
  List<Object?> get props => [];
}
class InsertBrandVisitDoctorEvent extends VisitPlaceEvent{
  final VisitDoctorModel visitDoctorModel;
  InsertBrandVisitDoctorEvent(this.visitDoctorModel);
  @override
  List<Object?> get props => [visitDoctorModel];
}
class InsertVisitDoctorEvent extends VisitPlaceEvent{
  final  VisitDoctorModel visitDoctorModel;
  InsertVisitDoctorEvent(this.visitDoctorModel);
  @override
  List<Object?> get props => [visitDoctorModel];
}
class SpecializationHospitalEvent extends VisitPlaceEvent{
  final  int hospitalId;
  SpecializationHospitalEvent(this.hospitalId);
  @override
  List<Object?> get props => [hospitalId];
}
class InsertBrandVisitHospitalEvent extends VisitPlaceEvent{
 final VisitHospitalModel visitHospitalModel;
  InsertBrandVisitHospitalEvent(this.visitHospitalModel);
  @override
  List<Object?> get props => [visitHospitalModel];
}
class InsertVisitHospitalEvent extends VisitPlaceEvent{
  final  VisitHospitalModel visitHospitalModel;
  InsertVisitHospitalEvent(this.visitHospitalModel);
  @override
  List<Object?> get props => [visitHospitalModel];
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