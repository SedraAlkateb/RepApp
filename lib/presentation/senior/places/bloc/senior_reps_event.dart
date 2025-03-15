part of 'senior_reps_bloc.dart';

@immutable
abstract class SeniorRepsEvent  extends Equatable{
}
class AllSeniorRepEvent extends SeniorRepsEvent {
  @override
  List<Object?> get props => [];
}

class SenSearchRepEvent extends SeniorRepsEvent{
  final String contant;
  SenSearchRepEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}
