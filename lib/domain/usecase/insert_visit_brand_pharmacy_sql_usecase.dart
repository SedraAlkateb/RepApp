
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertVisitBrandPharmacySqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  InsertVisitBrandPharmacySqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<VisitBrandPharmacyModel>visitBrandPharmacyModels,  VisitPharmacyModel visitPharmacyModel) async{
    return await _repositorySql.insertVisitBrandPharmacy(visitBrandPharmacyModels,visitPharmacyModel);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




