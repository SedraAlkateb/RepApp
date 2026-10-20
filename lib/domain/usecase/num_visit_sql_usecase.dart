import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class NumVisitSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  NumVisitSqlUsecase(this._repositorySql);
  Future<Either<Failure, NumVisit>> execute() async {
    return await _repositorySql.numVisit();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
