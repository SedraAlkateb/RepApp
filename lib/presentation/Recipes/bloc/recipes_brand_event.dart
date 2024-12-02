part of 'recipes_brand_bloc.dart';

@immutable
abstract class RecipesBrandEvent extends Equatable {}

class AllRecipesEvent extends RecipesBrandEvent {
  @override
  AllRecipesEvent();
  List<Object?> get props => [];
}

class CopyRecipesEvent extends RecipesBrandEvent {
  final int docId;

  CopyRecipesEvent(this.docId);
  @override

  List<Object?> get props => [docId];
}

class BrandRecipesEvent extends RecipesBrandEvent {
  final BrandRes brandRes;
  BrandRecipesEvent(this.brandRes);
  List<Object?> get props => [brandRes];
}

class InsertReciEvent extends RecipesBrandEvent {
  final int docId;
  final String doctorSp ;

  final String firstNote ;

  final String secondNote ;

  final String address ;

  final String connect ;

  final String specialNotes ;
  final String phone ;

  InsertReciEvent(this.doctorSp, this.firstNote, this.secondNote, this.address,
      this.connect, this.specialNotes,this.docId,this.phone);

  List<Object?> get props => [doctorSp,firstNote,secondNote,address,connect,specialNotes];
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
class SelectNumRecEvent extends RecipesBrandEvent {
  final String num;
  SelectNumRecEvent({required this.num});
  List<Object?> get props => [num];
}
class AllNumEvent extends RecipesBrandEvent {
  @override
  AllNumEvent();
  List<Object?> get props => [];
}
