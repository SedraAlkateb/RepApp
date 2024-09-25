import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllBrandsHospitalVisitsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  AllBrandsHospitalVisitsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<PharmacyBrandModel>>> execute(int visitId) async{
    return await _repositorySql.getBrandsHospitalByVisitId(visitId);
  }

  @override

  List<Object?> get props => [_repositorySql];

}

