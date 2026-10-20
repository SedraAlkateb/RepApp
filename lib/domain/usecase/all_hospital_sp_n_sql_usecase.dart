import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_directory_repository.dart';
import 'package:equatable/equatable.dart';

class AllHospitalSpNSqlUsecase extends Equatable {
  final SqlDirectoryRepository _repositorySql;
  AllHospitalSpNSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<HospitalSpAllModel>>> execute() async {
    return await _repositorySql.getAllHospitalSpecialization();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
