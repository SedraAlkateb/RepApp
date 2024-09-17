import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';

class InsertAllHospitalsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  InsertAllHospitalsSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<HospitalModel> doctorModel) async {
    return await _repositorySql.insertHospital(doctorModel);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repositorySql];
}
