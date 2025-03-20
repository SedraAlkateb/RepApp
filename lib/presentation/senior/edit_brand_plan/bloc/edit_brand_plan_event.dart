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
  List<Object?> get props => [id, brandType];
}
