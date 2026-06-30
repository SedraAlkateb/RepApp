import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_res_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_reci_usecase%20.dart';
import 'package:domina_app/domain/usecase/copyreci_usecase.dart';
import 'package:domina_app/domain/usecase/get_Rep_Reci.dart';
import 'package:domina_app/domain/usecase/insert_reci_usecase%20.dart';
import 'package:domina_app/domain/usecase/reci_num_usecase.dart';
import 'package:domina_app/domain/usecase/update_reci_usecase%20.dart';
import 'package:domina_app/presentation/uniti/common/freezed_data.dart';
import 'package:easy_localization/easy_localization.dart';
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
  ReciNumUsecase reciNumUsecase;
  CopyReciUsecase copyReciUsecase;
  GetRepReciUsecase getRepReciUsecase;
  UpdateReciUsecase updateReciUsecase;
  AllReciUsecase allReciUsecase;
  int isChecked1 = 3;
  int isChecked2 = 3;
  final _picker = ImagePicker();
  InsertRecipesObject insertRecipesObject = InsertRecipesObject(
      UserInfo.repId.toString(),
      "0",
      "docId",
      "spName",
      BrandRes(0, ''),
      'address',
      "phone",
      "total",
      "flagImage1",
      "flagImage2",
      "note1",
      'note2',
      "note_emp",
      "",
      "",
      null,
      null,
      null,
      null,
      null);

  void empty() {
    insertRecipesObject = InsertRecipesObject.empty();
  }

  List<BrandRes> brandRecs = [];
  List<int> numRec = [];
  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      print(pickedFile.path);
      print("pickedFile.path");
      return File(pickedFile.path);
    }

    return null;
  }

  void updateValue(String value) {
    final updatedUser = insertRecipesObject.copyWith(type: value);
    insertRecipesObject = updatedUser;
    print(updatedUser);
  }

  void updateRecipes(CopyReciRequest recipes) {
    final updatedUser = insertRecipesObject.copyWith(
        create_date: recipes.create_date,
        print_date: recipes.print_date,
        phone: recipes.phone,
        image2: (recipes.image2 != null) ? File(recipes.image2 ?? "") : null,
        image1: (recipes.image1 != null) ? File(recipes.image1 ?? "") : null,
        brand_4: recipes.brand_4,
        brand_3: recipes.brand_3,
        brand_2: recipes.brand_2,
        brand_1: recipes.brand_1,
        note1: recipes.note1,
        note2: recipes.note2,
        note_emp: recipes.note_emp,
        spName: recipes.spName,
        docId: recipes.docId.toString(),
        address: recipes.address,
        repId: recipes.repId.toString(),
        total: recipes.total,
        type: recipes.type.toString());
    insertRecipesObject = updatedUser;
  }

  void updateBrandValue(int index, BrandRes id) {
    if (index == 1) {
      final updatedUser = insertRecipesObject.copyWith(brand_1: id);
      insertRecipesObject = updatedUser;
    } else if (index == 2) {
      final updatedUser = insertRecipesObject.copyWith(brand_2: id);
      insertRecipesObject = updatedUser;
    } else if (index == 3) {
      final updatedUser = insertRecipesObject.copyWith(brand_3: id);
      insertRecipesObject = updatedUser;
    } else {
      final updatedUser = insertRecipesObject.copyWith(brand_4: id);
      insertRecipesObject = updatedUser;
    }
  }

  RecipesBrandBloc(
      this.allBrandsResUsecase,
      this.insertReciUsecase,
      this.reciNumUsecase,
      this.copyReciUsecase,
      this.updateReciUsecase,
      this.allReciUsecase,
      this.getRepReciUsecase)
      : super(RecipesBrandInitial()) {
    on<RecipesBrandEvent>((event, emit) async {
      if (event is AllReciEvent) {
        emit(AllReciLoadingState());
        (await allReciUsecase.execute(UserInfo.repId)).fold((failure) {
          emit(AllReciErrorState(failure: failure));
        }, (data) async {
          if (data.isEmpty) {
            emit(AllReciEmptyState());
          } else {
            emit(AllReciState(data));
          }
        });
      }
      if (event is AllRecipesEvent) {
        emit(AllRecipesLoadingState());
        (await allBrandsResUsecase.execute(UserInfo.repId)).fold((failure) {
          emit(AllRecipesErrorState(failure: failure));
        }, (data) async {
          brandRecs = data;
          emit(AllRecipesState(data));
        });
      }
      if (event is CopyRecipesEvent) {
        emit(RecipesRecipesLoadingState());
        (await copyReciUsecase.execute(event.docId, event.recipeType)).fold(
            (failure) {
          print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
          emit(RecipesRecipesErrorState(failure: failure));
        }, (data) async {
          updateRecipes(data);
          emit(RecipesRecipesState());
        });
      }
      if (event is GetRepReciEvent) {
        emit(RecipesRecipesLoadingState());
        (await getRepReciUsecase.execute(event.reciId)).fold((failure) {
          emit(RecipesRecipesErrorState(failure: failure));
        }, (data) async {
          updateRecipes(data);
          emit(RecipesRecipesState());
        });
      }
      if (event is AllNumEvent) {
        emit(AllNumLoadingState());
        (await reciNumUsecase.execute()).fold((failure) {
          emit(AllNumErrorState(failure: failure));
        }, (data) async {
          numRec = data;
          emit(AllNumState(data));
        });
      }

      if (event is InsertReciEvent) {
        emit(InsertRecipesLoadingState());
        final updatedUser = insertRecipesObject.copyWith(
            address: event.address,
            docId: event.docId.toString(),
            note1: event.firstNote,
            note2: event.secondNote,
            note_emp: event.specialNotes,
            spName: event.doctorSp,
            phone: event.phone);
        insertRecipesObject = updatedUser;
        print(insertRecipesObject.image1);
        print(insertRecipesObject.image2);
        (await insertReciUsecase.execute(ReciRequest(
          1,
          insertRecipesObject.repId,
          insertRecipesObject.type,
          insertRecipesObject.docId,
          insertRecipesObject.spName,
          insertRecipesObject.brand_1.id.toString(),
          insertRecipesObject.address,
          insertRecipesObject.phone,
          insertRecipesObject.total,
          flagImage1: isChecked1.toString(),
          flagImage2: isChecked2.toString(),
          note_emp: insertRecipesObject.note_emp,
          note2: insertRecipesObject.note2,
          note1: insertRecipesObject.note1,
          image1: isChecked1 == 2 ? insertRecipesObject.image1 : null,
          brand_2: insertRecipesObject.brand_2?.id.toString(),
          brand_3: insertRecipesObject.brand_3?.id.toString(),
          brand_4: insertRecipesObject.brand_4?.id.toString(),
          image2: isChecked2 == 2 ? insertRecipesObject.image2 : null,
        )))
            .fold((failure) {
          emit(InsertRecipesErrorState(failure: failure));
        }, (data) async {
          emit(InsertRecipesState());
        });
      }
      if (event is InsertReciHospitalEvent) {
        emit(InsertRecipesLoadingState());
        final updatedUser = insertRecipesObject.copyWith(
            address: event.address,
            docId: event.docId.toString(),
            note1: event.firstNote,
            note2: event.secondNote,
            note_emp: event.specialNotes,
            spName: event.doctorSp,
            phone: event.connect);
        insertRecipesObject = updatedUser;
        print(insertRecipesObject.image1);
        print(insertRecipesObject.image2);
        (await insertReciUsecase.execute(ReciRequest(
          2,
          insertRecipesObject.repId,
          "3",
          insertRecipesObject.docId,
          insertRecipesObject.spName,
          insertRecipesObject.brand_1.id.toString(),
          insertRecipesObject.address,
          insertRecipesObject.phone,
          insertRecipesObject.total,
          flagImage1: isChecked1.toString(),
          flagImage2: isChecked2.toString(),
          note_emp: insertRecipesObject.note_emp,
          note2: insertRecipesObject.note2,
          note1: insertRecipesObject.note1,
          image1: isChecked1 == 2 ? insertRecipesObject.image1 : null,
          brand_2: insertRecipesObject.brand_2?.id.toString(),
          brand_3: insertRecipesObject.brand_3?.id.toString(),
          brand_4: insertRecipesObject.brand_4?.id.toString(),
          image2: isChecked2 == 2 ? insertRecipesObject.image2 : null,

        )))
            .fold((failure) {
          emit(InsertRecipesErrorState(failure: failure));
        }, (data) async {
          emit(InsertRecipesState());
        });
      }
      if (event is UpdateReciSEvent) {
        print(DateFormat('yyyy-MM-dd').format(DateTime.now()));
        print("DateFormat('yyyy-MM-dd').format(DateTime.now())");
        emit(InsertRecipesLoadingState());
        final updatedUser = insertRecipesObject.copyWith(
            address: event.address,
            docId: event.docId.toString(),
            note1: event.firstNote,
            note2: event.secondNote,
            note_emp: event.specialNotes,
            spName: event.doctorSp,
            phone: event.phone);
        insertRecipesObject = updatedUser;
        (await updateReciUsecase.execute(UpdateReciRequest(
          event.reciId,
          1,
          insertRecipesObject.repId,
          insertRecipesObject.type,
          insertRecipesObject.docId,
          insertRecipesObject.spName,
          insertRecipesObject.brand_1.id.toString(),
          insertRecipesObject.address,
          insertRecipesObject.phone,
          insertRecipesObject.total,
          DateFormat('yyyy-MM-dd').format(DateTime.now()),
          flagImage1: ((isChecked1 == 3 && insertRecipesObject.image1?.path != null)
              ? "1"
              : "3"),
          flagImage2: ((isChecked2 == 3 && insertRecipesObject.image2?.path != null)
              ? "1"
              : "3"),
          note_emp: insertRecipesObject.note_emp,
          note2: insertRecipesObject.note2,
          note1: insertRecipesObject.note1,
          image1: isChecked1 == 2 ? insertRecipesObject.image1 : null,
          brand_2: insertRecipesObject.brand_2?.id.toString(),
          brand_3: insertRecipesObject.brand_3?.id.toString(),
          brand_4: insertRecipesObject.brand_4?.id.toString(),
          image2: isChecked2 == 2 ? insertRecipesObject.image2 : null,
        )))
            .fold((failure) {
          emit(InsertRecipesErrorState(failure: failure));
        }, (data) async {
          emit(InsertRecipesState());
        });
      }
      if (event is UpdateReciSHospitalEvent) {
        print(DateFormat('yyyy-MM-dd').format(DateTime.now()));
        print("DateFormat('yyyy-MM-dd').format(DateTime.now())");
        emit(InsertRecipesLoadingState());
        final updatedUser = insertRecipesObject.copyWith(
            address: event.address,
            docId: event.docId.toString(),
            note1: event.firstNote,
            note2: event.secondNote,
            note_emp: event.specialNotes,
            spName: event.doctorSp,
            phone: event.connect);
        insertRecipesObject = updatedUser;
        print(insertRecipesObject.image1);
        print(insertRecipesObject.image2);
        (await updateReciUsecase.execute(UpdateReciRequest(
          event.reciId,
          2,
          insertRecipesObject.repId,
          "3",
          insertRecipesObject.docId,
          insertRecipesObject.spName,
          insertRecipesObject.brand_1.id.toString(),
          insertRecipesObject.address,
          insertRecipesObject.phone,
          insertRecipesObject.total,
          DateFormat('yyyy-MM-dd').format(DateTime.now()),
          flagImage1: ((isChecked1 == 3 && insertRecipesObject.image1?.path != null)
              ? "1"
              : "3"),
          flagImage2: ((isChecked2 == 3 && insertRecipesObject.image2?.path != null)
              ? "1"
              : "3"),
          note_emp: insertRecipesObject.note_emp,
          note2: insertRecipesObject.note2,
          note1: insertRecipesObject.note1,
          image1: isChecked1 == 2 ? insertRecipesObject.image1 : null,
          brand_2: insertRecipesObject.brand_2?.id.toString(),
          brand_3: insertRecipesObject.brand_3?.id.toString(),
          brand_4: insertRecipesObject.brand_4?.id.toString(),
          image2: isChecked2 == 2 ? insertRecipesObject.image2 : null,


        )))
            .fold((failure) {
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
      if (event is SelectBrandEvent) {
        updateBrandValue(event.index, event.brandRecipeModel);
      }
      if (event is SelectNumRecEvent) {
        final updatedUser =
            insertRecipesObject.copyWith(total: event.num.toString());
        insertRecipesObject = updatedUser;
      }
      if (event is PickImageEvent) {
        print(event.index);

        if (event.index == 1) {
          final updatedUser = insertRecipesObject.copyWith(image1: event.image);
          insertRecipesObject = updatedUser;
          isChecked1 = 2;
        } else {
          final updatedUser = insertRecipesObject.copyWith(image2: event.image);
          insertRecipesObject = updatedUser;
          isChecked2 = 2;
        }
        print(isChecked2);
        emit(ImagePickedState(event.image));
      }
      if (event is Checkbox1Event) {
        isChecked1 = event.isChecked;
        emit(CheckboxImage1State(isChecked1));
      }
      if (event is Checkbox2Event) {
        isChecked2 = event.isChecked;
        emit(CheckboxImage2State(isChecked2));
      }
    });
  }
}
