part of 'future_rep_bloc.dart';

@immutable
sealed class FutureRepEvent extends Equatable {}

class FutureSpEvent extends FutureRepEvent {
  final int id;
  FutureSpEvent(this.id);
  @override
  List<Object?> get props => [];
}




class FutureRepPlanBrandSpEvent extends FutureRepEvent {
  final RepSp rep;
  FutureRepPlanBrandSpEvent(this.rep);
  @override
  List<Object?> get props => [rep];
}

class FutureSearchSpecEvent extends FutureRepEvent {
  final String contan;
  FutureSearchSpecEvent(this.contan);
  @override
  List<Object?> get props => [contan];
}
class ChangeFieldEvent extends FutureRepEvent{
  final int number;
  final int index;
  ChangeFieldEvent(this.number,this.index);
  @override
  List<Object?> get props => [number,index];
}