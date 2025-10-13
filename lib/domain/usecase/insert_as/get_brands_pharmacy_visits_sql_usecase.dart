
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class GetBrandsPharmacyVisitsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  GetBrandsPharmacyVisitsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> execute() async{
    return await _repositorySql.visitBrandPharmacyAs();
  }

  @override

  List<Object?> get props => [_repositorySql];

}




