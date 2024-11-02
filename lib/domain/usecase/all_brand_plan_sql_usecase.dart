
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllBrandPlanSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  AllBrandPlanSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<BrandSpPlanModel>>> execute(int repPlanId) async{
    return await _repositorySql.planBrandByRepPlanId(repPlanId);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




