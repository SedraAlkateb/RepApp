import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_place_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  AllPlacesSqlUsecase allPlaceUsecase;
List<PlaceModel> placeModel =[];
List<PlaceModel> placeSearchModel =[];
int k=0;
  PlaceBloc(
      this.allPlaceUsecase
      ) : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit)async {
      if(event is AllPlaceEvent){
    //   emit(AllPlaceLoadingState());
        (
            await allPlaceUsecase.execute()).fold(
      (failure)  {
      emit(AllPlaceErrorState(failure: failure));
      },
      (data)  async{
        placeModel=data;
        placeSearchModel=data;
      emit(AllPlaceState(data));
      }

      );
    }
    if(event is SearchPlaceEvent){
   placeSearchModel = placeModel
      .where((value) {
if(value.title.contains(event.value)){
  return true;
}else{
  return false;
}
      
      }  )
      .toList();
      emit(SearchPlaceState(placeSearchModel));
    }
    });
  }
}
