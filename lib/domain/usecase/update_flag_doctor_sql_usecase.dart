import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/repository/sql_visits_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateFlagDoctorSqlUsecase extends Equatable {
  final SqlVisitsRepository _repositorySql;
  UpdateFlagDoctorSqlUsecase(this._repositorySql);
  Future<Either<Failure, bool>> execute(
      {List<int>? visitIds, List<int>? brandIds}) async {
    return await _repositorySql.updateFlagsToDoctor(
        visitIds: visitIds, brandIds: brandIds);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
