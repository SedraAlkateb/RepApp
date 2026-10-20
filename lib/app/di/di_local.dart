// lib/app/di/di_local.dart
import 'package:domina_app/domain/repository/sql_session_repository.dart';
import 'package:domina_app/domain/repository/sql_directory_repository.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:domina_app/domain/repository/sql_plans_repository.dart';
import 'package:domina_app/domain/repository/repository_sql.dart';
import 'package:get_it/get_it.dart';
import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/repository/repositroy_sql.dart';
import 'package:domina_app/domain/repository/exc_repository.dart';
import 'package:domina_app/data/repository/exc_repository_imp.dart';

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
    instance.registerLazySingleton<ExcRepository>(() => ExcRepositoryImp(instance()));
  }
  instance.registerLazySingleton<RepositorySql>(
    () => RepositroySqlImp(instance(), instance()),
  );

  // نفس النسخة تُكشف عبر واجهات صغيرة (ISP) لتعتمد عليها الـ UseCases.
  instance.registerLazySingleton<SqlSessionRepository>(
      () => instance<RepositorySql>());
  instance.registerLazySingleton<SqlDirectoryRepository>(
      () => instance<RepositorySql>());
  instance.registerLazySingleton<SqlVisitsRepository>(
      () => instance<RepositorySql>());
  instance.registerLazySingleton<SqlPlansRepository>(
      () => instance<RepositorySql>());
}