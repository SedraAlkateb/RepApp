part of 'visit_place_bloc.dart';

@immutable
abstract class VisitPlaceEvent extends Equatable {}
// class PharmacyByPlace extends VisitPlaceEvent{
//   final  int placeId;
//   final current;
//   PharmacyByPlace(this.placeId,this.current);
//   @override
//   @override
//   List<Object?> get props => [placeId,current];
// }
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
class BrandAnyFlagEvent extends VisitPlaceEvent{

  BrandAnyFlagEvent();
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

class SelectBrandAdditionAddEvent extends VisitPlaceEvent{
  final  BrandModel brand;
  SelectBrandAdditionAddEvent(this.brand);
  @override
  List<Object?> get props => [brand];
}
class SelectNumBrandAddEvent extends VisitPlaceEvent{
  final  String num;
  SelectNumBrandAddEvent(this.num);
  @override
  List<Object?> get props => [num];
}
class TypeAdditionEvent extends VisitPlaceEvent{
final  Type type;
  TypeAdditionEvent(this.type);
  @override
  List<Object?> get props => [type];
}
class SelectSpecEvent extends VisitPlaceEvent{
  final SpecHospitalSp spec;
  SelectSpecEvent(this.spec);
  @override
  List<Object?> get props => [spec];
}
// class InsertVisitPharmacyEvent extends VisitPlaceEvent{
//   final  VisitPharmacyModel visitPharmacyModel;
//   InsertVisitPharmacyEvent(this.visitPharmacyModel);
//   @override
//   List<Object?> get props => [visitPharmacyModel];
// }
// class InsertBrandVisitEvent extends VisitPlaceEvent{
//   final VisitPharmacyModel visitPharmacyModel;
//   InsertBrandVisitEvent(this.visitPharmacyModel);
//   @override
//   List<Object?> get props => [];
// }
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
 final int hospitalId;
  InsertBrandVisitHospitalEvent(this.visitHospitalModel,this.hospitalId);
  @override
  List<Object?> get props => [visitHospitalModel,hospitalId];
}
class InsertVisitHospitalEvent extends VisitPlaceEvent{
  final  VisitHospitalModel visitHospitalModel;
  final int hospitalId;
  InsertVisitHospitalEvent(this.visitHospitalModel,this.hospitalId);
  @override
  List<Object?> get props => [visitHospitalModel,hospitalId];
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
class RemoveBrandAdditionEvent extends VisitPlaceEvent {
  final  BrandAddition brandAddition;
  RemoveBrandAdditionEvent(this.brandAddition);
  @override
  List<Object?> get props => [brandAddition];
}
class IsScienceEvent extends VisitPlaceEvent {
  final  int isScience;
  IsScienceEvent(this.isScience);
  @override
  List<Object?> get props => [isScience];
}
class SearchDoctorVisitEvent extends VisitPlaceEvent{

  final String value;
  SearchDoctorVisitEvent({required this.value});
  @override

  List<Object?> get props => [];
}
class SearchHospitalVisitEvent extends VisitPlaceEvent{

  final String value;
  SearchHospitalVisitEvent({required this.value});
  @override

  List<Object?> get props => [];
}
class EndEvent extends VisitPlaceEvent{

  @override

  List<Object?> get props => [];
}
class BoxAddEvent extends VisitPlaceEvent{
final String n;
BoxAddEvent(this.n);
  @override

  List<Object?> get props => [n];
}

// class SearchPharmacyVisitEvent extends VisitPlaceEvent{
//
//   final String value;
//   SearchPharmacyVisitEvent({required this.value});
//   @override
//
//   List<Object?> get props => [];
// }