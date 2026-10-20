import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class AllBrandsDoctorVisitsSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  AllBrandsDoctorVisitsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<PharmacyBrandModel>>> execute(int visitId) async {
    return await _repositorySql.getBrandsDoctorByVisitId(visitId);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
