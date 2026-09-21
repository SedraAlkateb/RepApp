part of 'plan_brands_info_bloc.dart';

/// أنواع الفلترة في تبويب الأصناف
enum PlanBrandsInfoFilter { target, zeroTarget, assistant }

@immutable
abstract class PlanBrandsInfoEvent extends Equatable {}

class GetPlanBrandsInfoEvent extends PlanBrandsInfoEvent {
  final int repPlanId;
  GetPlanBrandsInfoEvent(this.repPlanId);
  @override
  List<Object?> get props => [repPlanId];
}

class SearchPlanBrandsInfoEvent extends PlanBrandsInfoEvent {
  final String search;
  SearchPlanBrandsInfoEvent(this.search);
  @override
  List<Object?> get props => [search];
}

class ApplyInfoFiltersEvent extends PlanBrandsInfoEvent {
  final Set<PlanBrandsInfoFilter> filters;
  ApplyInfoFiltersEvent(this.filters);
  @override
  List<Object?> get props => [filters];
}
