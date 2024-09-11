part of 'doctors_bloc.dart';

abstract class DoctorsState extends Equatable {

}

final class DoctorsInitial extends DoctorsState {
  @override

  List<Object?> get props => throw UnimplementedError();

}

final class AllDoctorState extends DoctorsState {
  final List<DoctorModel> doctor;
  AllDoctorState(this.doctor);
  @override
  List<Object?> get props =>[doctor];
}
final class  AllDoctorErrorState extends DoctorsState {
  final Failure failure;
  AllDoctorErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  AllDoctorLoadingState extends DoctorsState {
  @override
  AllDoctorLoadingState();
  @override
  List<Object?> get props =>[];
}