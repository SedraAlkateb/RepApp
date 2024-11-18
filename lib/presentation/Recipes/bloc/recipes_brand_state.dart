part of 'recipes_brand_bloc.dart';

@immutable
abstract class RecipesBrandState extends Equatable{}

final class RecipesBrandInitial extends RecipesBrandState {
  @override
  List<Object?> get props => [];
}
final class AllRecipesState extends RecipesBrandState {
  final List<BrandRes> brands;
  AllRecipesState(this.brands);
  List<Object?> get props => [brands];
}
final class AllRecipesErrorState extends RecipesBrandState {
  final Failure failure;
  AllRecipesErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class AllRecipesLoadingState extends RecipesBrandState {
  @override
  List<Object?> get props => [];
}