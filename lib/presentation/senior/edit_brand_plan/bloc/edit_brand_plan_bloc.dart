import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
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
  EditBrandPlanBloc(this.changePlanBrandTypeUsecase, this.allPlanBrandsUsecase,this.changeRepPlanStatus)
      : super(EditBrandPlanInitial()) {
    on<EditBrandPlanEvent>((event, emit) async {
      if (event is FutureSearchSpecEvent) {
        List<PlanBrandModel> planBrand2;
        String search = normalizeText(event.contan);
        planBrand2 = planBrands.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(FuturePlanBrandState(planBrand2));
      }
      else if (event is FutureGetPlanBrandEvent) {
        planBrands = [];
        emit(FutureSpRepLoadingState());
        (await allPlanBrandsUsecase.execute(event.rep)).fold((failure) {
          emit(FutureSpRepErrorState(failure: failure));
        }, (data) async {
          planBrands = data;

          emit(FuturePlanBrandState(data));
        });
      }
      else if (event is FutureChangePlanBrandTypeEvent) {
        emit(FutureChangePlanBrandTypeLoadingState());
        (await changePlanBrandTypeUsecase
                .execute(ChangePlanBrandType(event.id, event.brandType)))
            .fold((failure) {
          emit(FutureChangePlanBrandTypeErrorState(failure: failure));
        }, (data) async {
          loadingItemId = -1;
          emit(FutureChangePlanBrandTypeState(planBrands));
        });
      } else if (event is FutureChangeLoadingItemValueEvent) {
        loadingItemId = event.index;
        emit(FutureChangeLoadingItemValueState(loadingItemId));
      }
      if (event is EditePlanStatusEvent) {
        emit(EditeStatusLoadingState());
        (await changeRepPlanStatus.execute(event.id,0)).fold((failure) {
          emit(EditeStatusFailureState(failure: failure));
        }, (data) async {
          emit(EditeStatusState());
        });
      }
    });
  }
}
