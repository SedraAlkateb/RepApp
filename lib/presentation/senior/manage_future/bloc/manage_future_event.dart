part of 'manage_future_bloc.dart';

@immutable
sealed class ManageFutureEvent extends Equatable{}
class AllSeniorRepFutureEvent extends ManageFutureEvent {
  @override
  List<Object?> get props => [];
}

class SenSearchRepFutureEvent extends ManageFutureEvent{
  final String contant;
  SenSearchRepFutureEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}