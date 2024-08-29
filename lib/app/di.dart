import 'package:dio/dio.dart';
import 'package:domina_app/app/app_preferences.dart';
import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/network/app_api.dart';
import 'package:domina_app/data/network/dio_factory.dart';
import 'package:domina_app/data/network/network_info.dart';
import 'package:domina_app/data/repository/repository.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/presentation/auth/bloc/auth_bloc.dart';
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
