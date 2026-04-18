part of 'edit_brand_plan_bloc.dart';

@immutable
sealed class EditBrandPlanEvent extends Equatable {}
class FutureSearchSpecEvent extends EditBrandPlanEvent {
  final String contan;
  FutureSearchSpecEvent(this.contan);
  @override
  List<Object?> get props => [contan];
}
class FutureGetPlanBrandEvent extends EditBrandPlanEvent {
  final Rep rep;
  FutureGetPlanBrandEvent(this.rep);
  @override
  List<Object?> get props => [rep];
}
class FutureChangePlanBrandTypeEvent extends EditBrandPlanEvent {
  final int id;
  final int brandType;

  @override
  FutureChangePlanBrandTypeEvent(this.id, this.brandType);
  @override
  List<Object?> get props => [id, brandType];
}
class FutureChangeLoadingItemValueEvent extends EditBrandPlanEvent {
  final int index;

  @override
  FutureChangeLoadingItemValueEvent(this.index);
  @override
  List<Object?> get props => [index];
}
class EditePlanStatusEvent extends EditBrandPlanEvent {
  final int id;
  final int status ;
  EditePlanStatusEvent(this.id,this.status);
  @override
  List<Object?> get props => [];
}