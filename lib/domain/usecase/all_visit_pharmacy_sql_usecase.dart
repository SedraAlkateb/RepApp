
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllVisitPharmacySqlUsecase extends Equatable {
 final RepositorySql _repositorySql;
 AllVisitPharmacySqlUsecase(this._repositorySql);
  Future<Either<Failure, List<VisitPharmacyAndPharmacy>>> execute() async{
    return await _repositorySql.getVisitPharmacy();
  }

  @override
  List<Object?> get props => [_repositorySql];

}




