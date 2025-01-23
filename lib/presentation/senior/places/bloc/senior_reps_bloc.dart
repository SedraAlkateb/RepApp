import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_seinor_reps_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'senior_reps_event.dart';
part 'senior_reps_state.dart';

class SeniorRepsBloc extends Bloc<SeniorRepsEvent, SeniorRepsState> {
  AllSeinor_Rep_Usecase allSeinor_Rep_Usecase;
  SeniorRepsBloc(this.allSeinor_Rep_Usecase) : super(SeniorRepsInitial())
  {
    on<SeniorRepsEvent>((event, emit) {

    });
  }
}
