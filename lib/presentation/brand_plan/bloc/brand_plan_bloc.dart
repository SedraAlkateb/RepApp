import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/usecase/all_brand_plan_sql_usecase.dart';

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_brand_plan_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'brand_plan_event.dart';
part 'brand_plan_state.dart';

class BrandPlanBloc extends Bloc<BrandPlanEvent, BrandPlanState> {
  AllBrandPlanSqlUsecase allBrandPlanSqlUsecase;
  UpdateBrandPlanSqlUsecase updateBrandPlanSqlUsecase;
  List<PlanBrandSqlModel> planBrand=[];
  List<PlanBrandSqlModel> planBrandActive=[];
int sum=0;
  int current=0;
  BrandPlanBloc(
      this.updateBrandPlanSqlUsecase,
      this.allBrandPlanSqlUsecase
      ) : super(BrandPlanInitial()) {
    on<BrandPlanEvent>((event, emit)async {
      if(event is AllBrandPlanEvent){
        (await allBrandPlanSqlUsecase.execute(UserInfo.activePlanId)).fold((failure) {
      emit(AllBrandPlanErrorState(failure: failure));
      return false;
      }, (data) async {
          planBrandActive=data;
      emit(AllBrandPlanState(data));
      });
        if(UserInfo.otherPlanId!=null){
          (await allBrandPlanSqlUsecase.execute(UserInfo.otherPlanId??0)).fold((failure) {
            emit(AllBrandPlanErrorState(failure: failure));
            return false;
          }, (data) async {
            planBrand=data;
            isSum();
            emit(AllBrandPlanState(data));
          });
        }


      }
      if(event is ChangeFieldEvent){
       int sum1=sum;
       sum1=sum1-(planBrand[event.index].amount*planBrand[event.index].sampleCoast);
       sum1=sum1+(event.number*planBrand[event.index].sampleCoast);
          if(sum1<UserInfo.percentage){
        planBrand[event.index].amount=event.number;
        sum=sum1;
        print(sum);
        emit(SumState(planBrand));
            }else{
            emit(SumErrorState(failure: Failure(100, "لقد تجاوزت الحد المسموح")));
          }
      }
      if(event is UpdateEvent){
        List<PlanBrandSqlModel>planBrandSum=List.from(planBrand);
        emit(SumState(planBrandSum));
      }
      if(event is UpdateAmountSucEvent){
        emit(UpdateAmountLoadingState());
        if(sum>UserInfo.percentage){
          emit(UpdateAmountErrorState(failure: Failure(5, "لقد تجاوزت الحد المسموح")));
        }else{
          (await updateBrandPlanSqlUsecase.execute(planBrand)).fold((failure) {
            emit(UpdateAmountErrorState(failure: failure));
            return false;
          }, (data) async {
            emit(UpdateAmountState());
          });
        }

      }
    });

  }
  void isSum(){
     sum=0;
    for(int i=0;i<planBrand.length;i++){
      sum=sum+(planBrand[i].amount*planBrand[i].sampleCoast);
    }
    print(sum);
  }
}
