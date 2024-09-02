import 'package:dio/dio.dart';
import 'package:domina_app/app/app_preferences.dart';
import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/network/app_api.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/dio_factory.dart';
import 'package:domina_app/data/network/network_info.dart';
import 'package:domina_app/data/network/sqllite_factory.dart';
import 'package:domina_app/data/repository/repository.dart';
import 'package:domina_app/data/repository/repositroy_sql.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:domina_app/domain/usecase/all_brands_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_brands_usecase.dart';
import 'package:domina_app/domain/usecase/all_pharmacy_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/insert_all_brands_sql_usecase.dart';
import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:domina_app/presentation/brand/bloc/brand_bloc.dart';
import 'package:domina_app/presentation/pharmacy/bloc/pharmacy_bloc.dart';
import 'package:domina_app/presentation/places/bloc/place_bloc.dart';
import 'package:domina_app/presentation/specialization/bloc/specialization_bloc.dart';
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
Future<void>initLoginModule() async{


  if(!GetIt.I.isRegistered<AuthBloc>()){
    instance.registerFactory<AuthBloc>(() =>AuthBloc());
   }

}
Future<void>initPlacesModule() async{

  if(!GetIt.I.isRegistered<AllPlaceUsecase>()){
    instance.registerFactory<AllPlaceUsecase>(() =>AllPlaceUsecase(instance()));
    instance.registerFactory<PlaceBloc>(() =>PlaceBloc(instance()));
  }

}
Future<void>initSpecModule() async{
  if(!GetIt.I.isRegistered<AllSpeUsecase>()){
    instance.registerFactory<AllSpeUsecase>(() =>AllSpeUsecase(instance()));
    instance.registerFactory<SpecializationBloc>(() =>SpecializationBloc(instance()));
  }
}
Future<void>initBrandModule() async{
  if(!GetIt.I.isRegistered<AllBrandsUsecase>()){
    instance.registerFactory<AllBrandsSqlUsecase>(() =>AllBrandsSqlUsecase(instance()));
    instance.registerFactory<InsertAllBrandsSqlUsecase>(() =>InsertAllBrandsSqlUsecase(instance()));

    instance.registerFactory<AllBrandsUsecase>(() =>AllBrandsUsecase(instance()));
    instance.registerFactory<BrandBloc>(() =>BrandBloc(instance(),instance(),instance()));
  }
}
Future<void>initPharmacyModule() async{
  if(!GetIt.I.isRegistered<AllPharmacyUsecase>()){
    instance.registerFactory<AllPharmacyUsecase>(() =>AllPharmacyUsecase(instance()));
    instance.registerFactory<PharmacyBloc>(() =>PharmacyBloc(instance()));
  }
}