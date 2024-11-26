// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_sp_usecase.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_usecase.dart';
import 'package:domina_app/domain/usecase/async_data_sql_usecase.dart';
import 'package:domina_app/domain/usecase/check_active_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/delete_all_sql_usecase.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/get_visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/get_visit_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/update_active_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:flutter/material.dart';
part 'async_event.dart';
part 'async_state.dart';

class AsyncBloc extends Bloc<AsyncEvent, AsyncState> {
  AllBrandsUsecase allBrandsUsecase;
  //AllPharmacyUsecase allPharmacyUsecase;
  AllPlaceUsecase allPlaceUsecase;
  AllSpeUsecase allSpeUsecase;
  AsyncDataSqlUsecase asyncDataSqlUsecase;
  AllHospitalUsecase allhospitalUsecase;
  AllDoctorUsecase allDoctorUsecase;
  AllHospialSpUsecase allHospialSpUsecase;
  AllBrandsSpUsecase allBrandsSpUsecase;
  AllPlanBrandsUsecase allPlanBrandsUsecase;
  EditIsLoginSqlUsecase editIsLoginSqlUsecase;
  CheckActiveBrandPlanSqlUsecase checkActiveBrandPlanSqlUsecase;
  UpdateActiveSqlUsecase updateActiveSqlUsecase;
  GetVisitDoctorUsecase getVisitDoctorUsecase;
  GetVisitHospitalUsecase getVisitHospitalUsecase;
  DeleteAllSqlUsecase deleteAllSqlUsecase;

