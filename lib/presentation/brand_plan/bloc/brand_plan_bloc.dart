import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/usecase/all_brand_plan_sql_usecase.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_other_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_other_status_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'brand_plan_event.dart';
part 'brand_plan_state.dart';

class BrandPlanBloc extends Bloc<BrandPlanEvent, BrandPlanState> {
  AllBrandPlanSqlUsecase allBrandPlanSqlUsecase;
  UpdateBrandPlanSqlUsecase updateBrandPlanSqlUsecase;
  UpdateOtherStatusUsecase updateOtherStatusUsecase;
  AllOtherBrandPlanSqlUsecase allOtherBrandPlanSqlUsecase;
  List<OtherBrandSpPlanModel> planBrand = [];
  List<BrandSpPlanModel> planBrandActive = [];
  int sum = 0;
  int sumS = 0;
  int current = 0;
  BrandPlanBloc(this.updateBrandPlanSqlUsecase, this.allBrandPlanSqlUsecase,
      this.updateOtherStatusUsecase, this.allOtherBrandPlanSqlUsecase)
      : super(BrandPlanInitial()) {
    on<BrandPlanEvent>((event, emit) async {
      if (event is AllBrandPlanEvent) {
        (await allBrandPlanSqlUsecase.execute(UserInfo.activePlanId)).fold(
            (failure) {
          emit(AllBrandPlanErrorState(failure: failure));
          return false;
        }, (data) async {
          planBrandActive = data;
          emit(AllBrandPlanState(data));
        });
        if (UserInfo.otherPlanId != null) {
          (await allOtherBrandPlanSqlUsecase.execute(UserInfo.otherPlanId ?? 0))
              .fold((failure) {
            emit(AllBrandPlanErrorState(failure: failure));
            return false;
          }, (data) async {
            if (data.isEmpty) {
              emit(AllBrandPlanEmptyState());
            } else {
              planBrand = data;
              isSum();
              emit(AllOtherBrandPlanState(data));
            }
          });
        }
      }
      if (event is ChangeFieldEvent) {
        int sum1 = sum;
        sum1 = sum1 -
            (planBrand[event.index].brands[event.indexBr].amount *
                planBrand[event.index].brands[event.indexBr].sampleCoast);
        sum1 = sum1 +
            (event.number *
                planBrand[event.index].brands[event.indexBr].sampleCoast);
        int sum2 = sumS;
        sum2 = sum2 - planBrand[event.index].brands[event.indexBr].amount;
        sum2 = sum2 + event.number;
        print(event.brandM);
        print("event.brandM");
        if (sum2 <= event.brandM) {
          if (sum1 < UserInfo.percentage) {
            planBrand[event.index].brands[event.indexBr].amount = event.number;
            sum = sum1;
            sumS = sum2;
            emit(SumState(planBrand));
          } else {
            planBrand[event.index].brands[event.indexBr].amount = event.number;
            sum = sum1;
            sumS = sum2;
            emit(SumErrorState(
                failure: Failure(100, "لقد تجاوزت الحد المسموح ")));
          }
        } else {
          planBrand[event.index].brands[event.indexBr].amount = event.number;
          sumS = sum2;
          emit(SumErrorState(
              failure: Failure(
                  100, " لقد تجاوزت الحد المسموح للعينات في هذا اللاختصاص")));
        }
      }
      if (event is UpdateEvent) {
        List<OtherBrandSpPlanModel> planBrandSum = List.from(planBrand);
        emit(SumState(planBrandSum));
      }
      if (event is SendToS) {
        emit(UpdateAmountLoadingState());
        if (sum > UserInfo.percentage) {
          emit(UpdateAmountErrorState(
              failure: Failure(5, "لقد تجاوزت الحد المسموح")));
        }else {
          UserInfo.otherstatus = 1;
          (await updateOtherStatusUsecase.execute(UserInfo.repId, 1, planBrand))
              .fold((failure) {
            emit(UpdateAmountErrorState(failure: failure));
            return false;
          }, (data) async {
            emit(UpdateAmountState());
          });
        }
      }
      if (event is UpdateAmountSucEvent) {
        emit(UpdateAmountLoadingState());
        if (sum > UserInfo.percentage) {
          emit(UpdateAmountErrorState(
              failure: Failure(5, "لقد تجاوزت الحد المسموح")));
        } else {
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
  void isSum() {
    sum = 0;
    for (int i = 0; i < planBrand.length; i++) {
      for (int j = 0; j < planBrand[i].brands.length; j++) {
        sum = sum +
            (planBrand[i].brands[j].amount *
                planBrand[i].brands[j].sampleCoast);
      }
    }
    print(sum);
  }
}
