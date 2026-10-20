import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_directory_repository.dart';
import 'package:equatable/equatable.dart';

class AllPlacesSqlUsecase extends Equatable {
  final SqlDirectoryRepository _repositorySql;
  AllPlacesSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<PlaceModel>>> execute() async {
    return await _repositorySql.getPlaceSql();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
