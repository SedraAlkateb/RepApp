// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/delete_all_sql_usecase.dart';
import 'package:domina_app/domain/usecase/delete_sql_usecase.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_pharmacy_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_hospital_sp_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_pharmacy_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_plan_brand_sql_usecase.dart';
import 'package:domina_app/domain/usecase/is_active_usecase.dart';
import 'package:domina_app/domain/usecase/plan_brand_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_sql_usecase.dart';
import 'package:domina_app/domain/usecase/visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/visit_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/visit_pharmacy_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'async_in_event.dart';
part 'async_in_state.dart';

class AsyncInBloc extends Bloc<AsyncInEvent, AsyncInState> {
  IsActiveUsecase isActiveUsecase;
  VisitDoctorUsecase visitDoctorUsecase;
  VisitPharmacyUsecase visitPharmacyUsecase;
  VisitHospitalUsecase visitHospitalUsecase;
  PlanBrandUsecase planBrandUsecase;
  UpdateFlagSqlUsecase updateFlagSqlUsecase;
  GetBrandsDoctorVisitsSqlUsecase getBrandsDoctorVisitsSqlUsecase;
  GetBrandsHospitalVisitsSqlUsecase getBrandsHospitalVisitsSqlUsecase;
  GetBrandsPharmacyVisitsSqlUsecase getBrandsPharmacyVisitsSqlUsecase;
  GetDoctorVisitsSqlUsecase getDoctorVisitsSqlUsecase;
  GetHospitalVisitsSqlUsecase getHospitalVisitsSqlUsecase;
  GetPharmacyVisitsSqlUsecase getPharmacyVisitsSqlUsecase;
  GetHospitalSpVisitsSqlUsecase getHospitalSpVisitsSqlUsecase;
  GetPlanBrandSqlUsecase getPlanBrandSqlUsecase;
  EditIsLoginSqlUsecase editIsLoginSqlUsecase;
  DeleteSqlUsecase deleteSqlUsecase;
  DeleteAllSqlUsecase deleteAllSqlUsecase;
  List<PlanBrandModel> planBrands = [];
  List<VisitBrandPharmacyModel> visitBrandPharmacies = [];
  List<VisitBrandPharmacyModel> visitBrandDoctors = [];
  List<VisitBrandPharmacyModel> visitBrandHospitals = [];
  List<VisitPharmacyModel> visitPharmacies = [];
  List<VisitHospitalModel> visitHospitals = [];
  List<VisitDoctorModel> visitDoctors = [];
  bool suc = false;
  AsyncInBloc(
      this.isActiveUsecase,
      this.editIsLoginSqlUsecase,
      this.visitPharmacyUsecase,
      this.visitDoctorUsecase,
      this.visitHospitalUsecase,
      this.getBrandsPharmacyVisitsSqlUsecase,
      this.getBrandsDoctorVisitsSqlUsecase,
      this.getBrandsHospitalVisitsSqlUsecase,
      this.getHospitalVisitsSqlUsecase,
      this.getHospitalSpVisitsSqlUsecase,
      this.getDoctorVisitsSqlUsecase,
      this.getPharmacyVisitsSqlUsecase,
      this.getPlanBrandSqlUsecase,
      this.deleteSqlUsecase,
      this.deleteAllSqlUsecase,
      this.planBrandUsecase,
      this.updateFlagSqlUsecase)
      : super(AsyncInInitial()) {
    on<AsyncInEvent>((event, emit) async {
      if (event is DeleteBaseEvent) {
        emit(DeleteBaseLoadingState());
        (await deleteSqlUsecase.execute()).fold((failure) {
          emit(DeleteBaseErrorState(failure: failure));
          return false;
        }, (data) async {
          emit(DeleteBaseState());
        });
      }
      if (event is DeleteAllEvent) {
        emit(DeleteAllLoadingState());
        (await deleteAllSqlUsecase.execute()).fold((failure) {
          emit(DeleteAllErrorState(failure: failure));
          return false;
        }, (data) async {
          emit(DeleteAllState());
        });
      }
      if (event is UpdateFlagEvent) {
        (await updateFlagSqlUsecase.execute((visitHospitals.isNotEmpty||visitBrandHospitals.isNotEmpty),(visitDoctors.isNotEmpty||visitBrandDoctors.isNotEmpty))).fold((failure) {
          emit(UpdateFlagErrorState(failure: failure));
          return false;
        }, (data) async {
          emit(UpdateFlagState());
        });
      }
      if (event is Async1DataEvent) {
        emit(SyncData1LoadingState());
        bool b = await getData();
        if (b) {
          await setData();
        }
      }
      else if(event is EditEventIn){
        (await editIsLoginSqlUsecase.execute(UserInfo.repId,event.num)).fold((failure) {
          emit(EditStatusSErrorState(failure: failure));
          return false;
        }, (data) async {
          UserInfo.isLogging=event.num;
         emit( EditStatusState());
       print("EditStatusState");
        });
      }
    });
  }

