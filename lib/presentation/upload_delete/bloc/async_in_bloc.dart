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
  List<HospitalSpModel> visitHospitalSp = [];
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
      this.planBrandUsecase)
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
    planBrands = [];
    visitBrandPharmacies = [];
    visitBrandDoctors = [];
    visitBrandHospitals = [];
    visitPharmacies = [];
    visitHospitals = [];
    visitHospitalSp = [];
    visitDoctors = [];
    try {
      await Future.wait([
        (await getBrandsPharmacyVisitsSqlUsecase.execute()).fold((failure) {
          emit(SyncData1ErrorState(failure: failure));
          return Future.error(failure);
        }, (data) async {
          visitBrandPharmacies = data;
          print("visitBrandPharmacies");
        }),
        (await getBrandsDoctorVisitsSqlUsecase.execute()).fold((failure) {
          emit(SyncData1ErrorState(failure: failure));
          return Future.error(failure);
        }, (data) async {
          visitBrandDoctors = data;
          print("visitBrandDoctors");
        }),
        (await getBrandsHospitalVisitsSqlUsecase.execute()).fold((failure) {
          emit(SyncData1ErrorState(failure: failure));
          return Future.error(failure);
        }, (data) async {
          visitBrandHospitals = data;
          print("visitBrandHospitals");
        }),
        (await getPharmacyVisitsSqlUsecase.execute()).fold((failure) {
          emit(SyncData1ErrorState(failure: failure));
          return Future.error(failure);
        }, (data) async {
          visitPharmacies = data;
          print("visitPharmacies");
        }),
        (await getDoctorVisitsSqlUsecase.execute()).fold((failure) {
          emit(SyncData1ErrorState(failure: failure));
          return Future.error(failure);
        }, (data) async {
          visitDoctors = data;
        }),
        (await getHospitalSpVisitsSqlUsecase.execute()).fold((failure) {
          emit(SyncData1ErrorState(failure: failure));
          return Future.error(failure);
        }, (data) async {
          visitHospitalSp = data;
          print("visitHospitalSp");
        }),
        (await getHospitalVisitsSqlUsecase.execute()).fold((failure) {
          emit(SyncData1ErrorState(failure: failure));
          return Future.error(failure);
        }, (data) async {
          visitHospitals = data;
          print("visitHospitals");
        }),
        (await getPlanBrandSqlUsecase.execute()).fold((failure) {
          emit(SyncData1ErrorState(failure: failure));
          return Future.error(failure);
        }, (data) async {
          planBrands = data;

        }),
      ]);
      print("All tasks completed successfully.");
      return true;
    } catch (e) {
      print("Error occurred: $e");
      return false;
    }
  }

  Future<bool> setData() async {
    try {
      await Future.wait([
        if(!(visitPharmacies.isEmpty&&visitBrandPharmacies.isEmpty))
        (await visitPharmacyUsecase.execute(VisitPharmacyRequestBody(
                visitPharmacies, visitBrandPharmacies)))
            .fold((failure) async {
          emit(SyncData1ErrorState(failure: failure));
          return false;
        }, (data) async {
          print("1");
        }),
        if(!(visitDoctors.isEmpty&&visitBrandDoctors.isEmpty))
        (await visitDoctorUsecase.execute(
                VisitDoctorRequestBody(visitDoctors, visitBrandDoctors)))
            .fold((failure) async {
          emit(SyncData1ErrorState(failure: failure));
          return false;
        }, (data) async {
          print("11");
        }),
        if((visitHospitals.isEmpty&&visitBrandHospitals.isEmpty&&visitHospitalSp.isEmpty))
        (await visitHospitalUsecase.execute(VisitHospitalRequestBody(
                visitHospitals, visitBrandHospitals, visitHospitalSp)))
            .fold((failure) async {
          emit(SyncData1ErrorState(failure: failure));
          return false;
        }, (data) async {
          print("111");
        }),
        (await planBrandUsecase.execute(RepPlanBrandBody(planBrands)))
            .fold((failure) async {
          emit(SyncData1ErrorState(failure: failure));
          return false;
        }, (data) async {
          print("1111");
        }),
      ]);
      emit(SyncData1State());
      return true;
    } catch (e) {
      print("Error occurred in setData: $e");
      return false;
    }
  }
}
