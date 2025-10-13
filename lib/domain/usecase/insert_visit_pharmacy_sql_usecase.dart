
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertVisitPharmacySqlUsecase extends Equatable {
  final  RepositorySql _repositorySql;
  InsertVisitPharmacySqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(VisitPharmacyModel visitPharmacyModel) async{
    return await _repositorySql.insertVisitPharmacy(visitPharmacyModel);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




