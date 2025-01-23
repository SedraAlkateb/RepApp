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