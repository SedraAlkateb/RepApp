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
  CheckActiveBrandPlanSqlUsecase checkActiveBrandPlanSqlUsecase;
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
      this.allPlanBrandsUsecase,
      this.checkActiveBrandPlanSqlUsecase
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
    try {
      // تهيئة القوائم الفارغة
      brands = [];
      places = [];
      pharmacies = [];
      spec = [];
      hospitalSps = [];
      hospitals = [];
      brandSpModel = [];
      planBrands = [];
      final brandsResult = await allBrandsUsecase.execute(UserInfo.activePlanId);
      final brandsFailureOrSuccess = brandsResult.fold((failure) => failure, (data) => data);
      if (brandsFailureOrSuccess is Failure) {
        emit(SyncDataErrorState(failure: brandsFailureOrSuccess));
        return false; // توقف عند الفشل
      }
      brands = brandsFailureOrSuccess as List<BrandModel>;

      // استدعاء بيانات الخطة والعلامات التجارية
      final planBrandsResult = await allPlanBrandsUsecase.execute(UserInfo.activePlanId, UserInfo.otherPlanId);
      final planBrandsFailureOrSuccess = planBrandsResult.fold((failure) => failure, (data) => data);
      if (planBrandsFailureOrSuccess is Failure) {
        emit(SyncDataErrorState(failure: planBrandsFailureOrSuccess));
        return false; // توقف عند الفشل
      }
      planBrands = planBrandsFailureOrSuccess as List<PlanBrandModel>;

      // استدعاء بيانات الأطباء
      final doctorsResult = await allDoctorUsecase.execute(UserInfo.repId);
      final doctorsFailureOrSuccess = doctorsResult.fold((failure) => failure, (data) => data);
      if (doctorsFailureOrSuccess is Failure) {
        emit(SyncDataErrorState(failure: doctorsFailureOrSuccess));
        return false; // توقف عند الفشل
      }
      doctors = doctorsFailureOrSuccess as List<DoctorModel>;

      // استدعاء بيانات المستشفيات
      final hospitalsResult = await allhospitalUsecase.execute(UserInfo.repId);
      final hospitalsFailureOrSuccess = hospitalsResult.fold((failure) => failure, (data) => data);
      if (hospitalsFailureOrSuccess is Failure) {
        emit(SyncDataErrorState(failure: hospitalsFailureOrSuccess));
        return false; // توقف عند الفشل
      }
      hospitals = hospitalsFailureOrSuccess as List<HospitalModel>;

      // استدعاء بيانات الصيدليات
      final pharmaciesResult = await allPharmacyUsecase.execute(UserInfo.repId);
      final pharmaciesFailureOrSuccess = pharmaciesResult.fold((failure) => failure, (data) => data);
      if (pharmaciesFailureOrSuccess is Failure) {
        emit(SyncDataErrorState(failure: pharmaciesFailureOrSuccess));
        return false; // توقف عند الفشل
      }
      pharmacies = pharmaciesFailureOrSuccess as List<PharmacyModel>;

      // استدعاء بيانات الأماكن
      final placesResult = await allPlaceUsecase.execute(UserInfo.repId);
      final placesFailureOrSuccess = placesResult.fold((failure) => failure, (data) => data);
      if (placesFailureOrSuccess is Failure) {
        emit(SyncDataErrorState(failure: placesFailureOrSuccess));
        return false; // توقف عند الفشل
      }
      places = placesFailureOrSuccess as List<PlaceModel>;

      // استدعاء بيانات التخصصات
      final specResult = await allSpeUsecase.execute(UserInfo.repId);
      final specFailureOrSuccess = specResult.fold((failure) => failure, (data) => data);
      if (specFailureOrSuccess is Failure) {
        emit(SyncDataErrorState(failure: specFailureOrSuccess));
        return false; // توقف عند الفشل
      }
      spec = specFailureOrSuccess as List<SpecModel>;

      // استدعاء بيانات التخصصات في المستشفيات
      final hospitalSpsResult = await allHospialSpUsecase.execute(UserInfo.repId);
      final hospitalSpsFailureOrSuccess = hospitalSpsResult.fold((failure) => failure, (data) => data);
      if (hospitalSpsFailureOrSuccess is Failure) {
        emit(SyncDataErrorState(failure: hospitalSpsFailureOrSuccess));
        return false; // توقف عند الفشل
      }
      hospitalSps = hospitalSpsFailureOrSuccess as List<HospitalSpModel>;

      // إذا تم كل شيء بنجاح
      emit(getDataSucState());
      return true;

    } catch (error) {
      emit(SyncDataErrorState(failure: Failure(-9, error.toString())));
      return false;
    }
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
