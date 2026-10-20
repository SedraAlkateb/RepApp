import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class AllVisitDoctorSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  AllVisitDoctorSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<VisitDoctorAndDoctor>>> execute() async {
    return await _repositorySql.getVisitDoctor();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
