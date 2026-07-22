// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:domina_app/analytics/analytics_events.dart';
import 'package:domina_app/analytics/analytics_service.dart';
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
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
part 'async_event.dart';
part 'async_state.dart';

class AsyncBloc extends Bloc<AsyncEvent, AsyncState> {
  AllBrandsUsecase allBrandsUsecase;
  //AllPharmacyUsecase allPharmacyUsecase;
  AllPlaceUsecase allPlaceUsecase;
  AllSpeUsecase allSpeUsecase;
  AsyncDataSqlUsecase asyncDataSqlUsecase;
  AllHospitalUsecase allHospitalUsecase;
  AllDoctorUsecase allDoctorUsecase;
  AllHospialSpUsecase allHospialSpUsecase;
  AllBrandsSpUsecase allBrandsSpUsecase;
  AllPlanBrandsUsecase allPlanBrandsUsecase;
  EditIsLoginSqlUsecase editIsLoginSqlUsecase;
  CheckActiveBrandPlanUsecase checkActiveBrandPlanUsecase;
  UpdateActiveSqlUsecase updateActiveSqlUsecase;
  GetVisitDoctorUsecase getVisitDoctorUsecase;
  GetVisitHospitalUsecase getVisitHospitalUsecase;
  DeleteAllSqlUsecase deleteAllSqlUsecase;
  final AnalyticsService analyticsService;
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
      this.analyticsService,
      this.allBrandsUsecase,
      //  this.allPharmacyUsecase,
      this.allPlaceUsecase,
      this.allSpeUsecase,
      this.asyncDataSqlUsecase,
      this.allDoctorUsecase,
      this.allHospitalUsecase,
      this.allHospialSpUsecase,
      this.editIsLoginSqlUsecase,
      this.allBrandsSpUsecase,
      this.allPlanBrandsUsecase,
      this.checkActiveBrandPlanUsecase,
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
          // pharmacies,
          places,
          spec,
          doctors,
          hospitals,
          hospitalSps,
          brandSpModel,
          visitHospital!,
          visitDoctor!,
          planBrands: planBrands.isNotEmpty ? planBrands : null,
        );

        return result.fold(
              (failure) {
            FirebaseCrashlytics.instance.recordError(
              Exception("Database Save Failed"),
              StackTrace.current,
              reason: "Local DB save error: ${failure.massage}",
              fatal: false,
            );
            emit(SyncDataErrorState(failure: failure));
            return false;
          },
              (data) {
            print("brand");
            brands = [];
            // pharmacies = [];
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
            return true;
          },
        );
      }

      Future<bool> getData() async {
        try {
          // 1. ربط هوية المندوب والتتبع قبل البدء
          await FirebaseCrashlytics.instance.setUserIdentifier(UserInfo.repId.toString());
          await FirebaseCrashlytics.instance.setCustomKey("sync_mode", "getData");

          // تهيئة القوائم
          brands = [];
          places = [];
          spec = [];
          hospitalSps = [];
          hospitals = [];
          brandSpModel = [];
          planBrands = [];
          visitDoctor?.brand = [];
          visitDoctor?.data = [];
          visitHospital?.brand = [];
          visitHospital?.data = [];

          // 1. All Brands Usecase
          final brandsStopwatch = Stopwatch()..start();
          final brandsResult = await allBrandsUsecase.execute(UserInfo.activePlanId);
          brandsStopwatch.stop();
          final brandsFailureOrSuccess = brandsResult.fold((failure) => failure, (data) => data);
          if (brandsFailureOrSuccess is Failure) {
            await logSyncStep(
              stepName: "brands",
              loadingNumber: 1,
              success: false,
              durationMs: brandsStopwatch.elapsedMilliseconds,
              failure: brandsFailureOrSuccess,
            );
            emit(SyncDataErrorState(failure: brandsFailureOrSuccess));
            return false; // 🛑 توقف فوري
          }
          brands = brandsFailureOrSuccess as List<BrandModel>;
          await logSyncStep(
            stepName: "brands",
            loadingNumber: 1,
            success: true,
            durationMs: brandsStopwatch.elapsedMilliseconds,
            count: brands.length,
          );
          emit(LoadingState(1));

          // 2. Get Visit Doctor Usecase
          final visitDoctorStopwatch = Stopwatch()..start();
          final visitDoctorResult = await getVisitDoctorUsecase.execute(
              UserInfo.activePlanId.toString(), UserInfo.repId.toString());
          visitDoctorStopwatch.stop();
          final visitDoctorFailureOrSuccess = visitDoctorResult.fold((failure) => failure, (data) => data);
          if (visitDoctorFailureOrSuccess is Failure) {
            await logSyncStep(
              stepName: "visit_doctor",
              loadingNumber: 2,
              success: false,
              durationMs: visitDoctorStopwatch.elapsedMilliseconds,
              failure: visitDoctorFailureOrSuccess,
            );
            emit(SyncDataErrorState(failure: visitDoctorFailureOrSuccess));
            return false; // 🛑 توقف فوري
          }
          visitDoctor = visitDoctorFailureOrSuccess as VisitDoctorBase;
          await logSyncStep(
            stepName: "visit_doctor",
            loadingNumber: 2,
            success: true,
            durationMs: visitDoctorStopwatch.elapsedMilliseconds,
          );
          emit(LoadingState(2));

          // 3. Get Visit Hospital Usecase
          final visitHospitalStopwatch = Stopwatch()..start();
          final visitHospitalResult = await getVisitHospitalUsecase.execute(UserInfo.activePlanId, UserInfo.repId);
          visitHospitalStopwatch.stop();
          final visitHospitalFailureOrSuccess = visitHospitalResult.fold((failure) => failure, (data) => data);
          if (visitHospitalFailureOrSuccess is Failure) {
            await logSyncStep(
              stepName: "visit_hospital",
              loadingNumber: 3,
              success: false,
              durationMs: visitHospitalStopwatch.elapsedMilliseconds,
              failure: visitHospitalFailureOrSuccess,
            );
            emit(SyncDataErrorState(failure: visitHospitalFailureOrSuccess));
            return false; // 🛑 توقف فوري
          }
          visitHospital = visitHospitalFailureOrSuccess as VisitHospitalBase;
          await logSyncStep(
            stepName: "visit_hospital",
            loadingNumber: 3,
            success: true,
            durationMs: visitHospitalStopwatch.elapsedMilliseconds,
          );
          emit(LoadingState(3));
          // 4. All Plan Brands Usecase (Conditional)
          if (UserInfo.flag1 == 0) {
            final planBrandsStopwatch = Stopwatch()..start();
            final planBrandsResult = await allPlanBrandsUsecase.execute(
                Rep(UserInfo.activePlanId, 0, otherRepId: UserInfo.otherPlanId));
            planBrandsStopwatch.stop();
            final planBrandsFailureOrSuccess = planBrandsResult.fold((failure) => failure, (data) => data);
            if (planBrandsFailureOrSuccess is Failure) {
              await logSyncStep(
                stepName: "plan_brands",
                loadingNumber: 4,
                success: false,
                durationMs: planBrandsStopwatch.elapsedMilliseconds,
                failure: planBrandsFailureOrSuccess,
              );
              emit(SyncDataErrorState(failure: planBrandsFailureOrSuccess));
              return false; // 🛑 توقف فوري
            }
            planBrands = planBrandsFailureOrSuccess as List<PlanBrandModel>;
            await logSyncStep(
              stepName: "plan_brands",
              loadingNumber: 4,
              success: true,
              durationMs: planBrandsStopwatch.elapsedMilliseconds,
              count: planBrands.length,
            );
          }

          // 5. All Doctor Usecase (تم تعديل المعالجة لضمان الإيقاف الفوري عند انقطاع الاتصال)
          emit(LoadingState(4));
          final doctorsStopwatch = Stopwatch()..start();
          try {
            final doctorsResult = await allDoctorUsecase.execute(UserInfo.repId);
            doctorsStopwatch.stop();

            final doctorsFailureOrSuccess = doctorsResult.fold((failure) => failure, (data) => data);

            if (doctorsFailureOrSuccess is Failure) {
              await logSyncStep(
                stepName: "doctors",
                loadingNumber: 5,
                success: false,
                durationMs: doctorsStopwatch.elapsedMilliseconds,
                failure: doctorsFailureOrSuccess,
              );
              emit(SyncDataErrorState(failure: doctorsFailureOrSuccess));
              return false; // 🛑 توقف فوري عند ارجاع Failure
            }

            doctors = doctorsFailureOrSuccess as List<DoctorModel>;
            await logSyncStep(
              stepName: "doctors",
              loadingNumber: 5,
              success: true,
              durationMs: doctorsStopwatch.elapsedMilliseconds,
              count: doctors.length,
            );
          } catch (e, stackTrace) {
            doctorsStopwatch.stop();

            final customFailure = Failure(
              -5, e.toString(),
            );

            // تسجيل الخطأ المباشر في Crashlytics
            await FirebaseCrashlytics.instance.recordError(
              e,
              stackTrace,
              reason:  " doctors",
              fatal: false,
            );

            await logSyncStep(
              stepName: "doctors",
              loadingNumber: 5,
              success: false,
              durationMs: doctorsStopwatch.elapsedMilliseconds,
              failure: customFailure,
            );

            // إصدار حالة الخطأ للخروج
            emit(SyncDataErrorState(failure: customFailure));
            return false; // 🛑 إيقاف عملية المزامنة تماماً ومنع استكمال باقي Steps
          }

          // 6. All Hospital Usecase
          emit(LoadingState(5));
          final hospitalsStopwatch = Stopwatch()..start();
          final hospitalsResult = await allHospitalUsecase.execute(UserInfo.repId);
          hospitalsStopwatch.stop();
          final hospitalsFailureOrSuccess = hospitalsResult.fold((failure) => failure, (data) => data);
          if (hospitalsFailureOrSuccess is Failure) {
            await logSyncStep(
              stepName: "hospitals",
              loadingNumber: 6,
              success: false,
              durationMs: hospitalsStopwatch.elapsedMilliseconds,
              failure: hospitalsFailureOrSuccess,
            );
            emit(SyncDataErrorState(failure: hospitalsFailureOrSuccess));
            return false; // 🛑 توقف فوري
          }
          hospitals = hospitalsFailureOrSuccess as List<HospitalModel>;
          await logSyncStep(
            stepName: "hospitals",
            loadingNumber: 6,
            success: true,
            durationMs: hospitalsStopwatch.elapsedMilliseconds,
            count: hospitals.length,
          );
          emit(LoadingState(6));

          // 7. All Place Usecase
          final placesStopwatch = Stopwatch()..start();
          final placesResult = await allPlaceUsecase.execute(UserInfo.repId);
          placesStopwatch.stop();
          final placesFailureOrSuccess = placesResult.fold((failure) => failure, (data) => data);
          if (placesFailureOrSuccess is Failure) {
            await logSyncStep(
              stepName: "places",
              loadingNumber: 7,
              success: false,
              durationMs: placesStopwatch.elapsedMilliseconds,
              failure: placesFailureOrSuccess,
            );
            emit(SyncDataErrorState(failure: placesFailureOrSuccess));
            return false; // 🛑 توقف فوري
          }
          places = placesFailureOrSuccess as List<PlaceModel>;
          await logSyncStep(
            stepName: "places",
            loadingNumber: 7,
            success: true,
            durationMs: placesStopwatch.elapsedMilliseconds,
            count: places.length,
          );
          emit(LoadingState(7));

          // 8. All Spec Usecase
          final specStopwatch = Stopwatch()..start();
          final specResult = await allSpeUsecase.execute(UserInfo.repId);
          specStopwatch.stop();
          final specFailureOrSuccess = specResult.fold((failure) => failure, (data) => data);
          if (specFailureOrSuccess is Failure) {
            await logSyncStep(
              stepName: "spec",
              loadingNumber: 8,
              success: false,
              durationMs: specStopwatch.elapsedMilliseconds,
              failure: specFailureOrSuccess,
            );
            emit(SyncDataErrorState(failure: specFailureOrSuccess));
            return false; // 🛑 توقف فوري
          }
          spec = specFailureOrSuccess as List<SpecDModel>;
          await logSyncStep(
            stepName: "spec",
            loadingNumber: 8,
            success: true,
            durationMs: specStopwatch.elapsedMilliseconds,
            count: spec.length,
          );
          emit(LoadingState(8));

          // 9. All Hospital Sp Usecase
          final hospitalSpsStopwatch = Stopwatch()..start();
          final hospitalSpsResult = await allHospialSpUsecase.execute(UserInfo.repId);
          hospitalSpsStopwatch.stop();
          final hospitalSpsFailureOrSuccess = hospitalSpsResult.fold((failure) => failure, (data) => data);
          if (hospitalSpsFailureOrSuccess is Failure) {
            await logSyncStep(
              stepName: "hospital_sps",
              loadingNumber: 9,
              success: false,
              durationMs: hospitalSpsStopwatch.elapsedMilliseconds,
              failure: hospitalSpsFailureOrSuccess,
            );
            emit(SyncDataErrorState(failure: hospitalSpsFailureOrSuccess));
            return false; // 🛑 توقف فوري
          }
          hospitalSps = hospitalSpsFailureOrSuccess as List<HospitalSpModel>;
          await logSyncStep(
            stepName: "hospital_sps",
            loadingNumber: 9,
            success: true,
            durationMs: hospitalSpsStopwatch.elapsedMilliseconds,
            count: hospitalSps.length,
          );
          emit(LoadingState(9));

          // 10. All Brands Sp Usecase
          final brandSpsStopwatch = Stopwatch()..start();
          final brandSpsResult = await allBrandsSpUsecase.execute(UserInfo.repId);
          brandSpsStopwatch.stop();
          final brandSpFailureOrSuccess = brandSpsResult.fold((failure) => failure, (data) => data);
          if (brandSpFailureOrSuccess is Failure) {
            await logSyncStep(
              stepName: "brand_sps",
              loadingNumber: 10,
              success: false,
              durationMs: brandSpsStopwatch.elapsedMilliseconds,
              failure: brandSpFailureOrSuccess,
            );
            emit(SyncDataErrorState(failure: brandSpFailureOrSuccess));
            return false; // 🛑 توقف فوري
          }
          brandSpModel = brandSpFailureOrSuccess as List<BrandSpModel>;
          await logSyncStep(
            stepName: "brand_sps",
            loadingNumber: 10,
            success: true,
            durationMs: brandSpsStopwatch.elapsedMilliseconds,
            count: brandSpModel.length,
          );
          emit(LoadingState(10));

          // اكتملت جميع الخطوات بنجاح
          FirebaseCrashlytics.instance.log("✅ [SYNC DOWNLOAD COMPLETED SUCCESSFULLY]");
          emit(getDataSucState());
          return true;

        } catch (error, stackTrace) {
          // Catch عام لأي Exception غير متوقع
          await FirebaseCrashlytics.instance.recordError(
            error,
            stackTrace,
            reason: "Fatal exception in getData()",
            fatal: false,
          );
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
        FirebaseCrashlytics.instance.log("💾 Starting asyncDataSqlUsecase.execute local saving...");
        await FirebaseCrashlytics.instance.setUserIdentifier("${UserInfo.repId}${UserInfo.name}"); // رقم المندوب
        await FirebaseCrashlytics.instance.setCustomKey("sync_mode", "PlanIsActiveEvent");
        emit(SyncDataLoadingState(0));
        (await checkActiveBrandPlanUsecase.execute(UserInfo.repId)).fold(
            (failure) {
          emit(IsActiveErrorState(failure: failure));
        }, (data) async {
          checkActiveModel = data;
          UserInfo.activePlanId = data.activePlanId ?? -5;
          UserInfo.otherPlanId = data.otherPlanId ?? 0;
          UserInfo.otherstatus = data.otherStatus ?? -1;
          UserInfo.percentage = data.percentage;
          UserInfo.recipesCount = data.recipesCount;
          UserInfo.startDate = data.startDate;
          UserInfo.endDate = data.endDate;
          UserInfo.otherStartDate = data.otherStartDate ?? null;
          UserInfo.otherEndDate = data.otherEndDate ?? null;
          if (UserInfo.otherstatus == -1) {
            UserInfo.flag1 = 0;
          }
          UserInfo.initializeUserPlan();

          emit(IsActiveState());
        });
      }
      if (event is UpdateRepEvent) {
        await FirebaseCrashlytics.instance.setCustomKey("sync_mode", "UpdateRepEvent");
        (await updateActiveSqlUsecase.execute(
                UserInfo.repId,
                checkActiveModel!.otherPlanId ?? 9,
                checkActiveModel!.activePlanId ?? -5,
                checkActiveModel!.otherStatus ?? 9,
                checkActiveModel!.startDate ?? "",
                checkActiveModel!.endDate ?? "",
                checkActiveModel!.otherStartDate ?? "",
                checkActiveModel!.otherEndDate ?? ""))
            .fold((failure) {
          emit(UpdateIsActiveErrorState(failure: failure));
        }, (data) async {
          if (checkActiveModel?.otherStatus != null) {
            UserInfo.flag = checkActiveModel?.otherStatus == 0 ? 0 : 1;
            UserInfo.flag1 = checkActiveModel?.otherStatus == -1
                ? 0
                //  : checkActiveModel?.flag == 1
                //       ? 1
                : checkActiveModel!.flag1;
          } else {
            UserInfo.flag1 = 0;
          }
          UserInfo.initializeUserPlan();

          emit(UpdateIsActiveState());
        });
      }
    });
  }
  Future<void> logSyncStep({
    required String stepName,
    required int loadingNumber,
    required bool success,
    required int durationMs,
    int? count,
    Failure? failure,
  }) async {
    try {
      final crashlytics = FirebaseCrashlytics.instance;

      // 1️⃣ Crashlytics: تسجيل Log نصي في كل الأحوال (نجاح أو فشل)
      final logMessage = "🔄 [SYNC STEP $loadingNumber: $stepName] | Success: $success | Duration: ${durationMs}ms | Items: ${count ?? 0}";
      crashlytics.log(logMessage);

      if (success) {
        // 2️⃣ حالة النجاح: Analytics Event
        final Map<String, Object> parameters = {
          "step_name": stepName,
          "loading_number": loadingNumber.toString(),
          "duration_ms": durationMs,
        };

        if (count != null) {
          parameters["items_count"] = count.toString();
        } else {
          parameters["success"] = "true";
        }

        await analyticsService.logEvent(
          name: "sync_step_completed",
          parameters: parameters,
        );

        // 3️⃣ حالة النجاح: Crashlytics Custom Key لتتبع آخر خطوة نجحت
        await crashlytics.setCustomKey("last_successful_sync_step", stepName);

      } else {
        // 2️⃣ حالة الفشل: Analytics Event
        await analyticsService.logEvent(
          name: "sync_step_failed",
          parameters: {
            "step_name": stepName,
            "items_count": count.toString() ,
            "loading_number": loadingNumber.toString(),
            "duration_ms": durationMs,
            "error_code": failure?.code.toString() ?? "unknown",
            "error_message": failure?.massage ?? "unknown_error",
          },
        );

        // 3️⃣ حالة الفشل: Crashlytics Record Non-Fatal Error
        await crashlytics.recordError(
          Exception("Sync Step Failed: $stepName"),
          StackTrace.current,
          reason: "Step: $stepName failed with Code: ${failure?.code} - Msg: ${failure?.massage}",
          fatal: false,

        );
      }
    } catch (e) {
      // حماية عملية المزامنة من التوقف في حال حدوث خطأ في إرسال الـ Logs
      print("Logging Error (Crashlytics/Analytics): $e");
    }
  }

}
