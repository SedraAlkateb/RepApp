part of 'search_doctors_bloc.dart';

@immutable
abstract class SearchDoctorsState extends Equatable {}

final class EditBrandPlanInitial extends SearchDoctorsState {

  @override
  List<Object?> get props => [];
}
final class FutureSearchDoctorsState extends SearchDoctorsState {
  final List<doctorsModel> Representative;
  FutureSearchDoctorsState(this.Representative);
  @override
  List<Object?> get props => [Representative];
}
final class FutureDocDoctorsState extends SearchDoctorsState {
  final List<DocdoctorsModel> doctordetails;
  FutureDocDoctorsState(this.doctordetails);
  @override
  List<Object?> get props => [doctordetails];
}
final class FutureFutureSearchDoctorsErrorState extends SearchDoctorsState {
  final Failure failure;
  FutureFutureSearchDoctorsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class FutureDocDoctorsErrorState extends SearchDoctorsState {
  final Failure failure;
  FutureDocDoctorsErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class FutureSearchDoctorsLoadingState extends SearchDoctorsState {
  @override
  FutureSearchDoctorsLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureDocDoctorsLoadingState extends SearchDoctorsState {
  @override
  FutureDocDoctorsLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureDocDoctorsEmptyState extends SearchDoctorsState {
  FutureDocDoctorsEmptyState();
  @override
  List<Object?> get props =>[];
}

final class FutureSearchDoctorsEmptyState extends SearchDoctorsState {
  FutureSearchDoctorsEmptyState();
  @override
  List<Object?> get props =>[];
}