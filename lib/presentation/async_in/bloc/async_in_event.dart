part of 'async_in_bloc.dart';

@immutable
sealed class AsyncInEvent extends Equatable{}
class Async1DataEvent extends AsyncInEvent{
  @override
  List<Object?> get props => [];

}