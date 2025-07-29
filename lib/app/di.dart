import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/network/app_api.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/dio_factory.dart';
import 'package:domina_app/data/network/network_info.dart';
import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:domina_app/data/repository/repository.dart';
import 'package:domina_app/data/repository/repositroy_sql.dart';
import 'package:domina_app/domain/ex.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/domain/usecase/all_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_flag_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_res_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_brands_sp_usecase.dart';
import 'package:domina_app/domain/usecase/all_city_usecase.dart';
import 'package:domina_app/domain/usecase/all_doctor_sp_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_doctor_sql_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_exception_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_exception_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase%20.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:domina_app/domain/usecase/all_brands_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospital_sp_n_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospital_sp_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_no_visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/all_other_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_pharmacy_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_type_usecase.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_read_sen_usecase.dart';
import 'package:domina_app/domain/usecase/all_reci_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_reps_future_usecase.dart';
import 'package:domina_app/domain/usecase/all_seinor_reps_usecase.dart';
import 'package:domina_app/domain/usecase/all_sen_visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_doctor_rep_sen_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_hospital_rep_sen_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_issue_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_notes_usecase.dart';
import 'package:domina_app/domain/usecase/async_data_sql_usecase.dart';
import 'package:domina_app/domain/usecase/changePlanBrandType_usecase.dart';
import 'package:domina_app/domain/usecase/check_active_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/check_reci_usecase.dart';
import 'package:domina_app/domain/usecase/check_rep_usecase%20.dart';
import 'package:domina_app/domain/usecase/copyreci_usecase.dart';
import 'package:domina_app/domain/usecase/delete_all_sql_usecase.dart';
import 'package:domina_app/domain/usecase/delete_sql_usecase.dart';
import 'package:domina_app/domain/usecase/doc_doctors_usecase.dart';
import 'package:domina_app/domain/usecase/doctor_info_usecase.dart';
import 'package:domina_app/domain/usecase/doctors_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/get_Rep_Reci.dart';
import 'package:domina_app/domain/usecase/get_info_plan_brands_usecase.dart';
import 'package:domina_app/domain/usecase/get_visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/get_visit_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/hospitals_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/info_rep_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_brands_pharmacy_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_hospital_sp_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_pharmacy_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_as/get_plan_brand_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_exception_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_reci_usecase%20.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/inventory_usecase.dart';
import 'package:domina_app/domain/usecase/is_active_usecase.dart';
import 'package:domina_app/domain/usecase/is_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/login_usecase.dart';
import 'package:domina_app/domain/usecase/num_visit_sql_usecase.dart';
import 'package:domina_app/domain/usecase/plan_brand_usecase.dart';
import 'package:domina_app/domain/usecase/read_visit_usecase%20.dart';
import 'package:domina_app/domain/usecase/reci_num_usecase.dart';
import 'package:domina_app/domain/usecase/remaining_visits_use_case.dart';
import 'package:domina_app/domain/usecase/rep_plan_brand_sp_usecase.dart';
import 'package:domina_app/domain/usecase/search_doctors_usecase.dart';
import 'package:domina_app/domain/usecase/sp_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_active_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_flag_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/update_other_status_usecase.dart';
import 'package:domina_app/domain/usecase/update_reci_usecase%20.dart';
import 'package:domina_app/domain/usecase/update_save_sql_usecase.dart';
import 'package:domina_app/domain/usecase/visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/visit_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/visit_pharmacy_usecase.dart';
import 'package:domina_app/presentation/Recipes/bloc/recipes_brand_bloc.dart';
import 'package:domina_app/presentation/active_plan/bloc/bloc/active_plan_bloc.dart';
import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/brand_plan/bloc/brand_plan_bloc.dart';
import 'package:domina_app/presentation/delete/bloc/delete_bloc.dart';
import 'package:domina_app/presentation/senior/edit_brand_plan/bloc/edit_brand_plan_bloc.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/senior/manage_future/bloc/manage_future_bloc.dart';
import 'package:domina_app/presentation/senior/places/bloc/senior_reps_bloc.dart';
import 'package:domina_app/presentation/senior/report_Inventory/bloc/report_inventory_bloc.dart';
import 'package:domina_app/presentation/senior/report_sience_note/bloc/report_science_bloc.dart';
import 'package:domina_app/presentation/senior/report_visit_doctor/bloc/report_visit_doctor_bloc.dart';
import 'package:domina_app/presentation/senior/representative/bloc/senior_prof_bloc.dart';
import 'package:domina_app/presentation/senior/search_doctors/bloc/search_doctors_bloc.dart';
import 'package:domina_app/presentation/upload_delete/bloc/async_in_bloc.dart';
import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/doctors/bloc/doctors_bloc.dart';
import 'package:domina_app/presentation/hospitals/bloc/hospitals_bloc.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/pharmacy/bloc/pharmacy_bloc.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/plase_visit/bloc/visit_place_bloc.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
import 'package:domina_app/presentation/visits/bloc/visit_bloc.dart';
import 'package:get_it/get_it.dart';

