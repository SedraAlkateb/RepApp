import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  AllPlaceUsecase allPlaceUsecase;

  PlaceBloc(
      this.allPlaceUsecase
      ) : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit)async {
      if(event is AllPlaceEvent){
        emit(AllPlaceLoadingState());
        (
            await allPlaceUsecase.execute(event.id)).fold(
      (failure)  {
      emit(AllPlaceErrorState(failure: failure));
      },
      (data)  async{
      emit(AllPlaceState(data));
      }

      );
    }
    });
  }
}
