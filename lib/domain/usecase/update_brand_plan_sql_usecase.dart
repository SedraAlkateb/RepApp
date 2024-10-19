
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class UpdateBrandPlanSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  UpdateBrandPlanSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<PlanBrandSqlModel>planBrands) async{
    return await _repositorySql.updateAmounts(planBrands);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




