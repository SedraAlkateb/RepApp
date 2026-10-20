import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/repository/sql_session_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteAllSqlUsecase extends Equatable {
  final SqlSessionRepository _repositorySql;
  DeleteAllSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute() async {
    return await _repositorySql.clearDatabaseAll();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
