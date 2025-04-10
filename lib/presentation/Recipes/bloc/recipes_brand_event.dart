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
  final int recipeType;
  CopyRecipesEvent(this.docId,this.recipeType);
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
class UpdateReciEvent extends RecipesBrandEvent {
  final int docId;
  final String doctorSp ;

  final String firstNote ;

  final String secondNote ;

  final String address ;

  final String connect ;

  final String specialNotes ;
  final String phone ;

  UpdateReciEvent(this.doctorSp, this.firstNote, this.secondNote, this.address,
      this.connect, this.specialNotes,this.docId,this.phone);

  List<Object?> get props => [doctorSp,firstNote,secondNote,address,connect,specialNotes];
}
class InsertReciHospitalEvent extends RecipesBrandEvent {
  final int docId;
  final String doctorSp ;

  final String firstNote ;

  final String secondNote ;

  final String address ;

  final String connect ;

  final String specialNotes ;

  InsertReciHospitalEvent(
      this.docId,
      this.doctorSp,
      this.firstNote,
      this.secondNote,
      this.address,
      this.connect,
      this.specialNotes,
      );

  List<Object?> get props => [doctorSp,firstNote,secondNote,address,connect,specialNotes];
}

class UpdateReciHospitalEvent extends RecipesBrandEvent {
  final int docId;
  final String doctorSp ;

  final String firstNote ;

  final String secondNote ;

  final String address ;

  final String connect ;

  final String specialNotes ;

  UpdateReciHospitalEvent(
      this.docId,
      this.doctorSp,
      this.firstNote,
      this.secondNote,
      this.address,
      this.connect,
      this.specialNotes,
   );

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

class Checkbox1Event extends RecipesBrandEvent {
  final int isChecked;

  Checkbox1Event(this.isChecked);

  @override

  List<Object?> get props =>[isChecked];
}
class Checkbox2Event extends RecipesBrandEvent {
  final int isChecked;

  Checkbox2Event(this.isChecked);

  @override

  List<Object?> get props =>[isChecked];
}
class SelectBrandEvent extends RecipesBrandEvent {
  final int index;
  final BrandRes brandRecipeModel;
  SelectBrandEvent({required this.index,required this.brandRecipeModel});
  List<Object?> get props => [index,brandRecipeModel];
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
class RestartEvent extends RecipesBrandEvent {

  List<Object?> get props => [];
}
class AllReciEvent extends RecipesBrandEvent{
  @override
  AllReciEvent();
  List<Object?> get props => [];

}
class GetReciEvent extends RecipesBrandEvent{
  final String id;
  @override
  GetReciEvent(this.id);
  List<Object?> get props => [];

}
class UpdateReciSEvent extends RecipesBrandEvent {
  final  int reciId;
  final int docId;
  final String doctorSp ;

  final String firstNote ;

  final String secondNote ;

  final String address ;

  final String connect ;

  final String specialNotes ;
  final String phone ;

  UpdateReciSEvent(this.reciId,this.doctorSp, this.firstNote, this.secondNote, this.address,
      this.connect, this.specialNotes,this.docId,this.phone);

  List<Object?> get props => [doctorSp,firstNote,secondNote,address,connect,specialNotes];
}
class UpdateReciSHospitalEvent extends RecipesBrandEvent {
  final  int reciId;
  final int docId;
  final String doctorSp ;

  final String firstNote ;

  final String secondNote ;

  final String address ;

  final String connect ;

  final String specialNotes ;

  UpdateReciSHospitalEvent(
      this.docId,
      this.doctorSp,
      this.firstNote,
      this.secondNote,
      this.address,
      this.connect,
      this.specialNotes,
      this.reciId
      );

  List<Object?> get props => [doctorSp,firstNote,secondNote,address,connect,specialNotes];
}