// lib/app/di/di_network.dart
import 'package:domina_app/crashlytics/crashlytics_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:domina_app/data/network/dio_factory.dart';
import 'package:domina_app/data/network/app_api.dart';
import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/repository/repository.dart';
import 'package:domina_app/domain/repostitory/repository.dart' as domain_repo;

final GetIt instance = GetIt.instance;

Future<void> initNetworkModule() async {
  if (instance.isRegistered<AppServiceClient>()) return;

  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(
      instance<CrashlyticsService>(),
    ),
  );

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClient(dio),
  );

  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance<AppServiceClient>()),
  );


  instance.registerLazySingleton<domain_repo.Repository>(
    () => RepositoryImp(instance(), instance(), instance()),
  );
}