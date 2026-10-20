import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class NumDocHasSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  NumDocHasSqlUsecase(this._repositorySql);
  Future<Either<Failure, void>> execute() async {
    return await _repositorySql.numDocAndHos();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
