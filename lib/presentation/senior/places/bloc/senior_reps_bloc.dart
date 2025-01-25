import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_seinor_reps_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'senior_reps_event.dart';
part 'senior_reps_state.dart';

class SeniorRepsBloc extends Bloc<SeniorRepsEvent, SeniorRepsState> {
  AllSeinor_Rep_Usecase allSeinor_Rep_Usecase;
  List<AllRepresentative> allRepresentative = [];
  SeniorRepsBloc(this.allSeinor_Rep_Usecase) : super(SeniorRepsInitial())
  {
    on<SeniorRepsEvent>((event, emit) async {
      if (event is AllSeniorRepEvent) {
        (await allSeinor_Rep_Usecase.execute(UserInfo.repId)).fold((failure) {
      emit(AllSeniorRepErrorState(failure: failure));
      }, (data) async {
      allRepresentative = data;
      if (allRepresentative.isNotEmpty) {
      emit(AllSeniorRepState(data));
      }
      });
    }
    });
  }
}
