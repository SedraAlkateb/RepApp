
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class UpdateFlagHospitalSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  UpdateFlagHospitalSqlUsecase(this._repositorySql);
  Future<Either<Failure, bool>> execute() async{
    return await _repositorySql.updateFlagsToHospital();
  }
  @override
  List<Object?> get props => [_repositorySql];

}




