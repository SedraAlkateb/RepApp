import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class LogRepository {
  Future<Either<Failure, MessageModel>> insertLog(
      ExceptionRequestBody list1);
}
