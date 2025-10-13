
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllVisitHospitalSqlUsecase extends Equatable {
 final RepositorySql _repositorySql;
 AllVisitHospitalSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<VisitHospitalAndHospital>>> execute() async{
    return await _repositorySql.getVisitHospital();
  }
  @override
  List<Object?> get props => [_repositorySql];

}




