
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class GetBrandsHospitalVisitsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  GetBrandsHospitalVisitsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> execute() async{
    return await _repositorySql.visitBrandHospitalAs();
  }

  @override

  List<Object?> get props => [_repositorySql];

}




