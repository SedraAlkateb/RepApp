part of 'doctors_bloc.dart';

abstract class DoctorsState extends Equatable {

}

final class DoctorsInitial extends DoctorsState {
  @override

  List<Object?> get props => [];

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
final class AllDoctorEmptyState extends DoctorsState{
  @override
  List<Object?> get props =>[];

}

final class CheckRecipesState extends DoctorsState {
  final bool isCheck;
  final int st;
  CheckRecipesState(this.isCheck,this.st);
  List<Object?> get props => [isCheck];
}
final class CheckRecipesErrorState extends DoctorsState {
  final Failure failure;
  CheckRecipesErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class CheckRecipesLoadingState extends DoctorsState {
  @override
  List<Object?> get props => [];
}