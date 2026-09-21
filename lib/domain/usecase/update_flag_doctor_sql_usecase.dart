import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/repository/repository_sql.dart';
import 'package:equatable/equatable.dart';

class UpdateFlagDoctorSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  UpdateFlagDoctorSqlUsecase(this._repositorySql);
  Future<Either<Failure, bool>> execute(
      {List<int>? visitIds, List<int>? brandIds}) async {
    return await _repositorySql.updateFlagsToDoctor(
        visitIds: visitIds, brandIds: brandIds);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
