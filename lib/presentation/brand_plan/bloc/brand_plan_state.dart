part of 'brand_plan_bloc.dart';

@immutable
sealed class BrandPlanState extends Equatable
{

}

final class BrandPlanInitial extends BrandPlanState {
  @override
  List<Object?> get props => [];
}
final class AllBrandPlanState extends BrandPlanState {
  final List<PlanBrandSqlModel> planBrands;
  AllBrandPlanState(this.planBrands);
  @override
  List<Object?> get props =>[planBrands];
}
final class AllBrandPlanErrorState extends BrandPlanState {

  final Failure failure;
  AllBrandPlanErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure,];
}
final class SumErrorState extends BrandPlanState {

  final Failure failure;
  SumErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class SumState extends BrandPlanState {
  final List<PlanBrandSqlModel> planBrands;
  SumState(this.planBrands);
  @override
  List<Object?> get props =>[planBrands];
}