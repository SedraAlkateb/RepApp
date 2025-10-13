import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllHospitalsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  AllHospitalsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<HospitalModel>>> execute() async{
    return await _repositorySql.getHospitalSql();
  }

  @override

  List<Object?> get props => [_repositorySql];

}




