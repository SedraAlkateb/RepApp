
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllHospitalSpSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  AllHospitalSpSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<HospitalModel>>> execute(int spId) async{
    return await _repositorySql.getHospitalBySpec(spId);
  }

  @override

  List<Object?> get props => [_repositorySql];

}




