import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/repository/sql_session_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteSqlUsecase extends Equatable {
  final SqlSessionRepository _repositorySql;
  DeleteSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute() async {
    return await _repositorySql.clearDatabase();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
