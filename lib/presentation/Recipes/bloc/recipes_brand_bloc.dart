import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_res_usecase%20.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'recipes_brand_event.dart';
part 'recipes_brand_state.dart';

class RecipesBrandBloc extends Bloc<RecipesBrandEvent, RecipesBrandState> {
  AllBrandsResUsecase allBrandsResUsecase;
String value = "0";
  File? imageFile1;
  File? imageFile2;
  final _picker = ImagePicker();
  List<BrandRes> brandRecs = [];
  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if(pickedFile!=null)
    return File(pickedFile.path);
    return null;

  }

  List<BrandRes>brandRecs=[];
  RecipesBrandBloc(
      this.allBrandsResUsecase
      ) : super(RecipesBrandInitial()) {
    on<RecipesBrandEvent>((event, emit) async{
      if(event is AllRecipesEvent){
        emit(AllRecipesLoadingState());
        (await allBrandsResUsecase.execute(UserInfo.repId)).fold((failure) {
          emit(AllRecipesErrorState(failure: failure));
        }, (data) async {
          brandRecs = data;
          emit(AllRecipesState(data));
        });
      }
      if(event is SelectTypeEvent){
        print("object");
      value=  event.selectedTypeDoctor;

       emit(SelectTypeState(value));


      }
      if(event is PickImageEvent)
      {print('fffffffffffff');
        if(event.index==1)
        {
          imageFile1=event.image;}
       else {
          imageFile2 = event.image;
        }
        emit(ImagePickedState(event.image));
      }

    }
    );

  }
}

