import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospitals_sql_usecase%20.dart';
import 'package:domina_app/domain/usecase/async_data_sql_usecase.dart';
import 'package:domina_app/domain/usecase/delete_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_all_hospitals_sp_sql_usecase%20.dart';
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
  DeleteSqlUsecase deleteSqlUsecase;
  AsyncDataSqlUsecase asyncDataSqlUsecase;
  AllHospitalUsecase allhospitalUsecase;
  AllDoctorUsecase allDoctorUsecase;
  AllHospialSpUsecase allHospialSpUsecase;
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
      this.deleteSqlUsecase,
      this.asyncDataSqlUsecase,
      this.allDoctorUsecase,
      this.allhospitalUsecase,
      this.allHospialSpUsecase
      ) : super(AsyncInitial()) {
    on<AsyncEvent>((event, emit)async {
      if (event is AsyncDataEvent) {
        emit(SyncDataLoadingState());
        (await deleteSqlUsecase.execute()).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
      }, (data) async {
     bool b = await getData();
     if(b){
      await setData();
     }
      });
    }
    });

  }
  Future<bool> getData() async {
    brands=[];
    places=[];
    pharmacies=[];
    spec=[];
    (await allBrandsUsecase.execute(117)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      brands = data;
    });
    (await allDoctorUsecase.execute(117)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      doctors = data;
    });
    (await allhospitalUsecase.execute(117)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      hospitals = data;
    });
    (await allPharmacyUsecase.execute(
      117
       // UserInfo.repId
    )).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      pharmacies = data;
    });
    (await allPlaceUsecase.execute(
       // UserInfo.repId
    117
    )).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      places = data;
    });
    (await allSpeUsecase.execute(
        //UserInfo.repId
    117
    )).fold((failure) {
      emit(SyncDataErrorState(failure: failure));

      return false;
    }, (data) async {
      spec = data;

    });
    (await allHospialSpUsecase.execute(
      //UserInfo.repId
        117
    )).fold((failure) {
      emit(SyncDataErrorState(failure: failure));

      return false;
    }, (data) async {
      hospitalSps = data;

    });
    return true;
  }
  Future<bool> setData() async {
    (await asyncDataSqlUsecase.execute(brands,pharmacies,places,spec,doctors,hospitals,hospitalSps)).fold((failure) {
      emit(SyncDataErrorState(failure: failure));
      return false;
    }, (data) async {
      print("brand");
      brands = [];
      pharmacies=[];
      places=[];
      spec=[];
      emit(SyncDataState());
      return true;
    });
return false;
  }
}
