import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_res_usecase%20.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'recipes_brand_event.dart';
part 'recipes_brand_state.dart';

class RecipesBrandBloc extends Bloc<RecipesBrandEvent, RecipesBrandState> {
  AllBrandsResUsecase allBrandsResUsecase;
  List<BrandRes> brandRecs = [];
  RecipesBrandBloc(this.allBrandsResUsecase) : super(RecipesBrandInitial()) {
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
    });
  }
}
