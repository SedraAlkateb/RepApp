import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/usecase/finished_plans_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'finished_plan_event.dart';
part 'finished_plan_state.dart';

class FinishedPlanBloc extends Bloc<FinishedPlanEvent, FinishedPlanState> {
  FinishedPlansUsecase finishedPlansUsecase;
  FinishedPlanBloc(this.finishedPlansUsecase) : super(FinishedPlanInitial()) {
    on<FinishedPlanEvent>((event, emit) {

    });
  }
}
