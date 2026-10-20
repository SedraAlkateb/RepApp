import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_directory_repository.dart';
import 'package:equatable/equatable.dart';

class SpHospitalSqlUsecase extends Equatable {
  final SqlDirectoryRepository _repositorySql;
  SpHospitalSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<SpecHospitalSp>>> execute(int hospitalId) async {
    return await _repositorySql.specializationByHospitalId(hospitalId);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
