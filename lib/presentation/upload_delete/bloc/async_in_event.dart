part of 'async_in_bloc.dart';

@immutable
sealed class AsyncInEvent extends Equatable{}
class Async1DataEvent extends AsyncInEvent{
  @override
  List<Object?> get props => [];

}
class DeleteBaseEvent extends AsyncInEvent{
  @override
  List<Object?> get props => [];
}
class AsyncInBaseEvent extends AsyncInEvent{
  @override
  List<Object?> get props => [];
}
class DeleteAllEvent extends AsyncInEvent{
  @override
  List<Object?> get props => [];

}
class UpdateFlagEvent extends AsyncInEvent{
  @override
  List<Object?> get props => [];

}
class EditEventIn extends AsyncInEvent{
final  int num;
  EditEventIn(this.num);
  @override
  List<Object?> get props => [];

}

class GetEvent extends AsyncInEvent{

  @override
  List<Object?> get props => [];

}
