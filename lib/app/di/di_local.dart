// name=lib/app/di_local.dart
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:get_it/get_it.dart';
import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/repository/repositroy_sql.dart';
import 'package:domina_app/domain/ex.dart';

final GetIt getIt = GetIt.instance;

Future<void> initLocalModule() async {
  if (!getIt.isRegistered<DatabaseHelper>()) {
    getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  }

  if (!getIt.isRegistered<AppSqlApi>()) {
    getIt.registerLazySingleton<AppSqlApi>(() => AppSqlApi(getIt<DatabaseHelper>()));
    // initialize DB
    await getIt<AppSqlApi>().initializeDatabase();
  }

  if (!getIt.isRegistered<ExcRepository>()) {
    getIt.registerLazySingleton<ExcRepository>(() => ExcRepository(getIt()));
  }

  if (!getIt.isRegistered<RepositorySql>()) {
    getIt.registerLazySingleton<RepositorySql>(() => RepositroySqlImp(getIt<AppSqlApi>(), getIt<ExcRepository>()));
  }
}