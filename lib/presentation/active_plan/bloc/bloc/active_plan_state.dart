part of 'active_plan_bloc.dart';

@immutable
sealed class ActivePlanState extends Equatable {
}

final class ActivePlanBlocInitial extends ActivePlanState {
  @override
  List<Object> get props => [];
}
final class AllActivePlanEmptyState extends ActivePlanState {
  AllActivePlanEmptyState();
  @override
  List<Object?> get props =>[];
}
final class AllActivePlanErrorState extends ActivePlanState {

  final Failure failure;
  AllActivePlanErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

final class AllActivePlanLoadingState extends ActivePlanState {
  AllActivePlanLoadingState();
  @override
  List<Object?> get props =>[];
}

final class AllActivePlanState extends ActivePlanState {
  final List<ActivePlanBrandModel> activeBrands;
  AllActivePlanState(this.activeBrands);
  @override
  List<Object?> get props =>[activeBrands];
}
