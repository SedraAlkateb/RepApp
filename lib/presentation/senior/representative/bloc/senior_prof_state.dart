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
  final List<HospitalSpModel> hospital;
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
  final int planId;

  SenNoVisitDocErrorState({required this.failure,required this.planId});
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
  final int planId;
  SenVisitDocErrorState({required this.failure,required this.planId});
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

final class SenAllBrandsState extends SeniorProfState {
  final List<BrandModel> brand;
  SenAllBrandsState(this.brand);
  @override
  List<Object?> get props =>[brand];
}
final class  SenAllBrandErrorState extends SeniorProfState {
  final Failure failure;
  SenAllBrandErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  SenAllBrandLoadingState extends SeniorProfState {
  @override
  SenAllBrandLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  SenAllBrandEmptyState extends SeniorProfState {
  @override
  SenAllBrandEmptyState();
  @override
  List<Object?> get props =>[];
}

final class AllReciState extends SeniorProfState {
  final List<ReciModel> reci;
  AllReciState(this.reci);
  @override
  List<Object?> get props =>[reci];
}
final class AllReciErrorState extends SeniorProfState {
  final Failure failure;
  AllReciErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllReciLoadingState extends SeniorProfState {
  @override
  AllReciLoadingState();
  @override
  List<Object?> get props =>[];
}
final class AllReciEmptyState extends SeniorProfState {
  @override
  AllReciEmptyState();
  @override
  List<Object?> get props =>[];
}
final class ViewRecipeState extends SeniorProfState {
  final CopyReciRequest copyRecipeRequest;
  final bool isDoctor;
  final String name;
  ViewRecipeState(this.copyRecipeRequest,this.isDoctor,this.name);
  List<Object?> get props => [copyRecipeRequest,isDoctor,name];
}
final class ViewRecipeErrorState extends SeniorProfState {
  final Failure failure;
  ViewRecipeErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class ViewRecipeLoadingState extends SeniorProfState {
  @override
  List<Object?> get props => [];
}
//
