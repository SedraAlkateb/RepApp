
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class GetPlanBrandSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  GetPlanBrandSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<PlanBrandModel>>> execute( ) async{
     return await _repositorySql.planBrandsAs();
  }
  @override
  List<Object?> get props => [_repositorySql];
}




