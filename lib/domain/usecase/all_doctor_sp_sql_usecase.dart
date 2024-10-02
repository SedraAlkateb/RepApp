
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllDoctorSpSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  AllDoctorSpSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<DoctorModel>>> execute(int spId) async{
    return await _repositorySql.getDoctorBySpec(spId);
  }

  @override

  List<Object?> get props => [_repositorySql];

}




