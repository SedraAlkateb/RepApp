part of 'future_rep_bloc.dart';

@immutable
sealed class FutureRepEvent extends Equatable {}

class FutureSpEvent extends FutureRepEvent {
  final int id;
  final int planId;
  FutureSpEvent(this.id, this.planId);

  @override
  List<Object?> get props => [id, planId];
}

class UpdateAmountEvent extends FutureRepEvent {
  UpdateAmountEvent();

  @override
  List<Object?> get props => [];
}
class HosSpSearchEvent extends FutureRepEvent {
 final int spId;
 final int repPlanId;
 HosSpSearchEvent(this.repPlanId,this.spId);

  @override
  List<Object?> get props => [];
}
class DocSpSearchEvent extends FutureRepEvent {
  final int spId;
  final int repPlanId;
  DocSpSearchEvent(this.repPlanId,this.spId);

  @override
  List<Object?> get props => [];
}
class FutureRepPlanBrandSpEvent extends FutureRepEvent {
  final RepSp rep;
  final int sampleCount;
  final int ?percent;
  FutureRepPlanBrandSpEvent(this.rep, this.sampleCount, {this.percent});

  @override
  List<Object?> get props => [rep, sampleCount];
}

class FutureSearchSpecEvent extends FutureRepEvent {
  final String contan;
  FutureSearchSpecEvent(this.contan);

  @override
  List<Object?> get props => [contan];
}

class EditePlanStatusEvent extends FutureRepEvent {
  final int id;
  final int status;
  EditePlanStatusEvent(this.id, this.status);

  @override
  List<Object?> get props => [id, status];
}

class SearchPlanBrandsEvent extends FutureRepEvent {
  final String contant;
  SearchPlanBrandsEvent(this.contant);

  @override
  List<Object?> get props => [contant];
}

class ChangeFieldEvent extends FutureRepEvent {
  final int number;
  final int itemId;

  ChangeFieldEvent(this.number, this.itemId);

  @override
  List<Object?> get props => [number, itemId];
}
