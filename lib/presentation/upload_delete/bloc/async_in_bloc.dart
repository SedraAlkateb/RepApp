import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_exception_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_exception_usecase.dart';
import 'package:domina_app/domain/usecase/check_active_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_pharmacy_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_hospital_sp_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_pharmacy_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_plan_brand_sql_usecase.dart';
import 'package:domina_app/domain/usecase/is_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/plan_brand_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/visit_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/visit_pharmacy_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:domina_app/app/logger/app_logger.dart';
part 'async_in_event.dart';
part 'async_in_state.dart';

final _log = AppLogger.get('AsyncInBloc');

class AsyncInBloc extends Bloc<AsyncInEvent, AsyncInState> {
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
  CheckActiveBrandPlanUsecase checkActiveBrandPlanUsecase;

  AllExceptionUsecase allExceptionUsecase;
  AllExceptionSqlUsecase allExceptionSqlUsecase;
  List<PlanBrandModel> planBrands = [];
  List<VisitBrandPharmacyModel> visitBrandPharmacies = [];
  List<VisitBrandPharmacyModel> visitBrandDoctors = [];
  List<VisitBrandPharmacyModel> visitBrandHospitals = [];
  List<VisitHospitalModel> visitHospitals = [];
  List<VisitDoctorModel> visitDoctors = [];
  List<ExceptionModel> exceptionModel = [];

  bool suc = false;
  bool _syncing = false;
  AsyncInBloc(
      this.checkActiveBrandPlanUsecase,
      this.isPlanSqlUsecase,
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
      this.updateFlagHospitalSqlUsecase,
      this.allExceptionUsecase,
      this.allExceptionSqlUsecase)
      : super(AsyncInInitial()) {
    // المزامنة تمتد على حدثين (getData ثم setData): نمنع بدء مزامنة ثانية قبل
    // انتهاء الأولى لأن القوائم مشتركة، وإلا رُفعت الزيارات مرتين.
    on<Async1DataEvent>((event, emit) async {
      if (_syncing) return;
      _syncing = true;
      emit(SyncData1LoadingState());
      if (!await getData()) _syncing = false;
    });

    on<Async0DataEvent>((event, emit) async {
      if (_syncing) return;
      _syncing = true;
      emit(SyncData0LoadingState());
      if (!await getData()) _syncing = false;
    });

    on<GetEvent>((event, emit) async {
      try {
        await setData();
      } finally {
        _syncing = false;
      }
    });
  }

  Future<bool> getData() async {
    try {
      planBrands = [];
      visitBrandDoctors = [];
      visitBrandHospitals = [];
      visitHospitals = [];
      visitDoctors = [];
      exceptionModel = [];
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
      final insertExceptionResult = await allExceptionSqlUsecase.execute();
      final insertExceptionFailureOrSuccess =
          insertExceptionResult.fold((failure) => failure, (data) => data);
      if (insertExceptionFailureOrSuccess is Failure) {
        emit(SyncData1ErrorState(
            failure:
                Failure(0, "${insertExceptionFailureOrSuccess.massage} 14")));
        return false;
      }
      exceptionModel = insertExceptionFailureOrSuccess as List<ExceptionModel>;
///////////////////////
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
      if (UserInfo.otherstatus == 5 && UserInfo.flag == 0) {
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
      if (exceptionModel.isNotEmpty) {
        final insertAllExceptionResult = await allExceptionUsecase
            .execute(ExceptionRequestBody(exceptionModel));
        final insertAllExceptionFailureOrSuccess =
            insertAllExceptionResult.fold((failure) => failure, (data) => data);
        if (insertAllExceptionFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure: Failure(
                  0, "${insertAllExceptionFailureOrSuccess.massage} 1")));
          return false;
        }
      }
      if (visitDoctors.isNotEmpty || visitBrandDoctors.isNotEmpty) {
        // نُعلِّم كمُرسَلة فقط ما رُفع فعلاً (زيارات أُضيفت أثناء الرفع تبقى للمزامنة التالية).
        final uploadedVisitDoctorIds = visitDoctors.map((v) => v.id).toList();
        final uploadedBrandDoctorIds =
            visitBrandDoctors.map((v) => v.id).toList();
        final visitDoctorResult = await visitDoctorUsecase
            .execute(VisitDoctorRequestBody(visitDoctors, visitBrandDoctors));
        final visitDoctorFailureOrSuccess =
            visitDoctorResult.fold((failure) => failure, (data) => data);
        if (visitDoctorFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure: Failure(visitDoctorFailureOrSuccess.code,
                  "${visitDoctorFailureOrSuccess.massage} 2")));
          return false;
        }
        final visitDoctorFlagResult =
            await updateFlagDoctorSqlUsecase.execute(
                visitIds: uploadedVisitDoctorIds,
                brandIds: uploadedBrandDoctorIds);
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
        final uploadedVisitHospitalIds = visitHospitals.map((v) => v.id).toList();
        final uploadedBrandHospitalIds =
            visitBrandHospitals.map((v) => v.id).toList();
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
            await updateFlagHospitalSqlUsecase.execute(
                visitIds: uploadedVisitHospitalIds,
                brandIds: uploadedBrandHospitalIds);
        final visitHospitalFlagFailureOrSuccess =
            visitHospitalFlagResult.fold((failure) => failure, (data) => data);

