import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/repository/repository_sql.dart';
import 'package:equatable/equatable.dart';

class UpdateFlagHospitalSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  UpdateFlagHospitalSqlUsecase(this._repositorySql);
  Future<Either<Failure, bool>> execute(
      {List<int>? visitIds, List<int>? brandIds}) async {
    return await _repositorySql.updateFlagsToHospital(
        visitIds: visitIds, brandIds: brandIds);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
