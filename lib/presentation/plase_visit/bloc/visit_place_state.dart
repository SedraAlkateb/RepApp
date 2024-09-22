part of 'visit_place_bloc.dart';

@immutable
sealed class VisitPlaceState extends Equatable {}

final class VisitPlaceInitial extends VisitPlaceState {
  @override
  List<Object?> get props => [];
}
final class AllPharmacyByPlaceState extends VisitPlaceState {
  final List<PharmacyModel> pharmacy;
  AllPharmacyByPlaceState(this.pharmacy);
  @override
  List<Object?> get props =>[pharmacy];
}
final class AllPharmacyByPlaceErrorState extends VisitPlaceState {
  final Failure failure;
  AllPharmacyByPlaceErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllPharmacyByPlaceLoadingState extends VisitPlaceState {
  @override
  AllPharmacyByPlaceLoadingState();
  @override
  List<Object?> get props =>[];
}

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

class SelectBrandState extends VisitPlaceState{
  final List<BrandModel> brands;
  SelectBrandState(this.brands);
  List<Object?> get props => [brands];
}
class EditAmountBrandState extends VisitPlaceState{
  final List<VisitBrandPharmacyModel> brands;
  EditAmountBrandState(this.brands);
  List<Object?> get props => [brands];
}

class  EditBrandState extends VisitPlaceState{
  final List<BrandModel> brands;
  EditBrandState(this.brands);
  List<Object?> get props => [brands];
}



class DeleteBrandState extends VisitPlaceState{
  @override
  final List<BrandModel> brands;
  DeleteBrandState(this.brands);
  List<Object?> get props => [brands];

}

final class InsertVisitPharmacyErrorState extends VisitPlaceState {
  final Failure failure;
  InsertVisitPharmacyErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class InsertVisitPharmacyLoadingState extends VisitPlaceState {

  @override

  List<Object?> get props =>[];
}
final class InsertVisitPharmacyState extends VisitPlaceState {
  @override
  InsertVisitPharmacyState();
  @override
  List<Object?> get props =>[];
}

final class InsertVisitDoctorErrorState extends VisitPlaceState {
  final Failure failure;
  InsertVisitDoctorErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class InsertVisitDoctorState extends VisitPlaceState {
  @override
  InsertVisitDoctorState();
  @override
  List<Object?> get props =>[];
}


final class AllVisitBrandPharmacyErrorState extends VisitPlaceState {
  final Failure failure;
  AllVisitBrandPharmacyErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class AllVisitBrandPharmacyState extends VisitPlaceState {
  @override
  AllVisitBrandPharmacyState();
  @override
  List<Object?> get props =>[];
}
final class AllVisitBrandPharmacyLoadingState extends VisitPlaceState {
  @override
  AllVisitBrandPharmacyLoadingState();
  @override
  List<Object?> get props =>[];
}
