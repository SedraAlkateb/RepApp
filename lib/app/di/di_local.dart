// lib/app/di/di_local.dart
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:domina_app/domain/usecase/insert_exception_sql_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/repository/repositroy_sql.dart';
import 'package:domina_app/domain/ex.dart';

final GetIt instance = GetIt.instance;

Future<void> initLocalModule() async {
  if (!instance.isRegistered<DatabaseHelper>()) {
    instance.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  }

  if (!instance.isRegistered<AppSqlApi>()) {
    instance.registerLazySingleton<AppSqlApi>(() => AppSqlApi(instance<DatabaseHelper>()));
    await instance<AppSqlApi>().initializeDatabase();
  }

  if (!instance.isRegistered<ExcRepository>()) {
    instance.registerLazySingleton<ExcRepository>(() => ExcRepository(instance()));
  }
  instance.registerLazySingleton<RepositorySql>(
    () => RepositroySqlImp(instance(), instance()),
  );
  instance.registerLazySingleton<InsertExceptionSqlUsecase>(
    () => InsertExceptionSqlUsecase(instance()),
  );
}