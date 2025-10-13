
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertVisitDoctorSqlUsecase extends Equatable {
  final  RepositorySql _repositorySql;
  InsertVisitDoctorSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(VisitDoctorModel visitDoctorModel) async{
    return await _repositorySql.insertVisitDoctor(visitDoctorModel);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




