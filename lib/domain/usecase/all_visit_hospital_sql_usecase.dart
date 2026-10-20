import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class AllVisitHospitalSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  AllVisitHospitalSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<VisitHospitalAndHospital>>> execute() async {
    return await _repositorySql.getVisitHospital();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
