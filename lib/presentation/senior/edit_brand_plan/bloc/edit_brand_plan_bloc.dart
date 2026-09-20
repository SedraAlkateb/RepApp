import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_type_usecase.dart';
import 'package:domina_app/domain/usecase/changePlanBrandType_usecase.dart';
import 'package:domina_app/domain/usecase/change_rep_plan_status.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'edit_brand_plan_event.dart';
part 'edit_brand_plan_state.dart';

class EditBrandPlanBloc extends Bloc<EditBrandPlanEvent, EditBrandPlanState> {
  List<PlanBrandModel> planBrands = [];
  ChangePlanBrandTypeUsecase changePlanBrandTypeUsecase;
  AllPlanBrandsTypeUsecase allPlanBrandsUsecase;
  int loadingItemId = -1;
  int current = 0;
  ChangeRepPlanStatus changeRepPlanStatus;
  EditBrandPlanBloc(this.changePlanBrandTypeUsecase, this.allPlanBrandsUsecase,
      this.changeRepPlanStatus)
      : super(EditBrandPlanInitial()) {
    on<FutureSearchSpecEvent>((event, emit) async {
      List<PlanBrandModel> planBrand2;
      String search = normalizeText(event.contan);
      planBrand2 = planBrands.where((value) {
        if (normalizeText(value.title).contains(search)) {
          return true;
        }
        return false;
      }).toList();
      emit(FuturePlanBrandState(planBrand2));
    });

    on<FutureGetPlanBrandEvent>((event, emit) async {
      planBrands = [];
      emit(FutureSpRepLoadingState());
      (await allPlanBrandsUsecase.execute(event.rep)).fold((failure) {
        emit(FutureSpRepErrorState(failure: failure));
      }, (data) async {
        planBrands = data;

        emit(FuturePlanBrandState(data));
      });
    });

    on<FutureChangePlanBrandTypeEvent>((event, emit) async {
      emit(FutureChangePlanBrandTypeLoadingState());
      (await changePlanBrandTypeUsecase
              .execute(ChangePlanBrandType(event.id, event.brandType)))
          .fold((failure) {
        emit(FutureChangePlanBrandTypeErrorState(failure: failure));
      }, (data) async {
        loadingItemId = -1;
        emit(FutureChangePlanBrandTypeState(planBrands));
      });
    });

    on<FutureChangeLoadingItemValueEvent>((event, emit) async {
      loadingItemId = event.index;
      emit(FutureChangeLoadingItemValueState(loadingItemId));
    });

    on<EditePlanStatusEvent>((event, emit) async {
      emit(EditeStatusLoadingState());
      (await changeRepPlanStatus.execute(event.id, 0)).fold((failure) {
        emit(EditeStatusFailureState(failure: failure));
      }, (data) async {
        emit(EditeStatusState());
      });
    });
  }
}
