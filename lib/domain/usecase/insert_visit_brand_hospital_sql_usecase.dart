import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class InsertVisitBrandHospitalSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  InsertVisitBrandHospitalSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
      VisitHospitalModel visitHospitalModel,
      int hos,
      int spec) async {
    return await _repositorySql.insertVisitBrandHospital(
        visitHospitalModel, visitBrandPharmacyModels, hos, spec);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
