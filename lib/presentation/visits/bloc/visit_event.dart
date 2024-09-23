part of 'visit_bloc.dart';

@immutable
sealed class VisitEvent extends Equatable {}
class VisitPharmacyEvent extends VisitEvent{

  VisitPharmacyEvent();
  @override
  List<Object?> get props => [];

}
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
class VisitBrandPharmacyEvent extends VisitEvent{

  VisitBrandPharmacyEvent();
  @override
  List<Object?> get props => [];

}
class BrandPharmacyVisitEvent extends VisitEvent{
final int visitId;
  BrandPharmacyVisitEvent(this.visitId);
  @override
  List<Object?> get props => [visitId];

}
class BrandDoctorVisitEvent extends VisitEvent{
  final int visitId;
  BrandDoctorVisitEvent(this.visitId);
  @override
  List<Object?> get props => [visitId];

}