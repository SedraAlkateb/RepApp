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
final class RecipesRecipesState extends RecipesBrandState {
  RecipesRecipesState();
  List<Object?> get props => [];
}
final class RecipesRecipesErrorState extends RecipesBrandState {
  final Failure failure;
  RecipesRecipesErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class RecipesRecipesLoadingState extends RecipesBrandState {
  @override
  List<Object?> get props => [];
}
//

//
final class AllNumState extends RecipesBrandState {
  final List<int> numRec;
  AllNumState(this.numRec);
  List<Object?> get props => [numRec];
}
final class AllNumErrorState extends RecipesBrandState {
  final Failure failure;
  AllNumErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class AllNumLoadingState extends RecipesBrandState {
  @override
  List<Object?> get props => [];
}
//
final class InsertRecipesState extends RecipesBrandState {
  List<Object?> get props => [];
}
final class InsertRecipesErrorState extends RecipesBrandState {
  final Failure failure;
  InsertRecipesErrorState({required this.failure});
  @override
  List<Object?> get props =>[failure];
}
final class InsertRecipesLoadingState extends RecipesBrandState {
  @override
  List<Object?> get props => [];
}
final class SelectTypeState extends RecipesBrandState {
 final String type;
 SelectTypeState(this.type);
  @override
  List<Object?> get props => [type];
}

class ImagePickedState extends RecipesBrandState {
 final File? image;

 ImagePickedState(this.image);

  @override
  List<Object?> get props => [image];
}
final class CopyRecipesState extends RecipesBrandState {
  List<Object?> get props => [];
}


