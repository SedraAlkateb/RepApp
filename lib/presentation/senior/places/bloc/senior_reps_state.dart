part of 'senior_reps_bloc.dart';

@immutable
sealed class SeniorRepsState  extends Equatable {

}

final class SeniorRepsInitial extends SeniorRepsState {
  @override

  List<Object?> get props => [];

}
final class AllSeniorRepState extends SeniorRepsState {
  final List<AllRepresentative> representatives;
  AllSeniorRepState(this.representatives);
  @override
  List<Object?> get props =>[representatives];
}
final class AllSeniorRepErrorState extends SeniorRepsState {
  final Failure failure;
  AllSeniorRepErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

final class AllSeniorRepLoadingState extends SeniorRepsState {
  @override
  AllSeniorRepLoadingState();
  @override
  List<Object?> get props =>[];
}