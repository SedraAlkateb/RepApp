import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_directory_repository.dart';
import 'package:equatable/equatable.dart';

class DoctorsByPlaceUsecase extends Equatable {
  final SqlDirectoryRepository _repositorySql;
  DoctorsByPlaceUsecase(this._repositorySql);
  Future<Either<Failure, List<DoctorModel>>> execute(int id) async {
    return await _repositorySql.getDoctorByPlaceId(id);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
