import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/repository/sql_session_repository.dart';
import 'package:equatable/equatable.dart';

class IsPlanSqlUsecase extends Equatable {
  final SqlSessionRepository _repositorySql;
  IsPlanSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(int repId, int flag) async {
    return await _repositorySql.editIsPlan(repId, flag);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
