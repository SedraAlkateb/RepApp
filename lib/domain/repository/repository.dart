import 'package:domina_app/domain/repository/auth_repository.dart';
import 'package:domina_app/domain/repository/directory_repository.dart';
import 'package:domina_app/domain/repository/visits_repository.dart';
import 'package:domina_app/domain/repository/plans_repository.dart';
import 'package:domina_app/domain/repository/recipes_repository.dart';
import 'package:domina_app/domain/repository/reps_repository.dart';
import 'package:domina_app/domain/repository/log_repository.dart';

/// واجهة مجمّعة تنفّذها [RepositoryImp]؛ كل UseCase يعتمد على الواجهة الصغيرة التي يحتاجها فقط.
abstract class Repository implements AuthRepository, DirectoryRepository, VisitsRepository, PlansRepository, RecipesRepository, RepsRepository, LogRepository {}
