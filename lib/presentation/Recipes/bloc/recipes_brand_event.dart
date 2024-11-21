part of 'recipes_brand_bloc.dart';

@immutable
abstract class RecipesBrandEvent extends Equatable{

}
class AllRecipesEvent extends RecipesBrandEvent{
  @override
  AllRecipesEvent();
  List<Object?> get props => [];

}

class SelectTypeEvent extends RecipesBrandEvent {
  final String selectedTypeDoctor;

  SelectTypeEvent(this.selectedTypeDoctor);

  @override

  List<Object?> get props =>[selectedTypeDoctor] ;
}

class PickImageEvent extends RecipesBrandEvent {
  final File? image;

  final int index;
   PickImageEvent(this.image,this.index);

  @override
  List<Object?> get props => [image,index];

class SelectBrandEvent extends RecipesBrandEvent{
  @override
  final int index;
  SelectBrandEvent(this.index);
  List<Object?> get props => [index];

}
