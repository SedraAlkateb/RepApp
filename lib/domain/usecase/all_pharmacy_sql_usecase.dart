import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_directory_repository.dart';
import 'package:equatable/equatable.dart';

class AllPharmacySqlUsecase extends Equatable {
  final SqlDirectoryRepository _repositorySql;
  AllPharmacySqlUsecase(this._repositorySql);
  Future<Either<Failure, List<PharmacyModel>>> execute() async {
    return await _repositorySql.getPharmacySql();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
