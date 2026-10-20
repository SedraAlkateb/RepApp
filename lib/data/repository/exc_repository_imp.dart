import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/exc_repository.dart';

class ExcRepositoryImp implements ExcRepository {
  final AppSqlApi _databaseHelper;
  ExcRepositoryImp(this._databaseHelper);

  @override
  Future<Either<Failure, Null>> exceptionApi(
      ExceptionModel exceptionModel) async {
    try {
      await _databaseHelper.exceptionApi(exceptionModel);
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
