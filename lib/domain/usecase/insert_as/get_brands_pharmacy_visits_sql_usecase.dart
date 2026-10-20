import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class GetBrandsPharmacyVisitsSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  GetBrandsPharmacyVisitsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> execute() async {
    return await _repositorySql.visitBrandPharmacyAs();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
