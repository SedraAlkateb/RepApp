// lib/app/di/di_network.dart
import 'package:domina_app/crashlytics/crashlytics_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:domina_app/data/network/dio_factory.dart';
import 'package:domina_app/data/network/app_api.dart';
import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/repository/repository.dart';
import 'package:domina_app/domain/repository/repository.dart' as domain_repo;
import 'package:domina_app/domain/repository/auth_repository.dart';
import 'package:domina_app/domain/repository/directory_repository.dart';
import 'package:domina_app/domain/repository/visits_repository.dart';
import 'package:domina_app/domain/repository/plans_repository.dart';
import 'package:domina_app/domain/repository/recipes_repository.dart';
import 'package:domina_app/domain/repository/reps_repository.dart';
import 'package:domina_app/domain/repository/log_repository.dart';

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

  // نفس النسخة تُكشف عبر واجهات صغيرة (ISP) لتعتمد عليها الـ UseCases.
  instance.registerLazySingleton<AuthRepository>(
      () => instance<domain_repo.Repository>());
  instance.registerLazySingleton<DirectoryRepository>(
      () => instance<domain_repo.Repository>());
  instance.registerLazySingleton<VisitsRepository>(
      () => instance<domain_repo.Repository>());
  instance.registerLazySingleton<PlansRepository>(
      () => instance<domain_repo.Repository>());
  instance.registerLazySingleton<RecipesRepository>(
      () => instance<domain_repo.Repository>());
  instance.registerLazySingleton<RepsRepository>(
      () => instance<domain_repo.Repository>());
  instance.registerLazySingleton<LogRepository>(
      () => instance<domain_repo.Repository>());
}