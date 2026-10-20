import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class GetHospitalSpVisitsSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  GetHospitalSpVisitsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<HospitalSpModel>>> execute() async {
    return await _repositorySql.visitHospitalSpAs();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
