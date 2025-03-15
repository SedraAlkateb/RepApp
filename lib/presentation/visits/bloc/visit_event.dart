part of 'visit_bloc.dart';

@immutable
sealed class VisitEvent extends Equatable {}
// class VisitPharmacyEvent extends VisitEvent{
//
//   VisitPharmacyEvent();
//   @override
//   List<Object?> get props => [];
//
// }
class VisitDoctorEvent extends VisitEvent{

  VisitDoctorEvent();
  @override
  List<Object?> get props => [];

  
}
class VisitHospitalEvent extends VisitEvent{

  VisitHospitalEvent();
  @override
  List<Object?> get props => [];

}
// class VisitBrandPharmacyEvent extends VisitEvent{
//
//   VisitBrandPharmacyEvent();
//   @override
//   List<Object?> get props => [];
//
// }
// class BrandPharmacyVisitEvent extends VisitEvent{
// final int visitId;
//   BrandPharmacyVisitEvent(this.visitId);
//   @override
//   List<Object?> get props => [visitId];
//
// }
class BrandDoctorVisitEvent extends VisitEvent{
  final int visitId;
  BrandDoctorVisitEvent(this.visitId);
  @override
  List<Object?> get props => [visitId];

}

class BrandHospitalVisitEvent extends VisitEvent{
  final int visitId;
  BrandHospitalVisitEvent(this.visitId);
  @override
  List<Object?> get props => [visitId];

}
class SearchDoctorVisitEvent extends VisitEvent{

  final String value;
  SearchDoctorVisitEvent({required this.value});
  @override

  List<Object?> get props => [value];
}
class SearchHospitalVisitEvent extends VisitEvent{

  final String value;
  SearchHospitalVisitEvent({required this.value});
  @override

  List<Object?> get props => [];
}
// class SearchPharmacyVisitEvent extends VisitEvent{
//
//   final String value;
//   SearchPharmacyVisitEvent({required this.value});
//   @override
//
//   List<Object?> get props => [];
// }

class UpdateVisitDoctorEvent extends VisitEvent{
 final int id;
 final String? kas;
 final  String? sc;
 final String? target;
 final  List<PharmacyBrandModel>? selectBrand;
  UpdateVisitDoctorEvent({ this.kas,this.sc, required this.id,this.target,this.selectBrand});
  @override
  List<Object?> get props => [kas,sc];
}
class UpdateVisitHospitalEvent extends VisitEvent{
  final int id;
  final String? kas;
  final  String? sc;
  final String? target;
  final  List<PharmacyBrandModel>? selectBrand;
  UpdateVisitHospitalEvent({ this.kas,this.sc, required this.id,this.target,this.selectBrand});
  @override
  List<Object?> get props => [kas,sc];
}
class UpdateVisitPharmacyEvent extends VisitEvent{
  final int id;
  final String data;
  UpdateVisitPharmacyEvent({ required this.data, required this.id});
  @override
  List<Object?> get props => [data];
}

class IsBrandEvent extends VisitEvent {

  @override
  List<Object?> get props => [];
}
class BrandFlagEditeEvent extends VisitEvent{
  BrandFlagEditeEvent();
  @override
  List<Object?> get props => [];
}
class SelectBrandEvent extends VisitEvent{
  final  BrandModel brandModel;
  SelectBrandEvent(this.brandModel);
  @override
  List<Object?> get props => [brandModel];
}
class RemoveBrandEvent extends VisitEvent {
  final  PharmacyBrandModel brandModel;
  RemoveBrandEvent(this.brandModel);
  @override
  List<Object?> get props => [brandModel];
}
class EditAmountBrandEvent extends VisitEvent{
  final  int index;
  final int brand;
  EditAmountBrandEvent(this.index,this.brand);
  @override
  List<Object?> get props => [index,brand];
}