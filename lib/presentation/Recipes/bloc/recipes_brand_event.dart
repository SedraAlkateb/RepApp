part of 'recipes_brand_bloc.dart';

@immutable
abstract class RecipesBrandEvent extends Equatable{

}
class AllRecipesEvent extends RecipesBrandEvent{
  @override
  AllRecipesEvent();
  List<Object?> get props => [];

}

class SelectBrandEvent extends RecipesBrandEvent{
  @override
  final int index;
  SelectBrandEvent(this.index);
  List<Object?> get props => [index];

}
