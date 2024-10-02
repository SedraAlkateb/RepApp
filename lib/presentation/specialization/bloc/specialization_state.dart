part of 'specialization_bloc.dart';

@immutable
sealed class SpecializationState extends Equatable{}

final class SpecializationInitial extends SpecializationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class AllSpecState extends SpecializationState {
  final List<SpecModel> Specs;
  AllSpecState(this.Specs);
  @override
  List<Object?> get props =>[Specs];
}
final class AllSpecErrorState extends SpecializationState {
  final Failure failure;
  AllSpecErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllSpecLoadingState extends SpecializationState {
  @override
  AllSpecLoadingState();
  @override
  List<Object?> get props =>[];
}
final class AllDoctorSpState extends SpecializationState {
 final List<DoctorModel> doctors;
  @override
  AllDoctorSpState(this.doctors);
  @override
  List<Object?> get props =>[doctors];
}
final class AllHospitalSpState extends SpecializationState {
 final List<HospitalModel> hospitals;
  AllHospitalSpState(this.hospitals);
  @override
  List<Object?> get props =>[hospitals];
}
final class AllSpecDoctorErrorState extends SpecializationState {
  final Failure failure;
  AllSpecDoctorErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllSpecHospitalErrorState extends SpecializationState {
  final Failure failure;
  AllSpecHospitalErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}