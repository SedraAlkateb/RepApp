part of 'plan_brands_info_bloc.dart';

@immutable
sealed class PlanBrandsInfoState extends Equatable {}

final class PlanBrandsInfoInitial extends PlanBrandsInfoState {
  @override
  List<Object?> get props => [];
}

final class PlanBrandsInfoLoadingState extends PlanBrandsInfoState {
  @override
  List<Object?> get props => [];
}

final class PlanBrandsInfoErrorState extends PlanBrandsInfoState {
  final Failure failure;
  PlanBrandsInfoErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class PlanBrandsInfoLoadedState extends PlanBrandsInfoState {
  final List<ActivePlanBrandModel> brands;
  final Set<PlanBrandsInfoFilter> activeFilters;
  PlanBrandsInfoLoadedState(this.brands, this.activeFilters);

  bool get isAllFiltersActive =>
      activeFilters.length == PlanBrandsInfoFilter.values.length;

  @override
  List<Object?> get props => [brands, activeFilters];
}
