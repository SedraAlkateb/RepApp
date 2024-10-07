part of 'async_bloc.dart';

@immutable
sealed class AsyncEvent extends Equatable{}
class AsyncDataEvent extends AsyncEvent{
  @override

  List<Object?> get props => [];


}


class EditEvent extends AsyncEvent{
  @override
final int num;
  EditEvent(this.num);
  List<Object?> get props =>[num];
}
