
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class SpHospitalSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  SpHospitalSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<SpecHospitalSp>>> execute(int hospitalId) async{
    return await _repositorySql.specializationByHospitalId(hospitalId);
  }

  @override

  List<Object?> get props => [_repositorySql];

}




