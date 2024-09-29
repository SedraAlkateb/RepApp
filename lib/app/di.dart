import 'package:dio/dio.dart';
import 'package:domina_app/app/app_preferences.dart';
import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/network/app_api.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/dio_factory.dart';
import 'package:domina_app/data/network/network_info.dart';
import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:domina_app/data/repository/repository.dart';
import 'package:domina_app/data/repository/repositroy_sql.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/domain/usecase/all_brands_doctor_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_flag_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_hospital_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_pharmacy_visits_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_doctor_sql_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_sp_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase%20.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:domina_app/domain/usecase/all_brands_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospitals_sql_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_pharmacy_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_pharmacy_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_pharmacy_sql_usecase.dart';
import 'package:domina_app/domain/usecase/async_data_sql_usecase.dart';
import 'package:domina_app/domain/usecase/delete_sql_usecase.dart';
import 'package:domina_app/domain/usecase/doctors_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/hospitals_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_brand_pharmacy_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_doctor_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/insert_visit_pharmacy_sql_usecase.dart';
import 'package:domina_app/domain/usecase/login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/login_usecase.dart';
import 'package:domina_app/domain/usecase/pharmacies_by_place_usecase.dart';
import 'package:domina_app/domain/usecase/sp_hospital_sql_usecase.dart';
import 'package:domina_app/domain/usecase/update_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/update_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/update_pharmacy_usecase.dart';
import 'package:domina_app/domain/usecase/visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/visit_hospital_usecase.dart';
import 'package:domina_app/domain/usecase/visit_pharmacy_usecase.dart';
import 'package:domina_app/presentation/async/bloc/async_bloc.dart';
import 'package:domina_app/presentation/async_in/bloc/async_in_bloc.dart';
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
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt instance=GetIt.instance;
Future<void>initAppModule()async{
  //app module itd a module where are put all generic dependencies
  //shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() =>
  sharedPrefs);
  //app prefs instance
  instance.registerLazySingleton<AppPreferences>(() =>
      AppPreferences(instance()));
  //network info instance
  instance.registerLazySingleton<NetworkInfo>(() =>
      NetWorkInfoImpl(InternetConnectionChecker()));
  instance.registerLazySingleton<DioFactory>(() =>
      DioFactory(instance()));
  Dio dio =await instance<DioFactory>().getDio();
  DatabaseHelper databaseHelper=DatabaseHelper();
  instance.registerLazySingleton<AppSqlApi>(() =>
      AppSqlApi(databaseHelper));
  instance.registerLazySingleton<RepositorySql>(() =>
      RepositroySqlImp(
          instance()
      )
  );
  instance.registerLazySingleton<AppServiceClient>(() =>
      AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(() =>
      RemoteDataSourceImpl(instance<AppServiceClient>()));
  //repository
  instance.registerLazySingleton<Repository>(() =>
      RepositoryImp(
          instance(),instance()
      )
  );

}

