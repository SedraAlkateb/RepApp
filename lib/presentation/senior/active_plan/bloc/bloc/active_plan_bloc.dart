import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/get_info_plan_brands_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'active_plan_event.dart';
part 'active_plan_state.dart';

class ActivePlanBloc extends Bloc<ActivePlanEvent, ActivePlanState> {
  List<ActivePlanBrandModel> activePlan = [];
  List<ActivePlanBrandModel> activePlanSearch = [];
  GetInfoPlanBrandsUsecase getInfoPlanBrandsUsecase;
  ActivePlanBloc(this.getInfoPlanBrandsUsecase)
      : super(ActivePlanBlocInitial()) {
    on<ActivePlanEvent>((event, emit) async {
      if (event is GetActivePlanEvent) {
        emit(AllActivePlanLoadingState());
        (await getInfoPlanBrandsUsecase.execute(event.index)).fold((failure) {
          emit(AllActivePlanErrorState(failure: failure));
          return false;
        }, (data) async {
          activePlan = data;
          activePlanSearch = data;
          emit(AllActivePlanState(data));
        });
      } else if (event is SearchActivePlanEvent) {
        String search = normalizeText(event.search);
        activePlanSearch = activePlan.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          } else if (normalizeText(value.pharmaceuticalFormTitle).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(AllActivePlanState(activePlanSearch));
      }
    });
  }
}
