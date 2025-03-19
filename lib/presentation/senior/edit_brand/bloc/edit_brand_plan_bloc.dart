import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_usecase.dart';
import 'package:domina_app/domain/usecase/changePlanBrandType_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'edit_brand_plan_event.dart';
part 'edit_brand_plan_state.dart';

class EditBrandPlanBloc extends Bloc<EditBrandPlanEvent, EditBrandPlanState> {
  List<PlanBrandModel> planBrands = [];
  ChangePlanBrandTypeUsecase changePlanBrandTypeUsecase;
  AllPlanBrandsUsecase allPlanBrandsUsecase;

  EditBrandPlanBloc( this.changePlanBrandTypeUsecase, this.allPlanBrandsUsecase) : super(EditBrandPlanInitial()) {
    on<EditBrandPlanEvent>((event, emit) async{
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
      } else if (event is FutureGetPlanBrandEvent) {
        planBrands = [];
        emit(FutureSpRepLoadingState());
        (await allPlanBrandsUsecase.execute(event.rep)).fold((failure) {
          emit(FutureSpRepErrorState(failure: failure));
        }, (data) async {
          planBrands = data;
          emit(FuturePlanBrandState(data));
        });
      } else if (event is FutureChangePlanBrandTypeEvent) {
        //   planBrands = [];
        emit(FutureChangePlanBrandTypeLoadingState());
        (await changePlanBrandTypeUsecase
                .execute(ChangePlanBrandType(event.id, event.brandType)))
            .fold((failure) {
          emit(FutureChangePlanBrandTypeErrorState(failure: failure));
        }, (data) async {
          emit(FutureChangePlanBrandTypeState(planBrands));
        });
      }
    });
  }
}
