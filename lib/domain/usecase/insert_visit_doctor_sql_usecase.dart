import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class InsertVisitDoctorSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  InsertVisitDoctorSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(
      VisitDoctorModel visitDoctorModel) async {
    return await _repositorySql.insertVisitDoctor(visitDoctorModel);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
