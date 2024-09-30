import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase%20.dart';
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
  EditIsLoginSqlUsecase editIsLoginSqlUsecase;
  List<BrandModel> brands = [];
  List<PharmacyModel> pharmacies = [];
  List<PlaceModel> places = [];
  List<SpecModel> spec = [];
  List<DoctorModel> doctors = [];
  List<HospitalModel> hospitals = [];
  List<HospitalSpModel> hospitalSps = [];

  AsyncBloc(
      this.allBrandsUsecase,
      this.allPharmacyUsecase,
      this.allPlaceUsecase,
      this.allSpeUsecase,
      this.asyncDataSqlUsecase,
      this.allDoctorUsecase,
      this.allhospitalUsecase,
      this.allHospialSpUsecase,
      this.editIsLoginSqlUsecase
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

      if(event is EditEvent){
        (await editIsLoginSqlUsecase.execute(UserInfo.repId,2)).fold((failure) {
          emit(SyncDataErrorState(failure: failure));
          return false;
        }, (data) async {

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
    (await allBrandsUsecase.execute(UserInfo.repId)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      brands = data;
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

    return false;
  }



}
