part of 'future_rep_bloc.dart';

@immutable
sealed class FutureRepEvent extends Equatable {}

class FutureSpEvent extends FutureRepEvent {
  final int id;
  FutureSpEvent(this.id);
  @override
  List<Object?> get props => [];
}
class UpdateAmountEvent extends FutureRepEvent {
  UpdateAmountEvent();
  @override
  List<Object?> get props => [];
}



class FutureRepPlanBrandSpEvent extends FutureRepEvent {
  final RepSp rep;
  final  int sampleCount;
  FutureRepPlanBrandSpEvent(this.rep,this.sampleCount);
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
class EditePlanStatusEvent extends FutureRepEvent {
  final int id;
  final int status ;
  EditePlanStatusEvent(this.id,this.status);
  @override
  List<Object?> get props => [];
}
class SearchPlanBrandsEvent extends FutureRepEvent{
  final String contant;
  SearchPlanBrandsEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}
