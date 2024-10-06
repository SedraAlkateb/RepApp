
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class GetPharmacyVisitsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  GetPharmacyVisitsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<VisitPharmacyModel>>> execute( ) async{
    return await _repositorySql.visitPharmacyAs();
  }

  @override

  List<Object?> get props => [_repositorySql];

}




