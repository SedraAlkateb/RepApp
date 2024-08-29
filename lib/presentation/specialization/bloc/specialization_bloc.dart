import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'specialization_event.dart';
part 'specialization_state.dart';

class SpecializationBloc extends Bloc<SpecializationEvent, SpecializationState> {
  AllSpeUsecase allSpeUsecase;
  SpecializationBloc(
      this.allSpeUsecase
      ) : super(SpecializationInitial()) {
    on<SpecializationEvent>((event, emit)async {
      if(event is SpecEvent){
        emit(AllSpecLoadingState());
        (
            await allSpeUsecase.execute(event.id)).fold(
      (failure)  {
      emit(AllSpecErrorState(failure: failure));
      },
      (data)  async{
      emit(AllSpecState(data));
      }

      );
    }
    });
  }
}
