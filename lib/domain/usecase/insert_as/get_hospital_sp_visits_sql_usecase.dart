
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class GetHospitalSpVisitsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  GetHospitalSpVisitsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<HospitalSpModel>>> execute() async{
    return await _repositorySql.visitHospitalSpAs();
  }

  @override

  List<Object?> get props => [_repositorySql];

}




