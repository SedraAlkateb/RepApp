// name=lib/app/di_network.dart
import 'package:get_it/get_it.dart';
import 'package:domina_app/data/network/dio_factory.dart';
import 'package:domina_app/data/network/app_api.dart';
import 'package:dio/dio.dart';
import 'package:domina_app/crashlytics/crashlytics_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> initNetworkModule() async {
  if (!getIt.isRegistered<DioFactory>()) {
    getIt.registerLazySingleton<DioFactory>(() => DioFactory(getIt<CrashlyticsService>()));
  }

  if (!getIt.isRegistered<Dio>()) {
    final dio = await getIt<DioFactory>().getDio();
    getIt.registerLazySingleton<Dio>(() => dio);
  }

  if (!getIt.isRegistered<AppServiceClient>()) {
    getIt.registerLazySingleton<AppServiceClient>(() => AppServiceClient(getIt<Dio>()));
  }

  // RemoteDataSource etc. (register if you have)
  // if (!getIt.isRegistered<RemoteDataSource>()) {...}
}