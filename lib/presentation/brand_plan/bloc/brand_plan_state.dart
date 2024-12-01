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
  final List<BrandSpPlanModel> planBrands;
  AllBrandPlanState(this.planBrands);
  @override
  List<Object?> get props =>[planBrands];
}
final class AllOtherBrandPlanState extends BrandPlanState {
  final List<OtherBrandSpPlanModel> planBrands;
  AllOtherBrandPlanState(this.planBrands);
  @override
  List<Object?> get props =>[planBrands];
}
final class AllBrandPlanEmptyState extends BrandPlanState {
  AllBrandPlanEmptyState();
  @override
  List<Object?> get props =>[];
}
final class AllBrandPlanErrorState extends BrandPlanState {

  final Failure failure;
  AllBrandPlanErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure,];
}

final class UpdateSaveErrorState extends BrandPlanState {

  final Failure failure;
  UpdateSaveErrorState({required this.failure});
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
  final List<OtherBrandSpPlanModel> planBrands;
  SumState(this.planBrands);
  @override
  List<Object?> get props =>[planBrands];
}
final class UpdateAmountErrorState extends BrandPlanState {

  final Failure failure;
  UpdateAmountErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class UpdateAmountState extends BrandPlanState {
  @override
  List<Object?> get props =>[];
}
final class UpdateAmountLoadingState extends BrandPlanState {
  @override
  List<Object?> get props =>[];
}
final class SearchBrandState extends BrandPlanState {
  final  List<BrandSpPlanModel> brand;
  SearchBrandState(this.brand);
  @override
  List<Object?> get props =>[brand];
}