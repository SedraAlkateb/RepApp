import 'package:domina_app/domain/repository/sql_session_repository.dart';
import 'package:domina_app/domain/repository/sql_directory_repository.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:domina_app/domain/repository/sql_plans_repository.dart';

/// واجهة مجمّعة تنفّذها [RepositroySqlImp]؛ كل UseCase يعتمد على الواجهة الصغيرة التي يحتاجها فقط.
abstract class RepositorySql implements SqlSessionRepository, SqlDirectoryRepository, SqlVisitsRepository, SqlPlansRepository {}
