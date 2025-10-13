import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';

class ExcRepository  {
  final AppSqlApi _databaseHelper;
  ExcRepository(this._databaseHelper);
  Future<Either<Failure, Null>> exceptionApi(ExceptionModel exceptionModel) async {
    try {
      await _databaseHelper.exceptionApi(exceptionModel);
      print("_____________________hhhh______________________________");
            print("تنتين بيكفو");
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

}