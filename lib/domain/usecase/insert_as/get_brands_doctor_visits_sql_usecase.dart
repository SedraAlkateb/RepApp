import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class GetBrandsDoctorVisitsSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  GetBrandsDoctorVisitsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> execute() async {
    return await _repositorySql.visitBrandDoctorAs();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