  List<BrandModel> brands = [];
  List<PharmacyModel> pharmacies = [];
  List<PlaceModel> places = [];
  List<SpecDModel> spec = [];
  List<DoctorModel> doctors = [];
  List<HospitalModel> hospitals = [];
  List<HospitalSpModel> hospitalSps = [];
  List<BrandSpModel> brandSpModel = [];
  List<PlanBrandModel> planBrands = [];
  VisitDoctorBase? visitDoctor;
  VisitHospitalBase? visitHospital;
  LoginModel? checkActiveModel;
  int loading = 0;
  AsyncBloc(
      this.allBrandsUsecase,
    //  this.allPharmacyUsecase,
      this.allPlaceUsecase,
      this.allSpeUsecase,
      this.asyncDataSqlUsecase,
      this.allDoctorUsecase,
      this.allhospitalUsecase,
      this.allHospialSpUsecase,
      this.editIsLoginSqlUsecase,
      this.allBrandsSpUsecase,
      this.allPlanBrandsUsecase,
      this.checkActiveBrandPlanSqlUsecase,
      this.updateActiveSqlUsecase,
      this.getVisitDoctorUsecase,
      this.getVisitHospitalUsecase,
      this.deleteAllSqlUsecase)
      : super(AsyncInitial()) {
    on<AsyncEvent>((event, emit) async {
      Future<bool> setData() async {
        emit(LoadingState(12));
        final result = await asyncDataSqlUsecase.execute(
            brands,
        //    pharmacies,
            places,
            spec,
            doctors,
            hospitals,
            hospitalSps,
            brandSpModel,
            visitHospital!,
            visitDoctor!,
             planBrands: planBrands
         //   (UserInfo.flag1 == 0)?

        //        :null
          ,);
        result.fold((failure) {
          emit(SyncDataErrorState(failure: failure));
          return false;
        }, (data) {
          print("brand");
          brands = [];
      //    pharmacies = [];
          places = [];
          spec = [];
          doctors = [];
          hospitalSps = [];
          planBrands = [];
          brandSpModel = [];
          hospitals = [];
          visitDoctor?.brand = [];
          visitDoctor?.data = [];
          visitHospital?.brand = [];
          visitHospital?.data = [];
          emit(SyncDataState());
        });

        return false;
      }

      Future<bool> getData() async {
        try {
          brands = [];
          places = [];
   //       pharmacies = [];
          spec = [];
          hospitalSps = [];
          hospitals = [];
          brandSpModel = [];
          planBrands = [];
          visitDoctor?.brand = [];
          visitDoctor?.data = [];
          visitHospital?.brand = [];
          visitHospital?.data = [];

          final brandsResult =
              await allBrandsUsecase.execute(UserInfo.activePlanId);
          final brandsFailureOrSuccess =
              brandsResult.fold((failure) => failure, (data) => data);
          if (brandsFailureOrSuccess is Failure) {
            emit(SyncDataErrorState(failure: brandsFailureOrSuccess));
            return false;
          }
          brands = brandsFailureOrSuccess as List<BrandModel>;
          emit(LoadingState(1));
          final visitDoctorResult = await getVisitDoctorUsecase.execute(
              UserInfo.activePlanId.toString(), UserInfo.repId.toString());
          final visitDoctorFailureOrSuccess =
              visitDoctorResult.fold((failure) => failure, (data) => data);
          if (visitDoctorFailureOrSuccess is Failure) {
            emit(SyncDataErrorState(failure: visitDoctorFailureOrSuccess));
            return false;
          }
          visitDoctor = visitDoctorFailureOrSuccess as VisitDoctorBase;
          emit(LoadingState(2));
          final visitHospitalResult = await getVisitHospitalUsecase.execute(
              UserInfo.activePlanId, UserInfo.repId);
          final visitHospitalFailureOrSuccess =
              visitHospitalResult.fold((failure) => failure, (data) => data);
          if (visitHospitalFailureOrSuccess is Failure) {
            emit(SyncDataErrorState(failure: visitHospitalFailureOrSuccess));
            return false;
          }
          visitHospital = visitHospitalFailureOrSuccess as VisitHospitalBase;
       //   if ((UserInfo.flag1 == 0)) {
            emit(LoadingState(3));
            final planBrandsResult = await allPlanBrandsUsecase.execute(
                UserInfo.activePlanId, UserInfo.otherPlanId ?? 0);
            final planBrandsFailureOrSuccess =
                planBrandsResult.fold((failure) => failure, (data) => data);
            if (planBrandsFailureOrSuccess is Failure) {
              emit(SyncDataErrorState(failure: planBrandsFailureOrSuccess));
              return false;
            }
            planBrands = planBrandsFailureOrSuccess as List<PlanBrandModel>;
       //   }

          emit(LoadingState(4));
          try {
            final doctorsResult =
                await allDoctorUsecase.execute(UserInfo.repId);
            final doctorsFailureOrSuccess =
                doctorsResult.fold((failure) => failure, (data) => data);
            if (doctorsFailureOrSuccess is Failure) {
              emit(SyncDataErrorState(failure: doctorsFailureOrSuccess));
              return false;
            }
            doctors = doctorsFailureOrSuccess as List<DoctorModel>;
            emit(LoadingState(5));
          } catch (e) {
            emit(SyncDataErrorState(failure: Failure(2, e.toString())));
          }
          /////////////////////////////////////////////////

          final hospitalsResult =
              await allhospitalUsecase.execute(UserInfo.repId);
          final hospitalsFailureOrSuccess =
              hospitalsResult.fold((failure) => failure, (data) => data);
          if (hospitalsFailureOrSuccess is Failure) {
            emit(SyncDataErrorState(failure: hospitalsFailureOrSuccess));
            return false;
          }

          hospitals = hospitalsFailureOrSuccess as List<HospitalModel>;
          emit(LoadingState(6));

          ////////////////////////////////////////////////
//           final pharmaciesResult =
//               await allPharmacyUsecase.execute(UserInfo.repId);
//           final pharmaciesFailureOrSuccess =
//               pharmaciesResult.fold((failure) => failure, (data) => data);
//           if (pharmaciesFailureOrSuccess is Failure) {
//             emit(SyncDataErrorState(failure: pharmaciesFailureOrSuccess));
//             return false;
//           }
//
//           pharmacies = pharmaciesFailureOrSuccess as List<PharmacyModel>;
//           emit(LoadingState(7));
//
// /////////////////////////////////////////////////////

          final placesResult = await allPlaceUsecase.execute(UserInfo.repId);
          final placesFailureOrSuccess =
              placesResult.fold((failure) => failure, (data) => data);
          if (placesFailureOrSuccess is Failure) {
            emit(SyncDataErrorState(failure: placesFailureOrSuccess));
            return false;
          }

          places = placesFailureOrSuccess as List<PlaceModel>;
          emit(LoadingState(8));

///////////////////////////////////////////////////////////
          final specResult = await allSpeUsecase.execute(UserInfo.repId);
          final specFailureOrSuccess =
              specResult.fold((failure) => failure, (data) => data);
          if (specFailureOrSuccess is Failure) {
            emit(SyncDataErrorState(failure: specFailureOrSuccess));
            return false;
          }

          spec = specFailureOrSuccess as List<SpecDModel>;
          emit(LoadingState(9));

///////////////////////////////////////
          final hospitalSpsResult =
              await allHospialSpUsecase.execute(UserInfo.repId);
          final hospitalSpsFailureOrSuccess =
              hospitalSpsResult.fold((failure) => failure, (data) => data);
          if (hospitalSpsFailureOrSuccess is Failure) {
            emit(SyncDataErrorState(failure: hospitalSpsFailureOrSuccess));
            return false;
          }
          hospitalSps = hospitalSpsFailureOrSuccess as List<HospitalSpModel>;
          emit(LoadingState(10));

          /////////////////////////
          final brandSpsResult =
              await allBrandsSpUsecase.execute(UserInfo.repId);
          final brandSpFailureOrSuccess =
              brandSpsResult.fold((failure) => failure, (data) => data);
          if (brandSpFailureOrSuccess is Failure) {
            emit(SyncDataErrorState(failure: brandSpFailureOrSuccess));
            return false;
          }
          brandSpModel = brandSpFailureOrSuccess as List<BrandSpModel>;
          emit(LoadingState(11));

////////////////////////////////////////////////

          emit(getDataSucState());
          return true;
        } catch (error) {
          emit(SyncDataErrorState(failure: Failure(-9, error.toString())));
          return false;
        }
      }

      if (event is AsyncDataEvent) {
        await getData();
      }
      if (event is SetDataSEvent) {
        await setData();
      }
      if (event is DeleteAllEvent) {
        //   emit(DeleteAllLoadingState());
        (await deleteAllSqlUsecase.execute()).fold((failure) {
          emit(DeleteAllErrorState(failure: failure));
          return false;
        }, (data) async {
          emit(DeleteAllState());
        });
      } else if (event is EditEvent) {
        (await editIsLoginSqlUsecase.execute(UserInfo.repId, event.num)).fold(
            (failure) {
          emit(EditStatusDErrorState(failure: failure));
          return false;
        }, (data) async {
          UserInfo.isLogging = event.num;
          emit(EditStatusDState());
        });
      }
      if (event is PlanIsActiveEvent) {
        emit(SyncDataLoadingState(0));
        (await checkActiveBrandPlanSqlUsecase.execute(UserInfo.repId)).fold(
            (failure) {
          emit(IsActiveErrorState(failure: failure));
        }, (data) async {
          checkActiveModel = data;
          UserInfo.activePlanId = data.activePlanId;
          UserInfo.otherPlanId = data.otherPlanId ?? 0;
          UserInfo.otherstatus = data.otherStatus ?? -1;
          UserInfo.percentage = data.percentage;
          UserInfo.recipesCount = data.recipesCount;
          UserInfo.startDate = data.startDate;
          UserInfo.endDate = data.endDate;
          UserInfo.otherStartDate = data.otherStartDate;
          UserInfo.otherEndDate = data.otherEndDate;
          UserInfo.flag1= (data.otherStatus==0&&UserInfo.flag==1)?0:1;
          emit(IsActiveState());
        });
      }
      if (event is UpdateRepEvent) {
        (await updateActiveSqlUsecase.execute(
                UserInfo.repId,
                checkActiveModel!.otherPlanId ?? 9,
                checkActiveModel!.activePlanId,
                checkActiveModel!.otherStatus ?? 9,
                checkActiveModel!.startDate,
                checkActiveModel!.endDate,
                checkActiveModel!.otherStartDate ?? "",
                checkActiveModel!.otherEndDate ?? ""))
            .fold((failure) {
          emit(UpdateIsActiveErrorState(failure: failure));
        }, (data) async {
          if (checkActiveModel?.otherStatus != null) {
            UserInfo.flag = checkActiveModel?.otherStatus == 0 ? 0 : 1;
          }
          emit(UpdateIsActiveState());
        });
      }
    });
  }
}
