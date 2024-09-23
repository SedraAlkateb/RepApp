import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_spec_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'specialization_event.dart';
part 'specialization_state.dart';

class SpecializationBloc
    extends Bloc<SpecializationEvent, SpecializationState> {
  AllSpecsSqlUsecase allSpeUsecase;
    List<SpecModel> specialization=[];
  SpecializationBloc(this.allSpeUsecase) : super(SpecializationInitial()) {
    on<SpecializationEvent>((event, emit) async {
      if (event is SpecEvent) {
        //       emit(AllSpecLoadingState());
        (await allSpeUsecase.execute()).fold((failure) {
          emit(AllSpecErrorState(failure: failure));
        }, (data) async {
          specialization=data;
          emit(AllSpecState(data));
        });
      }
      if (event is SearchSpecEvent) {
        List<SpecModel> spec ;

        spec=specialization.where((value) {
          if (value.title.contains(event.contan)) {
          return true;
          } 
           
          return false;
        }).toList();
          
        emit(AllSpecState(spec));
      }
    });
  }
}
