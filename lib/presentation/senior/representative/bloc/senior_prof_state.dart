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

final class SenAllNoteDoctorsState extends SeniorProfState {
  final List<DoctorNoteModel> doctorNoteModel;
  SenAllNoteDoctorsState(this.doctorNoteModel);
  @override
  List<Object?> get props =>[doctorNoteModel];
}
final class  SenAllNoteDoctorErrorState extends SeniorProfState {
  final Failure failure;
  SenAllNoteDoctorErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  SenAllNoteDoctorLoadingState extends SeniorProfState {
  @override
  SenAllNoteDoctorLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  SenAllNoteDoctorEmptyState extends SeniorProfState {
  @override
  SenAllNoteDoctorEmptyState();
  @override
  List<Object?> get props =>[];
}


