import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/changePlanBrandType_usecase.dart';
import 'package:domina_app/domain/usecase/rep_plan_brand_sp_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'future_rep_event.dart';
part 'future_rep_state.dart';

class FutureRepBloc extends Bloc<FutureRepEvent, FutureRepState> {
  AllSpeUsecase allSpeUsecase;
  RepPlanBrandSpUsecase repPlanBrandSpUsecase;

  List<SpecDModel> specialization = [];
  List<BrandFlag> brandFlag = [];
  PlanBrandSpecWithSamplesResponse planBrandsp = PlanBrandSpecWithSamplesResponse(PlanBrands: [],Brands: Brand(0,0,0));

  FutureRepBloc(this.allSpeUsecase,
      this.repPlanBrandSpUsecase)
      : super(FutureRepInitial()) {
    on<FutureRepEvent>((event, emit) async {
      if (event is FutureSpEvent) {
        specialization = [];
        emit(FutureSpRepLoadingState());
        (await allSpeUsecase.execute(event.id)).fold((failure) {
          emit(FutureSpRepErrorState(failure: failure));
        }, (data) async {
          specialization = data;
          emit(FutureSpRepState(data));
        });
      }

      else if (event is FutureRepPlanBrandSpEvent) {
        planBrandsp = PlanBrandSpecWithSamplesResponse(PlanBrands: [],Brands: Brand(0,0,0));
        emit(FutureRepPlanBrandSpLoadingState());
        (await repPlanBrandSpUsecase.execute(event.rep)).fold((failure) {
          emit(FutureRepPlanBrandSpErrorState(failure: failure));
        }, (data) async {
          planBrandsp = data;
        
          if (data.PlanBrands.isEmpty) {
            emit(FutureRepPlanBrandSpEmptyState(planBrandsp));
          } else {
           emit(FutureRepPlanBrandSpState(planBrandsp));
          }
        });
      }
    });
  }
}
