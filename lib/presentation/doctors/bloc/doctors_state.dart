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
  final  int docId;
  CheckRecipesState(this.isCheck,this.st,this.docId);
  List<Object?> get props => [isCheck];
}
final class CheckRecipesErrorState extends DoctorsState {
  final Failure failure;
  final  int docId;
  CheckRecipesErrorState(this.docId,{required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class CheckRecipesLoadingState extends DoctorsState {
 final  int docId;
  CheckRecipesLoadingState(this.docId);
  @override
  List<Object?> get props => [];
}

final class AllHospitalsState extends DoctorsState {
  final List<HospitalSpAllModel> hospital;
  AllHospitalsState(this.hospital);
  @override
  List<Object?> get props =>[hospital];
}
final class  AllHospitalErrorState extends DoctorsState {
  final Failure failure;
  AllHospitalErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  AllHospitalLoadingState extends DoctorsState {
  @override
  AllHospitalLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  AllHospitalEmptyState extends DoctorsState {
  @override
  AllHospitalEmptyState();
  @override
  List<Object?> get props =>[];
}
