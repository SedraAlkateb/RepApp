
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertVisitHospitalSqlUsecase extends Equatable {
  final  RepositorySql _repositorySql;
  InsertVisitHospitalSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(VisitHospitalModel visitHospitalModel) async{
    return await _repositorySql.insertVisitHospital(visitHospitalModel);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




