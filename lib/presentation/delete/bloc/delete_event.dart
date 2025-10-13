part of 'delete_bloc.dart';

@immutable
abstract class DeleteEvent extends Equatable{}
class DeleteAllEvent extends DeleteEvent{
  @override
  List<Object?> get props => [];

}

class DeleteBaseEvent extends DeleteEvent{
  @override
  List<Object?> get props => [];
}
class Edit1EventIn extends DeleteEvent{
  final  int num;
  Edit1EventIn(this.num);
  @override
  List<Object?> get props => [];

}