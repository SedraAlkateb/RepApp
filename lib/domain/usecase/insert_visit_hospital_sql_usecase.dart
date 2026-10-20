import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class InsertVisitHospitalSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  InsertVisitHospitalSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(
      VisitHospitalModel visitHospitalModel, int hos, int spec) async {
    return await _repositorySql.insertVisitHospital(
        visitHospitalModel, hos, spec);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
