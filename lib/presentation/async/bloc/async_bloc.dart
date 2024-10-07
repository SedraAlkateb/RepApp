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
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_pharmacy_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:flutter/material.dart';
part 'async_event.dart';
part 'async_state.dart';
class AsyncBloc extends Bloc<AsyncEvent, AsyncState> {
  AllBrandsUsecase allBrandsUsecase;
  AllPharmacyUsecase allPharmacyUsecase;
  AllPlaceUsecase allPlaceUsecase;
  AllSpeUsecase allSpeUsecase;
  AsyncDataSqlUsecase asyncDataSqlUsecase;
  AllHospitalUsecase allhospitalUsecase;
  AllDoctorUsecase allDoctorUsecase;
  AllHospialSpUsecase allHospialSpUsecase;
  AllBrandsSpUsecase allBrandsSpUsecase;
  AllPlanBrandsUsecase allPlanBrandsUsecase;
  EditIsLoginSqlUsecase editIsLoginSqlUsecase;
  List<BrandModel> brands = [];
  List<PharmacyModel> pharmacies = [];
  List<PlaceModel> places = [];
  List<SpecModel> spec = [];
  List<DoctorModel> doctors = [];
  List<HospitalModel> hospitals = [];
  List<HospitalSpModel> hospitalSps = [];
  List<BrandSpModel> brandSpModel = [];
  List<PlanBrandModel> planBrands=[];
  AsyncBloc(
      this.allBrandsUsecase,
      this.allPharmacyUsecase,
      this.allPlaceUsecase,
      this.allSpeUsecase,
      this.asyncDataSqlUsecase,
      this.allDoctorUsecase,
      this.allhospitalUsecase,
      this.allHospialSpUsecase,
      this.editIsLoginSqlUsecase,
      this.allBrandsSpUsecase,
      this.allPlanBrandsUsecase
      )
      : super(AsyncInitial()) {
    on<AsyncEvent>((event, emit) async {
      if (event is AsyncDataEvent) {
        emit(SyncDataLoadingState());
        bool b = await getData();
        if (b) {
          await setData();

        }

      }
     else if(event is EditEvent){
        (await editIsLoginSqlUsecase.execute(UserInfo.repId,event.num)).fold((failure) {
          emit(EditStatusDErrorState(failure: failure));
          return false;
        }, (data) async {
          UserInfo.isLogging=event.num;
          emit(EditStatusDState());
        });
      }
    });
  }
  Future<bool> getData() async {
    brands = [];
    places = [];
    pharmacies = [];
    spec = [];
    hospitalSps=[];
    hospitals=[];
    brandSpModel=[];
    planBrands=[];
    (await allBrandsUsecase.execute(UserInfo.activePlanId)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      brands = data;
    });
    (await allPlanBrandsUsecase.execute(UserInfo.activePlanId,UserInfo.otherPlanId)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      planBrands = data;
    });
    (await allDoctorUsecase.execute(UserInfo.repId)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      doctors = data;
    });
    (await allhospitalUsecase.execute(UserInfo.repId)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      hospitals = data;
    });
    (await allPharmacyUsecase.execute(UserInfo.repId
      // UserInfo.repId
    ))
        .fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      pharmacies = data;
    });
    (await allPlaceUsecase.execute(
      // UserInfo.repId
        UserInfo.repId)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      places = data;
    });
    (await allSpeUsecase.execute(
      //UserInfo.repId
        UserInfo.repId)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));

      return false;
    }, (data) async {
      spec = data;
    });
    (await allHospialSpUsecase.execute(UserInfo.repId)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));

      return false;
    }, (data) async {
      hospitalSps = data;
    });
    return true;
  }
  Future<bool> setData() async {
    final result = await asyncDataSqlUsecase.execute(
      brands,
      pharmacies,
      places,
      spec,
      doctors,
      hospitals,
      hospitalSps,
      brandSpModel,
      planBrands
    );
    result.fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) {
      print("brand");
      brands = [];
      pharmacies = [];
      places = [];
      spec = [];
      hospitalSps=[];
      emit(SyncDataState());
    });
    (await allBrandsSpUsecase.execute(UserInfo.repId)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      brandSpModel = data;
    });
    return false;
  }



}
