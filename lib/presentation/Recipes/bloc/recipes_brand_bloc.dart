import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_res_usecase%20.dart';
import 'package:domina_app/domain/usecase/insert_reci_usecase%20.dart';
import 'package:domina_app/presentation/common/freezed_data.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'recipes_brand_event.dart';
part 'recipes_brand_state.dart';

class RecipesBrandBloc extends Bloc<RecipesBrandEvent, RecipesBrandState> {
  AllBrandsResUsecase allBrandsResUsecase;
  InsertReciUsecase insertReciUsecase;

  File? imageFile1;
  File? imageFile2;
  final _picker = ImagePicker();
  InsertRecipesObject insertRecipesObject = InsertRecipesObject(
      UserInfo.repId.toString(),
      "0",
      "docId",
      "spName",
      "brand_1",
      'address',
      "phone",
      "total",
      "note1",
      'note2',
      "active",
      "note_emp",
      null,
      null,
      "brand_2",
      'brand_3',
      "brand_4");
  List<BrandRes> brandRecs = [];
  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) return File(pickedFile.path);
    return null;
  }

  void updateValue(String value) {
    final updatedUser = insertRecipesObject.copyWith(type: value);
    insertRecipesObject = updatedUser;
    print(updatedUser); // طباعة البيانات المعدلة
  }
  void updateBrandValue(int index, int id) {
    if(index==1){
      final updatedUser = insertRecipesObject.copyWith(brand_1: id.toString());
      insertRecipesObject = updatedUser;
    }else if(index==2){
      final updatedUser = insertRecipesObject.copyWith(brand_2: id.toString());
      insertRecipesObject = updatedUser;
    }else if(index==3){
      final updatedUser = insertRecipesObject.copyWith(brand_3: id.toString());
      insertRecipesObject = updatedUser;
    }else{
      final updatedUser = insertRecipesObject.copyWith(brand_4: id.toString());
      insertRecipesObject = updatedUser;
    }

  }
  RecipesBrandBloc(this.allBrandsResUsecase, this.insertReciUsecase)
      : super(RecipesBrandInitial()) {
    on<RecipesBrandEvent>((event, emit) async {
      if (event is AllRecipesEvent) {
        emit(AllRecipesLoadingState());
        (await allBrandsResUsecase.execute(UserInfo.repId)).fold((failure) {
          emit(AllRecipesErrorState(failure: failure));
        }, (data) async {
          brandRecs = data;
          emit(AllRecipesState(data));
        });
      }
      if (event is InsertReciEvent) {
        emit(InsertRecipesLoadingState());
        (await insertReciUsecase.execute(event.reciRequest)).fold((failure) {
          emit(InsertRecipesErrorState(failure: failure));
        }, (data) async {
          emit(InsertRecipesState());
        });
      }
      if (event is SelectTypeEvent) {
        print("object");
        updateValue(event.selectedTypeDoctor);
        emit(SelectTypeState(insertRecipesObject.type));
      }
      if(event is SelectBrandEvent){
        updateBrandValue(event.index, event.id);
      }
      if (event is PickImageEvent) {
        print('fffffffffffff');
        if (event.index == 1) {
          imageFile1 = event.image;
        } else {
          imageFile2 = event.image;
        }
        emit(ImagePickedState(event.image));
      }
    });
  }
}
