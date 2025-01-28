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
import 'package:domina_app/domain/usecase/is_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/plan_brand_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_hospital_sql_usecase.dart';
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
  UpdateFlagDoctorSqlUsecase updateFlagDoctorSqlUsecase;
  UpdateFlagHospitalSqlUsecase updateFlagHospitalSqlUsecase;
  GetBrandsDoctorVisitsSqlUsecase getBrandsDoctorVisitsSqlUsecase;
  GetBrandsHospitalVisitsSqlUsecase getBrandsHospitalVisitsSqlUsecase;
  GetBrandsPharmacyVisitsSqlUsecase getBrandsPharmacyVisitsSqlUsecase;
  GetDoctorVisitsSqlUsecase getDoctorVisitsSqlUsecase;
  GetHospitalVisitsSqlUsecase getHospitalVisitsSqlUsecase;
  GetPharmacyVisitsSqlUsecase getPharmacyVisitsSqlUsecase;
  GetHospitalSpVisitsSqlUsecase getHospitalSpVisitsSqlUsecase;
  GetPlanBrandSqlUsecase getPlanBrandSqlUsecase;
  IsPlanSqlUsecase isPlanSqlUsecase;

  List<PlanBrandModel> planBrands = [];
  List<VisitBrandPharmacyModel> visitBrandPharmacies = [];
  List<VisitBrandPharmacyModel> visitBrandDoctors = [];
  List<VisitBrandPharmacyModel> visitBrandHospitals = [];
