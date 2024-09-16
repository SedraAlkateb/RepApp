part of 'visit_bloc.dart';

@immutable
sealed class VisitState extends Equatable {}

final class VisitInitial extends VisitState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
final class VisitPharmacyErrorState extends VisitState {
  final Failure failure;
  VisitPharmacyErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class VisitPharmacyState extends VisitState {
  @override
  VisitPharmacyState();
  @override
  List<Object?> get props =>[];
}

final class VisitDoctorErrorState extends VisitState {
  final Failure failure;
  VisitDoctorErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class VisitDoctorState extends VisitState {
  @override
  VisitDoctorState();
  @override
  List<Object?> get props =>[];
}
