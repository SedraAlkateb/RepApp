import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_seinor_reps_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'senior_reps_event.dart';
part 'senior_reps_state.dart';

class SeniorRepsBloc extends Bloc<SeniorRepsEvent, SeniorRepsState> {
  AllSeinor_Rep_Usecase allSeinor_Rep_Usecase;
  List<AllRepresentative> allRepresentative = [];
  SeniorRepsBloc(this.allSeinor_Rep_Usecase) : super(SeniorRepsInitial()) {
    on<AllSeniorRepEvent>((event, emit) async {
      emit(AllSeniorRepLoadingState());
      (await allSeinor_Rep_Usecase.execute(event.repId, event.cityId)).fold(
          (failure) {
        emit(AllSeniorRepErrorState(failure: failure));
      }, (data) async {
        if (data.isEmpty) {
          allRepresentative = data;
          emit(AllSeniorRepEmptyState());
        } else {
          data.sort((a, b) => b.number.compareTo(a.number));
          allRepresentative = data;

          emit(AllSeniorRepState(data));
        }
      });
    });

    on<SenSearchRepEvent>((event, emit) async {
      List<AllRepresentative> allRepresentativeModel = [];
      String search = normalizeText(event.contant);
      allRepresentativeModel = allRepresentative.where((value) {
        if (normalizeText(value.name).contains(search)) {
          return true;
        }
        return false;
      }).toList();
      emit(AllSeniorRepState(allRepresentativeModel));
    });
  }
}
