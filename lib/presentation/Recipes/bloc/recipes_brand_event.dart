part of 'recipes_brand_bloc.dart';

@immutable
abstract class RecipesBrandEvent extends Equatable {}

class AllRecipesEvent extends RecipesBrandEvent {
  @override
  AllRecipesEvent();
  List<Object?> get props => [];
}

class BrandRecipesEvent extends RecipesBrandEvent {
  final BrandRes brandRes;
  BrandRecipesEvent(this.brandRes);
  List<Object?> get props => [brandRes];
}

class InsertReciEvent extends RecipesBrandEvent {
  final ReciRequest reciRequest;
  InsertReciEvent(this.reciRequest);
  List<Object?> get props => [reciRequest];
}

class SelectTypeEvent extends RecipesBrandEvent {
  final String selectedTypeDoctor;

  SelectTypeEvent(this.selectedTypeDoctor);

  @override
  List<Object?> get props => [selectedTypeDoctor];
}

class PickImageEvent extends RecipesBrandEvent {
  final File? image;

  final int index;

  PickImageEvent(this.image, this.index);

  @override
  List<Object?> get props => [image, index];
}

class SelectBrandEvent extends RecipesBrandEvent {
  final int index;
  final int id;
  SelectBrandEvent({required this.index,required this.id});
  List<Object?> get props => [index,id];
}
