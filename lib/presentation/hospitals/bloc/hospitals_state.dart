part of 'hospitals_bloc.dart';

sealed class HospitalsState extends Equatable {
  const HospitalsState();

}

final class HospitalsInitial extends HospitalsState {
  @override

  List<Object?> get props => throw UnimplementedError();
}

final class AllHospitalsState extends HospitalsState {
  final List<HospitalSpAllModel> hospital;
  AllHospitalsState(this.hospital);
  @override
  List<Object?> get props =>[hospital];
}
final class  AllHospitalErrorState extends HospitalsState {
  final Failure failure;
  AllHospitalErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  AllHospitalLoadingState extends HospitalsState {
  @override
  AllHospitalLoadingState();
  @override
  List<Object?> get props =>[];
}