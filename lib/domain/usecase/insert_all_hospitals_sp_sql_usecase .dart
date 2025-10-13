import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';

class InsertAllHospitalsSpSqlUsecase  extends Equatable {
  final RepositorySql _repositorySql;
  InsertAllHospitalsSpSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<HospitalSpModel> hospitalSpModel) async {
    return await _repositorySql.insertHospitalSp(hospitalSpModel);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