import '../presentation/senior/report_issue_note/bloc/report_issue_bloc.dart';
GetIt instance = GetIt.instance;
Future<void> initAppModule() async {
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(Connectivity()));
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));
  DatabaseHelper databaseHelper = DatabaseHelper();
  instance.registerLazySingleton<AppSqlApi>(() => AppSqlApi(databaseHelper));
  await instance<AppSqlApi>().initializeDatabase();
  instance
      .registerLazySingleton<ExcRepository>(() => ExcRepository(instance()));
  instance.registerLazySingleton<RepositorySql>(
      () => RepositroySqlImp(instance(), instance()));
  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImp(instance(), instance(), instance()));
  instance.registerLazySingleton<InsertExceptionSqlUsecase>(
      () => InsertExceptionSqlUsecase(instance()));
}
Future<void> initAsyncModule() async {
  if (!GetIt.I.isRegistered<AsyncBloc>()) {
    // instance.registerFactory<AllPharmacyUsecase>(
    //     () => AllPharmacyUsecase(instance()));
    if (!GetIt.I.isRegistered<AllBrandsUsecase>()) {
      instance.registerFactory<AllBrandsUsecase>(
          () => AllBrandsUsecase(instance()));
    }
    if (!GetIt.I.isRegistered<AllPlaceUsecase>()) {
      instance
          .registerFactory<AllPlaceUsecase>(() => AllPlaceUsecase(instance()));
    }
    if (!GetIt.I.isRegistered<AllSpeUsecase>()) {
      instance.registerFactory<AllSpeUsecase>(() => AllSpeUsecase(instance()));
    }
    if (!GetIt.I.isRegistered<AllDoctorUsecase>()) {
      instance.registerFactory<AllDoctorUsecase>(
          () => AllDoctorUsecase(instance()));
    }
    if (!GetIt.I.isRegistered<AllHospitalUsecase>()) {
      instance.registerFactory<AllHospitalUsecase>(
          () => AllHospitalUsecase(instance()));
    }
    instance.registerFactory<AsyncDataSqlUsecase>(
        () => AsyncDataSqlUsecase(instance()));

    instance.registerFactory<AllHospialSpUsecase>(
        () => AllHospialSpUsecase(instance()));
    if (!GetIt.I.isRegistered<EditIsLoginSqlUsecase>()) {
      instance.registerFactory<EditIsLoginSqlUsecase>(
          () => EditIsLoginSqlUsecase(instance()));
    }
    if (!GetIt.I.isRegistered<DeleteAllSqlUsecase>()) {
      instance.registerFactory<DeleteAllSqlUsecase>(
          () => DeleteAllSqlUsecase(instance()));
    }
    instance.registerFactory<AllBrandsSpUsecase>(
        () => AllBrandsSpUsecase(instance()));
    if (!GetIt.I.isRegistered<AllPlanBrandsUsecase>()) {
      instance.registerFactory<AllPlanBrandsUsecase>(() => AllPlanBrandsUsecase(instance()));
    }
    instance.registerFactory<CheckActiveBrandPlanSqlUsecase>(
        () => CheckActiveBrandPlanSqlUsecase(instance()));
    instance.registerFactory<UpdateActiveSqlUsecase>(
        () => UpdateActiveSqlUsecase(instance()));
    instance.registerFactory<GetVisitDoctorUsecase>(
        () => GetVisitDoctorUsecase(instance()));

    instance.registerFactory<GetVisitHospitalUsecase>(
        () => GetVisitHospitalUsecase(instance()));
    instance.registerFactory<AsyncBloc>(() => AsyncBloc(
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        //   instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance()));
  }
}

Future<void> initLoginModule() async {
  if (!GetIt.I.isRegistered<AuthBloc>()) {
    instance.registerFactory<LoginUsecase>(() => LoginUsecase(instance()));
    instance
        .registerFactory<LoginSqlUsecase>(() => LoginSqlUsecase(instance()));
    //  instance.registerFactory<DeleteSqlUsecase>(() =>DeleteSqlUsecase(instance()));

    instance.registerFactory<AuthBloc>(() => AuthBloc(instance(), instance()));
  }
}

Future<void> initPlaceVisitModule() async {
  if (!GetIt.I.isRegistered<DoctorsByPlaceUsecase>()) {
    //  instance.registerFactory<PharmaciesByPlaceUsecase>(() =>PharmaciesByPlaceUsecase(instance()));
    instance.registerFactory<DoctorsByPlaceUsecase>(
        () => DoctorsByPlaceUsecase(instance()));
    instance.registerFactory<HospitalsByPlaceUsecase>(
        () => HospitalsByPlaceUsecase(instance()));
    instance.registerFactory<AllBrandsFlagSqlUsecase>(
        () => AllBrandsFlagSqlUsecase(instance()));
    instance.registerFactory<InsertVisitDoctorSqlUsecase>(
        () => InsertVisitDoctorSqlUsecase(instance()));
    instance.registerFactory<InsertVisitBrandDoctorSqlUsecase>(
        () => InsertVisitBrandDoctorSqlUsecase(instance()));
    instance.registerFactory<InsertVisitBrandHospitalSqlUsecase>(
        () => InsertVisitBrandHospitalSqlUsecase(instance()));
    instance.registerFactory<SpHospitalSqlUsecase>(
        () => SpHospitalSqlUsecase(instance()));
    instance.registerFactory<InsertVisitHospitalSqlUsecase>(
        () => InsertVisitHospitalSqlUsecase(instance()));
    if (!GetIt.I.isRegistered<AllBrandsSqlUsecase>()) {
      instance.registerFactory<AllBrandsSqlUsecase>(
          () => AllBrandsSqlUsecase(instance()));
    }
    instance.registerFactory<VisitPlaceBloc>(() => VisitPlaceBloc(
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance()));
  }
}

Future<void> initPlacesModule() async {
  if (!GetIt.I.isRegistered<AllPlacesSqlUsecase>()) {
    instance.registerFactory<AllPlacesSqlUsecase>(
        () => AllPlacesSqlUsecase(instance()));
    instance.registerFactory<NumVisitSqlUsecase>(
        () => NumVisitSqlUsecase(instance()));
    instance
        .registerFactory<CheckRepUsecase>(() => CheckRepUsecase(instance()));
    instance.registerFactory<PlaceBloc>(
        () => PlaceBloc(instance(), instance(), instance()));
  }
}

Future<void> initVisitsModule() async {
  if (!GetIt.I.isRegistered<AllVisitDoctorSqlUsecase>()) {
    if (!GetIt.I.isRegistered<AllBrandsFlagSqlUsecase>()) {
      instance.registerFactory<AllBrandsFlagSqlUsecase>(
          () => AllBrandsFlagSqlUsecase(instance()));
    }
    instance.registerFactory<UpdateHospitalUsecase>(
        () => UpdateHospitalUsecase(instance()));
    instance.registerFactory<UpdateDoctorUsecase>(
        () => UpdateDoctorUsecase(instance()));
    instance.registerFactory<AllVisitDoctorSqlUsecase>(
        () => AllVisitDoctorSqlUsecase(instance()));
    instance.registerFactory<AllBrandsDoctorVisitsSqlUsecase>(
        () => AllBrandsDoctorVisitsSqlUsecase(instance()));
    instance.registerFactory<AllBrandsHospitalVisitsSqlUsecase>(
        () => AllBrandsHospitalVisitsSqlUsecase(instance()));
    instance.registerFactory<AllVisitHospitalSqlUsecase>(
        () => AllVisitHospitalSqlUsecase(instance()));
    instance.registerFactory<VisitBloc>(() => VisitBloc(instance(), instance(),
        instance(), instance(), instance(), instance(), instance()
        //  ,instance(),instance(),instance()
        ));
  }
  // instance.registerFactory<AllBrandsPharmacyVisitsSqlUsecase>(() =>AllBrandsPharmacyVisitsSqlUsecase(instance()));
  //  instance.registerFactory<UpdateDoctorUsecase>(() =>UpdateDoctorUsecase(instance()));
  //  instance.registerFactory<UpdateHospitalUsecase>(() =>UpdateHospitalUsecase(instance()));
  //  instance.registerFactory<UpdatePharmacyUsecase>(() =>UpdatePharmacyUsecase(instance()));
}

Future<void> initSpecModule() async {
  if (!GetIt.I.isRegistered<AllSpecsSqlUsecase>()) {
    instance.registerFactory<AllSpecsSqlUsecase>(
        () => AllSpecsSqlUsecase(instance()));
    instance.registerFactory<AllDoctorSpSqlUsecase>(
        () => AllDoctorSpSqlUsecase(instance()));
    instance.registerFactory<AllHospitalSpSqlUsecase>(
        () => AllHospitalSpSqlUsecase(instance()));
    instance.registerFactory<SpecializationBloc>(
        () => SpecializationBloc(instance(), instance(), instance()));
  }
}

Future<void> initBrandRecModule() async {
  if (!GetIt.I.isRegistered<AllBrandsResUsecase>()) {
    instance.registerFactory<InsertReciUsecase>(
        () => InsertReciUsecase(instance()));
    instance.registerFactory<UpdateReciUsecase>(
            () => UpdateReciUsecase(instance()));
    instance.registerFactory<AllBrandsResUsecase>(
        () => AllBrandsResUsecase(instance()));
    instance
        .registerFactory<CopyReciUsecase>(() => CopyReciUsecase(instance()));
    /////////////
    if (!GetIt.I.isRegistered<AllReciUsecase>()) {
      instance.registerFactory<AllReciUsecase>(
              () => AllReciUsecase(instance()));
    }
      if (!GetIt.I.isRegistered<GetRepReciUsecase>()) {
      instance.registerFactory<GetRepReciUsecase>(
              () => GetRepReciUsecase(instance()));
    }
    instance.registerFactory<ReciNumUsecase>(() => ReciNumUsecase(instance()));
    instance.registerFactory<RecipesBrandBloc>(
        () => RecipesBrandBloc(instance(), instance(), instance(), instance(), instance(), instance(), instance()));
  }
}

Future<void> initAsyncInModule() async {
  if (!GetIt.I.isRegistered<GetPharmacyVisitsSqlUsecase>()) {
    instance.registerFactory<VisitHospitalUsecase>(
        () => VisitHospitalUsecase(instance()));
    if (!GetIt.I.isRegistered<AllExceptionUsecase>()) {
      instance.registerFactory<AllExceptionUsecase>(
          () => AllExceptionUsecase(instance()));
    }
    instance.registerFactory<AllExceptionSqlUsecase>(
        () => AllExceptionSqlUsecase(instance()));
    instance.registerFactory<VisitDoctorUsecase>(
        () => VisitDoctorUsecase(instance()));
    instance.registerFactory<VisitPharmacyUsecase>(
        () => VisitPharmacyUsecase(instance()));
    instance.registerFactory<GetPharmacyVisitsSqlUsecase>(
        () => GetPharmacyVisitsSqlUsecase(instance()));
    instance.registerFactory<GetHospitalVisitsSqlUsecase>(
        () => GetHospitalVisitsSqlUsecase(instance()));
    instance.registerFactory<GetDoctorVisitsSqlUsecase>(
        () => GetDoctorVisitsSqlUsecase(instance()));
    instance.registerFactory<GetBrandsPharmacyVisitsSqlUsecase>(
        () => GetBrandsPharmacyVisitsSqlUsecase(instance()));
    instance.registerFactory<GetBrandsHospitalVisitsSqlUsecase>(
        () => GetBrandsHospitalVisitsSqlUsecase(instance()));
    instance.registerFactory<GetBrandsDoctorVisitsSqlUsecase>(
        () => GetBrandsDoctorVisitsSqlUsecase(instance()));
    instance.registerFactory<GetHospitalSpVisitsSqlUsecase>(
        () => GetHospitalSpVisitsSqlUsecase(instance()));
    instance.registerFactory<GetPlanBrandSqlUsecase>(
        () => GetPlanBrandSqlUsecase(instance()));
    instance
        .registerFactory<IsPlanSqlUsecase>(() => IsPlanSqlUsecase(instance()));
    instance
        .registerFactory<PlanBrandUsecase>(() => PlanBrandUsecase(instance()));
    instance.registerFactory<UpdateFlagDoctorSqlUsecase>(
        () => UpdateFlagDoctorSqlUsecase(instance()));
    instance.registerFactory<UpdateFlagHospitalSqlUsecase>(
        () => UpdateFlagHospitalSqlUsecase(instance()));

    // if (!GetIt.I.isRegistered<DeleteSqlUsecase>()) {
    //   instance.registerFactory<DeleteSqlUsecase>(
    //       () => DeleteSqlUsecase(instance()));
    // }
    if (!GetIt.I.isRegistered<IsActiveUsecase>()) {
      instance
          .registerFactory<IsActiveUsecase>(() => IsActiveUsecase(instance()));
    }

    instance.registerFactory<AsyncInBloc>(() => AsyncInBloc(
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance()));
  }
}

Future<void> initDeleteModule() async {
  if (!GetIt.I.isRegistered<DeleteAllSqlUsecase>()) {
    instance.registerFactory<DeleteAllSqlUsecase>(
        () => DeleteAllSqlUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<EditIsLoginSqlUsecase>()) {
    instance.registerFactory<EditIsLoginSqlUsecase>(
        () => EditIsLoginSqlUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<DeleteSqlUsecase>()) {
    instance
        .registerFactory<DeleteSqlUsecase>(() => DeleteSqlUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<DeleteBloc>()) {
    instance.registerFactory<DeleteBloc>(
        () => DeleteBloc(instance(), instance(), instance()));
  }
}

Future<void> initDoctorModule() async {
  if (!GetIt.I.isRegistered<AllDoctorsSqlUsecase>()) {
    instance.registerFactory<AllDoctorsSqlUsecase>(
        () => AllDoctorsSqlUsecase(instance()));
    if (!GetIt.I.isRegistered<CheckReciUsecase>()) {
      instance.registerFactory<CheckReciUsecase>(
          () => CheckReciUsecase(instance()));
    }
    instance.registerFactory<DoctorsBloc>(
        () => DoctorsBloc(instance(), instance()));
  }
}


Future<void> initHospitalModule() async {
  if (!GetIt.I.isRegistered<AllHospitalSpNSqlUsecase>()) {
    instance.registerFactory<AllHospitalSpNSqlUsecase>(
        () => AllHospitalSpNSqlUsecase(instance()));
    if (!GetIt.I.isRegistered<CheckReciUsecase>()) {
      instance.registerFactory<CheckReciUsecase>(
          () => CheckReciUsecase(instance()));
    }
    instance.registerFactory<HospitalsBloc>(
        () => HospitalsBloc(instance(), instance()));
  }
}

Future<void> initBrandModule() async {
  if (!GetIt.I.isRegistered<AllBrandsSqlUsecase>()) {
    instance.registerFactory<AllBrandsSqlUsecase>(
        () => AllBrandsSqlUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<BrandBloc>()) {
    instance.registerFactory<BrandBloc>(() => BrandBloc(instance()));
  }
}

Future<void> initPharmacyModule() async {
  if (!GetIt.I.isRegistered<AllPharmacySqlUsecase>()) {
    instance.registerFactory<AllPharmacySqlUsecase>(
        () => AllPharmacySqlUsecase(instance()));
    instance.registerFactory<PharmacyBloc>(() => PharmacyBloc(instance()));
  }
}

Future<void> initBrandPlanModule() async {
  if (!GetIt.I.isRegistered<UpdateBrandPlanSqlUsecase>()) {
    instance.registerFactory<AllBrandPlanSqlUsecase>(
        () => AllBrandPlanSqlUsecase(instance()));
    instance.registerFactory<UpdateBrandPlanSqlUsecase>(
        () => UpdateBrandPlanSqlUsecase(instance()));

    instance.registerFactory<UpdateOtherStatusUsecase>(
        () => UpdateOtherStatusUsecase(instance()));
    instance.registerFactory<AllOtherBrandPlanSqlUsecase>(
        () => AllOtherBrandPlanSqlUsecase(instance()));
    instance.registerFactory<UpdateSaveSqlUsecase>(
        () => UpdateSaveSqlUsecase(instance()));
    instance.registerFactory<BrandPlanBloc>(() => BrandPlanBloc(
        instance(), instance(), instance(), instance(), instance()));
  }
}

Future<void> initSeniorProfModule() async {
  if (!GetIt.I.isRegistered<AllPlaceUsecase>()) {
    instance
        .registerFactory<AllPlaceUsecase>(() => AllPlaceUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<AllSpeUsecase>()) {
    instance.registerFactory<AllSpeUsecase>(() => AllSpeUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<AllHospitalUsecase>()) {
    instance.registerFactory<AllHospitalUsecase>(
        () => AllHospitalUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<AllDoctorUsecase>()) {
    instance
        .registerFactory<AllDoctorUsecase>(() => AllDoctorUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<RemainingVisitsUsecase>()) {
    instance
        .registerFactory<RemainingVisitsUsecase>(() => RemainingVisitsUsecase(instance()));
  }

  if (!GetIt.I.isRegistered<AllNoVisitDoctorUsecase>()) {
    instance.registerFactory<AllNoVisitDoctorUsecase>(
        () => AllNoVisitDoctorUsecase(instance()));
    instance.registerFactory<AllSenVisitDoctorUsecase>(
        () => AllSenVisitDoctorUsecase(instance()));
    instance.registerFactory<InfoRepUsecase>(() => InfoRepUsecase(instance()));
    if (!GetIt.I.isRegistered<AllBrandsUsecase>()) {
      instance.registerFactory<AllBrandsUsecase>(
          () => AllBrandsUsecase(instance()));
    }
    if (!GetIt.I.isRegistered<SeniorProfBloc>()) {
      instance.registerFactory<SeniorProfBloc>(() => SeniorProfBloc(
          instance(),
          instance(),
          instance(),
          instance(),
          instance(),
          instance(),
          instance(),
                instance(),
          instance()));
    }
  }
}

Future<void> initSeniorModule() async {
  if (!GetIt.I.isRegistered<AllSeinor_Rep_Usecase>()) {
    instance.registerFactory<AllSeinor_Rep_Usecase>(
        () => AllSeinor_Rep_Usecase(instance()));
    instance.registerFactory<AllCityUsecase>(
            () => AllCityUsecase(instance()));

    instance.registerFactory<SeniorRepsBloc>(() => SeniorRepsBloc(instance(),instance()));
  }
}

Future<void> initSeniorReportScienceModule() async {
  if (!GetIt.I.isRegistered<AllVisitNotesUsecase>()) {
    instance.registerFactory<AllVisitNotesUsecase>(
        () => AllVisitNotesUsecase(instance()));
    instance.registerFactory<ReportScienceBloc>(
        () => ReportScienceBloc(instance()));
  }
}

Future<void> initSeniorReportIssueModule() async {
  if (!GetIt.I.isRegistered<AllVisitIssueUsecase>()) {
    instance.registerFactory<AllVisitIssueUsecase>(
        () => AllVisitIssueUsecase(instance()));
    instance
        .registerFactory<ReportIssueBloc>(() => ReportIssueBloc(instance()));
  }
}

Future<void> initSeniorReportInventoryModule() async {
  if (!GetIt.I.isRegistered<AllInventoryUsecase>()) {
    instance.registerFactory<AllInventoryUsecase>(
        () => AllInventoryUsecase(instance()));
    instance.registerFactory<ReportInventoryBloc>(
        () => ReportInventoryBloc(instance()));
  }
}
Future<void> initSeniorManageFutureModule() async {
  if (!GetIt.I.isRegistered<AllRepsFutureUsecase>()) {
    instance.registerFactory<AllRepsFutureUsecase>(
            () => AllRepsFutureUsecase(instance()));
    instance.registerFactory<ManageFutureBloc>(
            () => ManageFutureBloc(instance()));
  }
}
Future<void> initActivePlanModule() async {
  if (!GetIt.I.isRegistered<GetInfoPlanBrandsUsecase>()) {
    instance.registerFactory<GetInfoPlanBrandsUsecase>(
        () => GetInfoPlanBrandsUsecase(instance()));
    instance.registerFactory<ActivePlanBloc>(() => ActivePlanBloc(instance()));
  }
}

Future<void> initReportVisitDoctorModule() async {
  if (!GetIt.I.isRegistered<AllVisitDoctorRepSenUsecase>()) {
    instance.registerFactory<AllVisitDoctorRepSenUsecase>(
        () => AllVisitDoctorRepSenUsecase(instance()));
    instance.registerFactory<AllReadSenUsecase>(
            () => AllReadSenUsecase(instance()));
    instance
        .registerFactory<ReadVisitUsecase>(() => ReadVisitUsecase(instance()));
    instance.registerFactory<AllVisitHospitalRepSenUsecase>(
        () => AllVisitHospitalRepSenUsecase(instance()));
    instance.registerFactory<ReportVisitDoctorBloc>(
        () => ReportVisitDoctorBloc(instance(), instance(), instance(), instance()));
  }
}

Future<void> iniFutureModule() async {
  if (!GetIt.I.isRegistered<AllSpeUsecase>()) {
    instance.registerFactory<AllSpeUsecase>(() => AllSpeUsecase(instance()));
  }

  if (!GetIt.I.isRegistered<RepPlanBrandSpUsecase>()) {
    instance.registerFactory<RepPlanBrandSpUsecase>(
        () => RepPlanBrandSpUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<FutureRepBloc>()) {
    instance.registerFactory<FutureRepBloc>(() => FutureRepBloc(
          instance(),
          instance(),
        ));
  }
}
Future<void> iniEditBrandPlanModule() async {
  if (!GetIt.I.isRegistered<AllPlanBrandsUsecase>()) {
    instance.registerFactory<AllPlanBrandsUsecase>(() => AllPlanBrandsUsecase(instance()));
  }

  if (!GetIt.I.isRegistered<AllPlanBrandsTypeUsecase>()) {
    instance.registerFactory<AllPlanBrandsTypeUsecase>(() => AllPlanBrandsTypeUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<ChangePlanBrandTypeUsecase>()) {
    instance.registerFactory<ChangePlanBrandTypeUsecase>(
            () => ChangePlanBrandTypeUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<EditBrandPlanBloc>()) {
    instance.registerFactory<EditBrandPlanBloc>(() => EditBrandPlanBloc(
      instance(),
      instance(),
    ));
  }
}
Future<void> iniSearchDoctorsModule() async {
  if (!GetIt.I.isRegistered<SearchDoctorsUsecase>()) {
    instance.registerFactory<SearchDoctorsUsecase>(
            () => SearchDoctorsUsecase(instance()));
  }
   if (!GetIt.I.isRegistered<DocDoctorsUseCase>()) {
    instance.registerFactory<DocDoctorsUseCase>(
            () => DocDoctorsUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<DoctorInfoUsecase>()) {
    instance.registerFactory<DoctorInfoUsecase>(
            () => DoctorInfoUsecase(instance()));
  }
  if (!GetIt.I.isRegistered<SearchDoctorsBloc>()) {
    instance.registerFactory<SearchDoctorsBloc>(() => SearchDoctorsBloc(
      instance(),   instance(),instance()
    ));
  }
}