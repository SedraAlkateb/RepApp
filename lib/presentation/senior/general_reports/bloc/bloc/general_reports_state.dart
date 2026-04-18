part of 'general_reports_bloc.dart';

sealed class GeneralReportsState extends Equatable {
  const GeneralReportsState();
  

}

final class GeneralReportsInitial extends GeneralReportsState {
   @override
  List<Object> get props => [];}
final class SeniorByCityIdErrorState extends GeneralReportsState {

  final Failure failure;
  const SeniorByCityIdErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class TeamLeaderAndCityErrorState extends GeneralReportsState {

  final Failure failure;
  const TeamLeaderAndCityErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class SeniorByCityIdLoadingState extends GeneralReportsState {
  const SeniorByCityIdLoadingState();
  @override
  List<Object?> get props =>[];
}
final class TeamLeaderAndCityLoadingState extends GeneralReportsState {
  const TeamLeaderAndCityLoadingState();
  @override
  List<Object?> get props =>[];
}

final class SeniorByCityIdState extends GeneralReportsState {
  final List<SeniorCityModel> data;
  const SeniorByCityIdState(this.data);
  @override
  List<Object?> get props =>[data];
}
final class TeamLeaderAndCityState extends GeneralReportsState {
  final List<SeniorCityModel> data;
  const TeamLeaderAndCityState(this.data);
  @override
  List<Object?> get props =>[data];
}
final class SeniorByCityIdEmptyState extends GeneralReportsState {
  const SeniorByCityIdEmptyState();
  @override
  List<Object?> get props =>[];
}