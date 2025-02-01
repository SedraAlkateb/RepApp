
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertExceptionSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  InsertExceptionSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(ExceptionModel exceptionModel)
  async
  {
    return await _repositorySql.exceptionApi(exceptionModel);
  }
  @override
  List<Object?> get props => [_repositorySql];
}