//  List<VisitPharmacyModel> visitPharmacies = [];
  List<VisitHospitalModel> visitHospitals = [];
  List<VisitDoctorModel> visitDoctors = [];
  bool suc = false;
  AsyncInBloc(
      this.isPlanSqlUsecase,
      this.isActiveUsecase,
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
      this.planBrandUsecase,
      this.updateFlagDoctorSqlUsecase,
      this.updateFlagHospitalSqlUsecase)
      : super(AsyncInInitial()) {
    on<AsyncInEvent>((event, emit) async {
    if (event is Async1DataEvent) {
        emit(SyncData1LoadingState());
        await getData();
      }
    else if (event is Async0DataEvent) {
        emit(SyncData0LoadingState());
        await getData();
      }
    else if (event is GetEvent) {
        await setData();
      }

    });
  }

  Future<bool> getData() async {
    try {
      planBrands = [];
      //  visitBrandPharmacies = [];
      visitBrandDoctors = [];
      visitBrandHospitals = [];
      // visitPharmacies = [];
      visitHospitals = [];
      visitDoctors = [];
      // final brandPharmaciesResult =
      //     await getBrandsPharmacyVisitsSqlUsecase.execute();
      // final brandPharmaciesFailureOrSuccess =
      //     brandPharmaciesResult.fold((failure) => failure, (data) => data);
      // if (brandPharmaciesFailureOrSuccess is Failure) {
      //   emit(SyncData1ErrorState(failure: brandPharmaciesFailureOrSuccess));
      //   return false;
      // }
      // visitBrandPharmacies =
      //     brandPharmaciesFailureOrSuccess as List<VisitBrandPharmacyModel>;

      ///////////////////////////////////////////////////s

      final brandDoctorsResult =
          await getBrandsDoctorVisitsSqlUsecase.execute();
      final brandDoctorsFailureOrSuccess =
          brandDoctorsResult.fold((failure) => failure, (data) => data);
      if (brandDoctorsFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(
            failure: Failure(0, "${brandDoctorsFailureOrSuccess.massage} 14")));
        return false;
      }
      visitBrandDoctors =
          brandDoctorsFailureOrSuccess as List<VisitBrandPharmacyModel>;

      ///////////////////////////////////////////////////

      final brandHospitalsResult =
          await getBrandsHospitalVisitsSqlUsecase.execute();
      final brandHospitalsFailureOrSuccess =
          brandHospitalsResult.fold((failure) => failure, (data) => data);
      if (brandHospitalsFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(
            failure:
                Failure(0, "${brandHospitalsFailureOrSuccess.massage} 13")));
        return false;
      }
      visitBrandHospitals =
          brandHospitalsFailureOrSuccess as List<VisitBrandPharmacyModel>;

      ///////////////////////////////////////////////////

      // final pharmaciesResult = await getPharmacyVisitsSqlUsecase.execute();
      // final pharmaciesFailureOrSuccess =
      //     pharmaciesResult.fold((failure) => failure, (data) => data);
      // if (pharmaciesFailureOrSuccess is Failure) {
      //   emit(SyncData1ErrorState(failure: pharmaciesFailureOrSuccess));
      //   return false;
      // }
      // visitPharmacies = pharmaciesFailureOrSuccess as List<VisitPharmacyModel>;

      ///////////////////////////////////////////////////

      final doctorsResult = await getDoctorVisitsSqlUsecase.execute();
      final doctorsFailureOrSuccess =
          doctorsResult.fold((failure) => failure, (data) => data);
      if (doctorsFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(
            failure: Failure(0, "${doctorsFailureOrSuccess.massage} 12")));
        return false;
      }
      visitDoctors = doctorsFailureOrSuccess as List<VisitDoctorModel>;
      ///////////////////////////////////////////////////

      final hospitalsResult = await getHospitalVisitsSqlUsecase.execute();
      final hospitalsFailureOrSuccess =
          hospitalsResult.fold((failure) => failure, (data) => data);
      if (hospitalsFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(
            failure: Failure(0, "${hospitalsFailureOrSuccess.massage} 11")));
        return false;
      }
      visitHospitals = hospitalsFailureOrSuccess as List<VisitHospitalModel>;

      ///////////////////////////////////////////////////
      if (UserInfo.otherstatus == 1 && UserInfo.flag == 0) {
        final planBrandsResult = await getPlanBrandSqlUsecase.execute();
        final planBrandsFailureOrSuccess =
            planBrandsResult.fold((failure) => failure, (data) => data);
        if (planBrandsFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure: Failure(0, "${planBrandsFailureOrSuccess.massage} 10")));
          return false;
        }
        planBrands = planBrandsFailureOrSuccess as List<PlanBrandModel>;
      }
      emit(GetState());
      return true;
    } catch (error) {
      emit(SyncData1ErrorState(failure: Failure(-9, error.toString())));
      return false;
    }
  }

  Future<bool> setData() async {
    try {
      // if (visitPharmacies.isNotEmpty || visitBrandPharmacies.isNotEmpty) {
      //   final visitPharmacyResult = await visitPharmacyUsecase.execute(
      //       VisitPharmacyRequestBody(visitPharmacies, visitBrandPharmacies));
      //   final visitPharmacyFailureOrSuccess =
      //       visitPharmacyResult.fold((failure) => failure, (data) => data);
      //   if (visitPharmacyFailureOrSuccess is Failure) {
      //     emit(SyncData1ErrorState(failure: visitPharmacyFailureOrSuccess));
      //     return false;
      //   }
      //   print("Visit Pharmacy data sent successfully.");
      // }
      if (visitDoctors.isNotEmpty || visitBrandDoctors.isNotEmpty) {
        final visitDoctorResult = await visitDoctorUsecase
            .execute(VisitDoctorRequestBody(visitDoctors, visitBrandDoctors));
        final visitDoctorFailureOrSuccess =
            visitDoctorResult.fold((failure) => failure, (data) => data);
        if (visitDoctorFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure: Failure(0, "${visitDoctorFailureOrSuccess.massage} 1")));
          return false;
        }
        final visitDoctorFlagResult =
            await updateFlagDoctorSqlUsecase.execute();
        final visitDoctorFlagFailureOrSuccess =
            visitDoctorFlagResult.fold((failure) => failure, (data) => data);
        if (visitDoctorFlagFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure:
                  Failure(0, "${visitDoctorFlagFailureOrSuccess.massage} 2")));
          return false;
        }
      }
      if (visitHospitals.isNotEmpty || visitBrandHospitals.isNotEmpty) {
        final visitHospitalResult = await visitHospitalUsecase.execute(
            VisitHospitalRequestBody(visitHospitals, visitBrandHospitals));
        final visitHospitalFailureOrSuccess =
            visitHospitalResult.fold((failure) => failure, (data) => data);
        if (visitHospitalFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure:
                  Failure(0, "${visitHospitalFailureOrSuccess.massage} 3")));
          return false;
        }
        final visitHospitalFlagResult =
            await updateFlagHospitalSqlUsecase.execute();
        final visitHospitalFlagFailureOrSuccess =
            visitHospitalFlagResult.fold((failure) => failure, (data) => data);
        if (visitHospitalFlagFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure: Failure(
                  0, "${visitHospitalFlagFailureOrSuccess.massage} 4")));
          return false;
        }
      }
      if (UserInfo.otherstatus == 1 && UserInfo.flag == 0) {
        final planBrandResult =
            await planBrandUsecase.execute(RepPlanBrandBody(planBrands));
        final planBrandFailureOrSuccess =
            planBrandResult.fold((failure) => failure, (data) => data);
        if (planBrandFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure: Failure(0, "${planBrandFailureOrSuccess.massage} 5")));
          return false;
        }
        final planBrandFlagResult =
            await isPlanSqlUsecase.execute(UserInfo.repId, 1);
        final planBrandFlagFailureOrSuccess =
            planBrandFlagResult.fold((failure) => failure, (data) => data);
        if (planBrandFlagFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure:
                  Failure(0, "${planBrandFlagFailureOrSuccess.massage} 6")));
          return false;
        }
        UserInfo.flag = 1;
        print("Plan Brand data sent successfully.");
      }
      emit(SyncData1State());
      return true;
    } catch (e) {
      emit(SyncData1ErrorState(failure: Failure(0, "حدث خطأ اثناء التخزين")));
      print("Error occurred in setData: $e");
      return false;
    }
  }
}
