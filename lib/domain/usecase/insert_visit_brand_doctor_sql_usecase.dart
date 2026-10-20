import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class InsertVisitBrandDoctorSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  InsertVisitBrandDoctorSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
      VisitDoctorModel visitDoctorModel) async {
    return await _repositorySql.insertVisitBrandDoctor(
        visitBrandPharmacyModels, visitDoctorModel);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
