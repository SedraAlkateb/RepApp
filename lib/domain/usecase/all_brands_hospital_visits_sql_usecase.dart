import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class AllBrandsHospitalVisitsSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  AllBrandsHospitalVisitsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<PharmacyBrandModel>>> execute(int visitId) async {
    return await _repositorySql.getBrandsHospitalByVisitId(visitId);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
