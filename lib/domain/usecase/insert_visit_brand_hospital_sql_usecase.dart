
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertVisitBrandHospitalSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  InsertVisitBrandHospitalSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<VisitBrandPharmacyModel>visitBrandPharmacyModels,  VisitHospitalModel visitHospitalModel,int hos, int spec) async{
    return await _repositorySql.insertVisitBrandHospital(visitHospitalModel,visitBrandPharmacyModels,hos,spec);
  }
  @override
  List<Object?> get props => [_repositorySql];
}