  Future<bool> getData() async {
    try {
      planBrands = [];
      visitBrandPharmacies = [];
      visitBrandDoctors = [];
      visitBrandHospitals = [];
      visitPharmacies = [];
      visitHospitals = [];
      visitDoctors = [];

      final brandPharmaciesResult = await getBrandsPharmacyVisitsSqlUsecase.execute();
      final brandPharmaciesFailureOrSuccess = brandPharmaciesResult.fold((failure) => failure, (data) => data);
      if (brandPharmaciesFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(failure: brandPharmaciesFailureOrSuccess));
        return false;
      }
      visitBrandPharmacies = brandPharmaciesFailureOrSuccess as List<VisitBrandPharmacyModel>;

      ///////////////////////////////////////////////////s

      final brandDoctorsResult = await getBrandsDoctorVisitsSqlUsecase.execute();
      final brandDoctorsFailureOrSuccess = brandDoctorsResult.fold((failure) => failure, (data) => data);
      if (brandDoctorsFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(failure: brandDoctorsFailureOrSuccess));
        return false;
      }
      visitBrandDoctors = brandDoctorsFailureOrSuccess as List<VisitBrandPharmacyModel>;

      ///////////////////////////////////////////////////

      final brandHospitalsResult = await getBrandsHospitalVisitsSqlUsecase.execute();
      final brandHospitalsFailureOrSuccess = brandHospitalsResult.fold((failure) => failure, (data) => data);
      if (brandHospitalsFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(failure: brandHospitalsFailureOrSuccess));
        return false;
      }
      visitBrandHospitals = brandHospitalsFailureOrSuccess as List<VisitBrandPharmacyModel>;

      ///////////////////////////////////////////////////

      final pharmaciesResult = await getPharmacyVisitsSqlUsecase.execute();
      final pharmaciesFailureOrSuccess = pharmaciesResult.fold((failure) => failure, (data) => data);
      if (pharmaciesFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(failure: pharmaciesFailureOrSuccess));
        return false;
      }
      visitPharmacies = pharmaciesFailureOrSuccess as List<VisitPharmacyModel>;

      ///////////////////////////////////////////////////

      final doctorsResult = await getDoctorVisitsSqlUsecase.execute();
      final doctorsFailureOrSuccess = doctorsResult.fold((failure) => failure, (data) => data);
      if (doctorsFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(failure: doctorsFailureOrSuccess));
        return false;
      }
      visitDoctors = doctorsFailureOrSuccess as List<VisitDoctorModel>;
      ///////////////////////////////////////////////////


      final hospitalsResult = await getHospitalVisitsSqlUsecase.execute();
      final hospitalsFailureOrSuccess = hospitalsResult.fold((failure) => failure, (data) => data);
      if (hospitalsFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(failure: hospitalsFailureOrSuccess));
        return false;
      }
      visitHospitals = hospitalsFailureOrSuccess as List<VisitHospitalModel>;

      ///////////////////////////////////////////////////
   if(UserInfo.otherstatus==1){
     final planBrandsResult = await getPlanBrandSqlUsecase.execute();
     final planBrandsFailureOrSuccess = planBrandsResult.fold((failure) => failure, (data) => data);
     if (planBrandsFailureOrSuccess is Failure) {
       emit(SyncData1ErrorState(failure: planBrandsFailureOrSuccess));
       return false;}
     planBrands = planBrandsFailureOrSuccess as List<PlanBrandModel>;
   }

      return true;
    } catch (error) {
      emit(SyncData1ErrorState(failure: Failure(-9, error.toString())));
      return false;
    }
  }
  Future<bool> setData() async {
    try {
      if (visitPharmacies.isNotEmpty || visitBrandPharmacies.isNotEmpty) {
        final visitPharmacyResult = await visitPharmacyUsecase.execute(
            VisitPharmacyRequestBody(visitPharmacies, visitBrandPharmacies));
        final visitPharmacyFailureOrSuccess = visitPharmacyResult.fold((failure) => failure, (data) => data);
        if (visitPharmacyFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(failure: visitPharmacyFailureOrSuccess));
          return false;
        }
        print("Visit Pharmacy data sent successfully.");
      }
      if (visitDoctors.isNotEmpty || visitBrandDoctors.isNotEmpty) {
        final visitDoctorResult = await visitDoctorUsecase.execute(
            VisitDoctorRequestBody(visitDoctors, visitBrandDoctors));
        final visitDoctorFailureOrSuccess = visitDoctorResult.fold((failure) => failure, (data) => data);
        if (visitDoctorFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(failure: visitDoctorFailureOrSuccess));
          return false;
        }
        print("Visit Doctor data sent successfully.");
      }
      if (visitHospitals.isNotEmpty || visitBrandHospitals.isNotEmpty ) {
        final visitHospitalResult = await visitHospitalUsecase.execute(
            VisitHospitalRequestBody(visitHospitals, visitBrandHospitals
            ));
        final visitHospitalFailureOrSuccess = visitHospitalResult.fold((failure) => failure, (data) => data);
        if (visitHospitalFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(failure: visitHospitalFailureOrSuccess));
          return false;
        }
        print("Visit Hospital data sent successfully.");
      }

    if(UserInfo.otherstatus==1){
      final planBrandResult = await planBrandUsecase.execute(RepPlanBrandBody(planBrands));
      final planBrandFailureOrSuccess = planBrandResult.fold((failure) => failure, (data) => data);
      if (planBrandFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(failure: planBrandFailureOrSuccess));
        return false;
      }
      print("Plan Brand data sent successfully.");
    }
      emit(SyncData1State());
      return true;
    } catch (e) {
      print("Error occurred in setData: $e");
      return false;
    }
  }
}
