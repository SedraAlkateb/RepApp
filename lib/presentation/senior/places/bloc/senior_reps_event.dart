part of 'senior_reps_bloc.dart';

@immutable
abstract class SeniorRepsEvent  extends Equatable{

}
class AllSeniorRepEvent extends SeniorRepsEvent {

  AllSeniorRepEvent();

  @override

  List<Object?> get props => [];
}