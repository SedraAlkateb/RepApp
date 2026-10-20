import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

/// تسجيل الاستثناءات محلياً.
abstract class ExcRepository {
  Future<Either<Failure, Null>> exceptionApi(ExceptionModel exceptionModel);
}
