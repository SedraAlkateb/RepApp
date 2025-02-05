part of 'senior_prof_bloc.dart';

@immutable
sealed class SeniorProfState extends Equatable {}

final class SeniorProfInitial extends SeniorProfState {
  @override
  List<Object?> get props => [];
}
final class SenAllPlaceState extends SeniorProfState {
  final List<PlaceModel> places;
  SenAllPlaceState(this.places);
  @override
  List<Object?> get props =>[places];
}
final class SenAllPlaceErrorState extends SeniorProfState {
  final Failure failure;
  SenAllPlaceErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class SenAllPlaceLoadingState extends SeniorProfState {
  @override
  SenAllPlaceLoadingState();
  @override
  List<Object?> get props =>[];
}
//////////////////// |Spec

final class SenAllSpecState extends SeniorProfState {
  final List<SpecDModel> Specs;
  SenAllSpecState(this.Specs);
  @override
  List<Object?> get props =>[Specs];
}
final class SenAllSpecErrorState extends SeniorProfState {
  final Failure failure;
  SenAllSpecErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

final class SenAllSpecLoadingState extends SeniorProfState {
  @override
  SenAllSpecLoadingState();
  @override
  List<Object?> get props =>[];
}

final class SenAllHospitalsState extends SeniorProfState {
  final List<HospitalModel> hospital;
  SenAllHospitalsState(this.hospital);
  @override
  List<Object?> get props =>[hospital];
}
final class  SenAllHospitalErrorState extends SeniorProfState {
  final Failure failure;
  SenAllHospitalErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  SenAllHospitalLoadingState extends SeniorProfState {
  @override
  SenAllHospitalLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  SenAllHospitalEmptyState extends SeniorProfState {
  @override
  SenAllHospitalEmptyState();
  @override
  List<Object?> get props =>[];
}

final class SenAllDoctorsState extends SeniorProfState {
  final List<DoctorModel> doctor;
  SenAllDoctorsState(this.doctor);
  @override
  List<Object?> get props =>[doctor];
}
final class  SenAllDoctorErrorState extends SeniorProfState {
  final Failure failure;
  SenAllDoctorErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  SenAllDoctorLoadingState extends SeniorProfState {
  @override
  SenAllDoctorLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  SenAllDoctorEmptyState extends SeniorProfState {
  @override
  SenAllDoctorEmptyState();
  @override
  List<Object?> get props =>[];
}


final class SenNoVisitDocsState extends SeniorProfState {
  final List<NoVisitDocModel> noVisitDoc;
  SenNoVisitDocsState(this.noVisitDoc);
  @override
  List<Object?> get props =>[noVisitDoc];
}
final class  SenNoVisitDocErrorState extends SeniorProfState {
  final Failure failure;
  SenNoVisitDocErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  SenNoVisitDocLoadingState extends SeniorProfState {
  @override
  SenNoVisitDocLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  SenNoVisitDocEmptyState extends SeniorProfState {
  @override
  SenNoVisitDocEmptyState();
  @override
  List<Object?> get props =>[];
}


final class SenVisitDocsState extends SeniorProfState {
  final List<NoVisitDocModel> visitDoc;
  SenVisitDocsState(this.visitDoc);
  @override
  List<Object?> get props =>[visitDoc];
}
final class  SenVisitDocErrorState extends SeniorProfState {
  final Failure failure;
  SenVisitDocErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  SenVisitDocLoadingState extends SeniorProfState {
  @override
  SenVisitDocLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  SenVisitDocEmptyState extends SeniorProfState {
  @override
  SenVisitDocEmptyState();
  @override
  List<Object?> get props =>[];
}


final class RepInfoState extends SeniorProfState {
  final InfoRep infoRep;
  RepInfoState(this.infoRep);
  @override
  List<Object?> get props =>[infoRep];
}
final class  RepInfoErrorState extends SeniorProfState {
  final Failure failure;
  RepInfoErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  RepInfoLoadingState extends SeniorProfState {
  @override
  RepInfoLoadingState();
  @override
  List<Object?> get props =>[];
}