        if (visitHospitalFlagFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure: Failure(
                  0, "${visitHospitalFlagFailureOrSuccess.massage} 4")));
          return false;
        }
      }
      if (UserInfo.otherstatus == 5 && UserInfo.flag == 0) {
        final isPlan =
            await checkActiveBrandPlanUsecase.execute(UserInfo.repId);
        final checkActiveBrandPlanFailureOrSuccess =
            isPlan.fold((failure) => failure, (data) {
          if (data.otherStatus != 0) {
            UserInfo.isChange = true;
          } else {
            UserInfo.isChange = false;
          }
          UserInfo.otherstatus = data.otherStatus ?? -1;
          UserInfo.startDate = data.startDate;
          UserInfo.endDate = data.endDate;
          UserInfo.otherStartDate = data.otherStartDate ?? null;
          UserInfo.otherEndDate = data.otherEndDate ?? null;
          if (UserInfo.otherstatus == -1) {
            UserInfo.flag1 = 0;
          }
        });
        if (checkActiveBrandPlanFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure: Failure(
                  0, "${checkActiveBrandPlanFailureOrSuccess.massage} 5")));
          return false;
        }
        if (UserInfo.isChange == false) {
          final planBrandResult =
              await planBrandUsecase.execute(RepPlanBrandBody(planBrands, 5));
          final planBrandFailureOrSuccess =
              planBrandResult.fold((failure) => failure, (data) => data);
          if (planBrandFailureOrSuccess is Failure) {
            emit(SyncData1ErrorState(
                failure: Failure(0, "${planBrandFailureOrSuccess.massage} 6")));
            return false;
          }
        }

        final planBrandFlagResult =
            await isPlanSqlUsecase.execute(UserInfo.repId, 1);
        final planBrandFlagFailureOrSuccess =
            planBrandFlagResult.fold((failure) => failure, (data) => data);
        if (planBrandFlagFailureOrSuccess is Failure) {
          emit(SyncData1ErrorState(
              failure:
                  Failure(0, "${planBrandFlagFailureOrSuccess.massage} 7")));
          return false;
        }
        UserInfo.flag = 1;
        if (UserInfo.isChange == true) {
          emit(IsActiveState());
        } else {
          emit(SyncData1State());
        }
      } else {
        emit(SyncData1State());
      }

      return true;
    } catch (e) {
      emit(SyncData1ErrorState(failure: Failure(0, "حدث خطأ اثناء التخزين")));
      _log.severe('Error occurred in setData', e);
      return false;
    }
  }
}
