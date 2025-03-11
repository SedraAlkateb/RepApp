import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'future_rep_event.dart';
part 'future_rep_state.dart';

class FutureRepBloc extends Bloc<FutureRepEvent, FutureRepState> {
  AllSpeUsecase allSpeUsecase;
  List<SpecDModel> specialization = [];
  List<BrandFlag> brandFlag = [];

  FutureRepBloc(this.allSpeUsecase) : super(FutureRepInitial()) {
    on<FutureRepEvent>((event, emit) async{
      if (event is FutureSpEvent) {
        specialization=[];
        emit(FutureSpRepLoadingState());
        (await allSpeUsecase.execute(event.id)).fold((failure) {
      emit(FutureSpRepErrorState(failure: failure));
      }, (data) async {
          specialization=data;
          emit(FutureSpRepState(data));
      });
    }
      else if (event is FutureSearchSpecEvent) {
        List<SpecDModel> spec;
        String search = normalizeText(event.contan);
        spec = specialization.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(FutureSpRepState(spec));
      }
    });
  }
}
