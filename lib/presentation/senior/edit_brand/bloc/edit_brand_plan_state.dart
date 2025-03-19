part of 'edit_brand_plan_bloc.dart';

@immutable
abstract class EditBrandPlanState extends Equatable {}

final class EditBrandPlanInitial extends EditBrandPlanState {

  @override
  List<Object?> get props => [];
}
final class FuturePlanBrandState extends EditBrandPlanState {
  final List<PlanBrandModel> planbrand;
  FuturePlanBrandState(this.planbrand);
  @override
  List<Object?> get props => [planbrand];
}
final class FutureSpRepErrorState extends EditBrandPlanState {
  final Failure failure;
  FutureSpRepErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class FutureSpRepLoadingState extends EditBrandPlanState {
  @override
  FutureSpRepLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureChangePlanBrandTypeLoadingState extends EditBrandPlanState {
  @override
  FutureChangePlanBrandTypeLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureChangePlanBrandTypeState extends EditBrandPlanState {
  final List<PlanBrandModel> planbrand;
  FutureChangePlanBrandTypeState(this.planbrand);
  @override
  List<Object?> get props => [planbrand];
}
final class FutureChangePlanBrandTypeErrorState extends EditBrandPlanState {
  final Failure failure;
  FutureChangePlanBrandTypeErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}