Future<void>initAsyncModule() async{
  if(!GetIt.I.isRegistered<AsyncBloc>()){
    instance.registerFactory<AllBrandsUsecase>(() =>AllBrandsUsecase(instance()));
    instance.registerFactory<AllPharmacyUsecase>(() =>AllPharmacyUsecase(instance()));
    instance.registerFactory<AllPlaceUsecase>(() =>AllPlaceUsecase(instance()));
    instance.registerFactory<AllSpeUsecase>(() =>AllSpeUsecase(instance()));
    instance.registerFactory<AsyncDataSqlUsecase>(() =>AsyncDataSqlUsecase(instance()));
    instance.registerFactory<AllDoctorUsecase>(() =>AllDoctorUsecase(instance()));
    instance.registerFactory<AllHospitalUsecase>(() =>AllHospitalUsecase(instance()));
    instance.registerFactory<AllHospialSpUsecase>(() =>AllHospialSpUsecase(instance()));
    instance.registerFactory<EditIsLoginSqlUsecase>(() =>EditIsLoginSqlUsecase(instance()));
    instance.registerFactory<AsyncBloc>(() =>AsyncBloc(instance(),instance(),instance(),
        instance(),instance(),instance(),instance(),instance(),instance()));
  }
}
Future<void>initLoginModule() async{
  if(!GetIt.I.isRegistered<AuthBloc>()){
     instance.registerFactory<LoginUsecase>(() =>LoginUsecase(instance()));
    instance.registerFactory<LoginSqlUsecase>(() =>LoginSqlUsecase(instance()));
     instance.registerFactory<DeleteSqlUsecase>(() =>DeleteSqlUsecase(instance()));

    instance.registerFactory<AuthBloc>(() =>AuthBloc(instance(),instance(),instance()));
  }
}
Future<void>initPlaceVisitModule() async {
  if(!GetIt.I.isRegistered<PharmaciesByPlaceUsecase>()){
    instance.registerFactory<PharmaciesByPlaceUsecase>(() =>PharmaciesByPlaceUsecase(instance()));
    instance.registerFactory<DoctorsByPlaceUsecase>(() =>DoctorsByPlaceUsecase(instance()));
    instance.registerFactory<HospitalsByPlaceUsecase>(() =>HospitalsByPlaceUsecase(instance()));
    instance.registerFactory<AllBrandsFlagSqlUsecase>(() =>AllBrandsFlagSqlUsecase(instance()));
    instance.registerFactory<InsertVisitPharmacySqlUsecase>(() =>InsertVisitPharmacySqlUsecase(instance()));
    instance.registerFactory<InsertVisitDoctorSqlUsecase>(() =>InsertVisitDoctorSqlUsecase(instance()));
    instance.registerFactory<InsertVisitBrandPharmacySqlUsecase>(() =>InsertVisitBrandPharmacySqlUsecase(instance()));
    instance.registerFactory<InsertVisitBrandDoctorSqlUsecase>(() =>InsertVisitBrandDoctorSqlUsecase(instance()));
    instance.registerFactory<InsertVisitBrandHospitalSqlUsecase>(() =>InsertVisitBrandHospitalSqlUsecase(instance()));

    instance.registerFactory<SpHospitalSqlUsecase>(() =>SpHospitalSqlUsecase(instance()));
    instance.registerFactory<InsertVisitHospitalSqlUsecase>(() =>InsertVisitHospitalSqlUsecase(instance()));
    instance.registerFactory<AllBrandsSqlUsecase>(() =>AllBrandsSqlUsecase(instance()));

    instance.registerFactory<VisitPlaceBloc>(() =>VisitPlaceBloc(instance(),instance(),
        instance(),instance(),instance(),instance(),instance(),instance(),instance(),instance(),instance(),instance()));}
}
Future<void>initPlacesModule() async{
  if(!GetIt.I.isRegistered<AllPlacesSqlUsecase>()){
    instance.registerFactory<AllPlacesSqlUsecase>(() =>AllPlacesSqlUsecase(instance()));
    instance.registerFactory<VisitPharmacyUsecase>(() =>VisitPharmacyUsecase(instance()));
    instance.registerFactory<PlaceBloc>(() =>PlaceBloc(instance(),instance()));
  }
}
Future<void>initVisitsModule() async{
  if(!GetIt.I.isRegistered<AllVisitPharmacySqlUsecase>()){
    instance.registerFactory<AllVisitPharmacySqlUsecase>(() =>AllVisitPharmacySqlUsecase(instance()));
    instance.registerFactory<AllVisitDoctorSqlUsecase>(() =>AllVisitDoctorSqlUsecase(instance()));
    instance.registerFactory<AllBrandsPharmacyVisitsSqlUsecase>(() =>AllBrandsPharmacyVisitsSqlUsecase(instance()));
    instance.registerFactory<AllBrandsDoctorVisitsSqlUsecase>(() =>AllBrandsDoctorVisitsSqlUsecase(instance()));
    instance.registerFactory<AllBrandsHospitalVisitsSqlUsecase>(() =>AllBrandsHospitalVisitsSqlUsecase(instance()));
    instance.registerFactory<AllVisitHospitalSqlUsecase>(() =>AllVisitHospitalSqlUsecase(instance()));
    instance.registerFactory<UpdateDoctorUsecase>(() =>UpdateDoctorUsecase(instance()));
    instance.registerFactory<UpdateHospitalUsecase>(() =>UpdateHospitalUsecase(instance()));
    instance.registerFactory<UpdatePharmacyUsecase>(() =>UpdatePharmacyUsecase(instance()));
    instance.registerFactory<VisitBloc>(() =>VisitBloc(instance(),instance(),instance(),
        instance(),instance(),instance(),instance(),instance(),instance()));
  }
}
Future<void>initSpecModule() async{
  if(!GetIt.I.isRegistered<AllSpecsSqlUsecase>()){
    instance.registerFactory<AllSpecsSqlUsecase>(() =>AllSpecsSqlUsecase(instance()));
    instance.registerFactory<SpecializationBloc>(() =>SpecializationBloc(instance()));
  }
}
Future<void>initAsyncInModule() async{
  if(!GetIt.I.isRegistered<AsyncInBloc>()){
    instance.registerFactory<VisitHospitalUsecase>(() =>VisitHospitalUsecase(instance()));
    instance.registerFactory<VisitDoctorUsecase>(() =>VisitDoctorUsecase(instance()));
    instance.registerFactory<VisitPharmacyUsecase>(() =>VisitPharmacyUsecase(instance()));
    instance.registerFactory<AsyncInBloc>(() =>AsyncInBloc(instance(),instance(),instance()));
  }
}


Future<void>initdoctorModule() async{
  if(!GetIt.I.isRegistered<AllDoctorsSqlUsecase>()){
    instance.registerFactory<AllDoctorsSqlUsecase>(() =>AllDoctorsSqlUsecase(instance()));
    instance.registerFactory<DoctorsBloc>(() =>DoctorsBloc(instance()));
  }
}
Future<void>inithospitalModule() async{
  if(!GetIt.I.isRegistered<AllHospitalsSqlUsecase>()){
    instance.registerFactory<AllHospitalsSqlUsecase>(() =>AllHospitalsSqlUsecase(instance()));
    instance.registerFactory<HospitalsBloc>(() =>HospitalsBloc(instance()));
  }
}
Future<void>initBrandModule() async{
  if(!GetIt.I.isRegistered<AllBrandsSqlUsecase>()) {
    instance.registerFactory<AllBrandsSqlUsecase>(() =>
        AllBrandsSqlUsecase(instance()));
  }
  if(!GetIt.I.isRegistered<BrandBloc>()) {
    instance.registerFactory<BrandBloc>(() =>BrandBloc(instance()));
  }
}

Future<void>initPharmacyModule() async{
  if(!GetIt.I.isRegistered<AllPharmacySqlUsecase>()){
    instance.registerFactory<AllPharmacySqlUsecase>(() =>AllPharmacySqlUsecase(instance()));
    instance.registerFactory<PharmacyBloc>(() =>PharmacyBloc(instance()));

  }
}