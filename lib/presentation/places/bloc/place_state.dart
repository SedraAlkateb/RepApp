part of 'place_bloc.dart';

@immutable
abstract class PlaceState extends Equatable{}

final class PlaceInitial extends PlaceState {
  @override
  List<Object?> get props => [];
}
final class AllPlaceState extends PlaceState {
final List<PlaceModel> places;
  AllPlaceState(this.places);
  @override
  List<Object?> get props =>[places];
}
final class AllPlaceErrorState extends PlaceState {
  final Failure failure;
  AllPlaceErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllPlaceLoadingState extends PlaceState {
  @override
  AllPlaceLoadingState();
  @override
  List<Object?> get props =>[];
}

final class SearchPlaceState extends PlaceState {
final List<PlaceModel> places;
  SearchPlaceState(this.places);
  @override
  List<Object?> get props =>[places];
}

////////////
final class CheckRepState extends PlaceState {
final bool isCheck;
  CheckRepState(this.isCheck);
  @override
  List<Object?> get props =>[isCheck];
}
final class CheckRepErrorState extends PlaceState {
  final Failure failure;
  CheckRepErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class CheckRepLoadingState extends PlaceState {
  @override
  CheckRepLoadingState();
  @override
  List<Object?> get props =>[];
}
final class NumVisitState extends PlaceState {

  List<Object?> get props =>[];
}
final class NumVisitErrorState extends PlaceState {
  final Failure failure;
  NumVisitErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

final class AllDoctorArchiveByPlaceErrorState extends PlaceState {
  final Failure failure;
  AllDoctorArchiveByPlaceErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllDoctorArchiveByPlaceState extends PlaceState {
  final List<DoctorModel> searchData;
  final List<DoctorModel> BaseData;

  @override
  AllDoctorArchiveByPlaceState({required this.searchData, required this.BaseData});
  @override
  List<Object?> get props =>[searchData];
}
final class AllHospitalArchiveByPlaceErrorState extends PlaceState {
  final Failure failure;
  AllHospitalArchiveByPlaceErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllHospitalArchiveByPlaceState extends PlaceState {
  final List<HospitalModel> searchData;
  final List<HospitalModel> baseData;

  @override
  AllHospitalArchiveByPlaceState({required this.searchData,required this.baseData});
  @override
  List<Object?> get props =>[searchData];
}
final class EmptyArchiveState extends PlaceState {

  @override
  List<Object?> get props =>[];
}