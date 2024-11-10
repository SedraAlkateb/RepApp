part of 'visit_place_bloc.dart';

@immutable
sealed class VisitPlaceState extends Equatable {}

final class VisitPlaceInitial extends VisitPlaceState {
  @override
  List<Object?> get props => [];
}
// final class AllPharmacyByPlaceState extends VisitPlaceState {
//   final List<PharmacyModel> pharmacy;
//   AllPharmacyByPlaceState(this.pharmacy);
//   @override
//   List<Object?> get props =>[pharmacy];
// }
// final class AllPharmacyByPlaceErrorState extends VisitPlaceState {
//   final Failure failure;
//   AllPharmacyByPlaceErrorState({required this.failure});
//   @override
//
//   List<Object?> get props =>[failure];
// }
// final class AllPharmacyByPlaceLoadingState extends VisitPlaceState {
//   @override
//   AllPharmacyByPlaceLoadingState();
//   @override
//   List<Object?> get props =>[];
// }

final class AllDoctorByPlaceErrorState extends VisitPlaceState {
  final Failure failure;
  AllDoctorByPlaceErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllDoctorByPlaceState extends VisitPlaceState {
  final List<DoctorModel> data;
  @override
  AllDoctorByPlaceState(this.data);
  @override
  List<Object?> get props =>[data];
}
final class AllHospitalByPlaceErrorState extends VisitPlaceState {
  final Failure failure;
  AllHospitalByPlaceErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllHospitalByPlaceState extends VisitPlaceState {
  final List<HospitalModel> data;
  @override
  AllHospitalByPlaceState(this.data);
  @override
  List<Object?> get props =>[data];
}

final class BrandFlagState extends VisitPlaceState {
  final List<BrandModel> brands;
  BrandFlagState(this.brands);
  @override
  List<Object?> get props =>[brands];
}
final class BrandFlagErrorState extends VisitPlaceState {
  final Failure failure;
  BrandFlagErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class EmptyState extends VisitPlaceState {

  @override
  List<Object?> get props =>[];
}
class SelectBrandState extends VisitPlaceState{
  final List<BrandModel> brands;
  SelectBrandState(this.brands);
  List<Object?> get props => [brands];
}
class SelectBrandAddState extends VisitPlaceState{

  SelectBrandAddState();
  List<Object?> get props => [];
}
class SelectBrandAddNumState extends VisitPlaceState{
  final List<BrandAddition> brands;
  SelectBrandAddNumState(this.brands);
  List<Object?> get props => [brands];
}
class EditAmountBrandState extends VisitPlaceState{
  final List<VisitBrandPharmacyModel> brands;
  EditAmountBrandState(this.brands);
  List<Object?> get props => [brands];
}
class EditAmountBrandAddState extends VisitPlaceState{
  final List<VisitBrandPharmacyModel> brands;
  EditAmountBrandAddState(this.brands);
  List<Object?> get props => [brands];
}

class  EditBrandState extends VisitPlaceState{
  final List<BrandModel> brands;
  EditBrandState(this.brands);
  List<Object?> get props => [brands];
}



class DeleteBrandState extends VisitPlaceState{
  final List<BrandModel> brands;
  DeleteBrandState(this.brands);
  @override
  List<Object?> get props => [brands];
}
class DeleteBrandAddState extends VisitPlaceState{
  final List<BrandAddition> brands;
  DeleteBrandAddState(this.brands);
  @override
  List<Object?> get props => [brands];
}
final class InsertVisitDoctorLoadingState extends VisitPlaceState {
  @override
  List<Object?> get props =>[];
}

// final class InsertVisitPharmacyState extends VisitPlaceState {
//   @override
//   InsertVisitPharmacyState();
//   @override
//   List<Object?> get props =>[];
// }

final class InsertVisitDoctorErrorState extends VisitPlaceState {
  final Failure failure;
  InsertVisitDoctorErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class InsertVisitDoctorState extends VisitPlaceState {
  InsertVisitDoctorState();
  @override
  List<Object?> get props =>[];
}

final class InsertVisitHospitalErrorState extends VisitPlaceState {
  final Failure failure;
  InsertVisitHospitalErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class InsertVisitHospitalState extends VisitPlaceState {
  InsertVisitHospitalState();
  @override
  List<Object?> get props =>[];
}

// final class AllVisitBrandPharmacyErrorState extends VisitPlaceState {
//   final Failure failure;
//   AllVisitBrandPharmacyErrorState({required this.failure});
//   @override
//   List<Object?> get props =>[failure];
// }
// final class AllVisitBrandPharmacyState extends VisitPlaceState {
//   @override
//   AllVisitBrandPharmacyState();
//   @override
//   List<Object?> get props =>[];
// }
final class AllVisitBrandPharmacyLoadingState extends VisitPlaceState {
  @override
  AllVisitBrandPharmacyLoadingState();
  @override
  List<Object?> get props =>[];
}
final class AllVisitBrandDoctorErrorState extends VisitPlaceState {
  final Failure failure;
  AllVisitBrandDoctorErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class AllVisitBrandDoctorState extends VisitPlaceState {
  @override
  AllVisitBrandDoctorState();
  @override
  List<Object?> get props =>[];
}
final class AllVisitBrandDoctorLoadingState extends VisitPlaceState {
  @override
  AllVisitBrandDoctorLoadingState();
  @override
  List<Object?> get props =>[];
}

final class AllVisitBrandHospitalState extends VisitPlaceState {
  @override
  AllVisitBrandHospitalState();
  @override
  List<Object?> get props =>[];
}
final class AllVisitBrandHospitalErrorState extends VisitPlaceState {
  final Failure failure;
  AllVisitBrandHospitalErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}


final class SpecializationHospitalState extends VisitPlaceState {
  @override
final  List<SpecHospitalSp> specialization;
  SpecializationHospitalState(this.specialization);
  @override
  List<Object?> get props =>[specialization];
}
final class SpecializationHospitalErrorState extends VisitPlaceState {
  final Failure failure;
  SpecializationHospitalErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class SpecState extends VisitPlaceState {
  final int  total;
  final int  visits;
  final int  visited;
  SpecState({required this.total,required this.visits,required this.visited});
  @override
  List<Object?> get props =>[total,visits,visited];
}
final class BoxState extends VisitPlaceState {
final String value;
BoxState(this.value);
  @override
  List<Object?> get props =>[value];
}
final class DropDownState extends VisitPlaceState {
  final String value;
  DropDownState(this.value);
  @override
  List<Object?> get props =>[value];
}
class NothingState extends VisitPlaceState{
  NothingState();
@override
List<Object?> get props =>[];
}
class IsScienceState extends VisitPlaceState {
  final  int isScience;
  IsScienceState(this.isScience);
  @override
  List<Object?> get props => [isScience];
}
final class SearchVisitDoctorState extends VisitPlaceState {
final List<DoctorModel> doctorVisit;
  SearchVisitDoctorState(this.doctorVisit);
  @override
  List<Object?> get props =>[doctorVisit];
}
final class SearchVisitHospitalState extends VisitPlaceState {
final List<HospitalModel> hospitalVisit;
  SearchVisitHospitalState(this.hospitalVisit);
  @override
  List<Object?> get props =>[hospitalVisit];
}
// final class SearchVisitPharmacyState extends VisitPlaceState {
// final List<PharmacyModel> pharmasyVisit;
//   SearchVisitPharmacyState(this.pharmasyVisit);
//   @override
//   List<Object?> get props =>[pharmasyVisit];
// }
class EndState extends VisitPlaceState{

  @override

  List<Object?> get props => [];
}
