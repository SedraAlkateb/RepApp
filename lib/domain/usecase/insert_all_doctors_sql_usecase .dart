import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';

class InsertAllDotorsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  InsertAllDotorsSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<DoctorModel> doctorModel) async {
    return await _repositorySql.insertDoctor(doctorModel);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
