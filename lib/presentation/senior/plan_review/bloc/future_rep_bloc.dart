import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/change_rep_plan_status.dart';
import 'package:domina_app/domain/usecase/rep_plan_brand_sp_usecase.dart';
import 'package:domina_app/domain/usecase/update_rep_plan_brand_amount.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'future_rep_event.dart';
part 'future_rep_state.dart';

class FutureRepBloc extends Bloc<FutureRepEvent, FutureRepState> {
  AllSpeUsecase allSpeUsecase;
  RepPlanBrandSpUsecase repPlanBrandSpUsecase;
  UpdateRepPlanBrandAmount updateRepPlanBrandAmount;
  ChangeRepPlanStatus changeRepPlanStatus;
  int sumBrandsAmount = 0;
  List<SpecDModel> specialization = [];
  AllPlanBrandSp  planBrandSp = AllPlanBrandSp([], 0);
  List<BrandAmountRequestModel> planBrandSpSend = [];
  int number=0;
  FutureRepBloc(this.allSpeUsecase, this.repPlanBrandSpUsecase,
      this.updateRepPlanBrandAmount, this.changeRepPlanStatus)
      : super(FutureRepInitial()) {
    on<FutureRepEvent>((event, emit) async {
      if (event is FutureSpEvent) {
        specialization = [];
        emit(FutureSpRepLoadingState());
        (await allSpeUsecase.execute(event.id)).fold((failure) {
          emit(FutureSpRepErrorState(failure: failure));
        }, (data) async {
          planBrandSpSend = [];
          specialization = data;
          emit(FutureSpRepState(data));
        });
      } else if (event is FutureSearchSpecEvent) {
        List<SpecDModel> specializationSearch = [];
        String search = normalizeText(event.contan);
        specializationSearch = specialization.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(FutureSpRepState(specializationSearch));
      } else if (event is SearchPlanBrandsEvent) {
        List<PlanBrandSp> planBrandSp2 = [];
        String search = normalizeText(event.contant);
        planBrandSp2 = planBrandSp.planBrandSps.where((value) {
          if (normalizeText(value.titleAr).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(FutureRepPlanBrandSpState(planBrandSp2));
      } else if (event is FutureRepPlanBrandSpEvent) {
        planBrandSp = AllPlanBrandSp([],0);
        emit(FutureRepPlanBrandSpLoadingState());
        (await repPlanBrandSpUsecase.execute(event.rep)).fold((failure) {
          emit(FutureRepPlanBrandSpErrorState(failure: failure));
        }, (data) async {
          planBrandSp = data!;
          number=data.amount;
          data.amount=data.amount*event.sampleCount;
          if (data.planBrandSps.isEmpty) {
            emit(FutureRepPlanBrandSpEmptyState(data));
          } else {
            sumBrandsAmount = 0;
            sumBrandsAmount = sumBrandAmount(data.planBrandSps);
            emit(FutureRepPlanBrandSpState(data.planBrandSps));
          }
        });
      } else if (event is ChangeFieldEvent) {
        if(UserInfo.repType==7){
          int sumF =
              sumBrandsAmount - planBrandSp.planBrandSps[event.index].totalAmount;
          sumF = sumF + event.number;
          if (sumF > planBrandSp.amount) {
            emit(SumErrorState(
                failure: Failure(4, "لقد تجاوزت الحد المسموح لهذا الاختصاص")));
          } else {
            planBrandSp.planBrandSps[event.index].totalAmount = event.number;
            sumBrandsAmount = sumF;
            int existingIndex = planBrandSpSend.indexWhere(
                  (item) => item.id == planBrandSp.planBrandSps[event.index].id,
            );
            if (existingIndex == -1) {
              planBrandSpSend.add(BrandAmountRequestModel(
                planBrandSp.planBrandSps[event.index].id,
                planBrandSp.planBrandSps[event.index].totalAmount,
              ));
            } else {
              planBrandSpSend[existingIndex].amount =
                  planBrandSp.planBrandSps[event.index].totalAmount;
            }
          }
        }else{
          planBrandSp.planBrandSps[event.index].totalAmount = event.number;
          int existingIndex = planBrandSpSend.indexWhere(
                (item) => item.id == planBrandSp.planBrandSps[event.index].id,
          );
          if (existingIndex == -1) {
            planBrandSpSend.add(BrandAmountRequestModel(
              planBrandSp.planBrandSps[event.index].id,
              planBrandSp.planBrandSps[event.index].totalAmount,
            ));
          } else {
            planBrandSpSend[existingIndex].amount =
                planBrandSp.planBrandSps[event.index].totalAmount;
          }
        }

      }
      if (event is UpdateAmountEvent) {
        emit(UpdateAmountLoadingState());
        (await updateRepPlanBrandAmount
                .execute(BrandAmountRequestBody(planBrandSpSend)))
            .fold((failure) {
          emit(FutureSpRepErrorState(failure: failure));
        }, (data) async {
          emit(UpdateAmountState());
        });
      }
      if (event is EditePlanStatusEvent) {
        emit(EditeStatusLoadingState());
        (await changeRepPlanStatus.execute(event.id, event.status)).fold(
            (failure) {
          emit(EditeStatusFailureState(failure: failure));
        }, (data) async {
          emit(EditeStatusState());
        });
      }
    });
  }
  int sumBrandAmount(List<PlanBrandSp> planBrands) {
    int sum = 0;
    for (PlanBrandSp brand in planBrands) {
      sum += brand.totalAmount;
    }
    return sum;
  }
}
