import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_plans_repository.dart';
import 'package:equatable/equatable.dart';

class GetPlanBrandSqlUsecase extends Equatable {
  final SqlPlansRepository _repositorySql;
  GetPlanBrandSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<PlanBrandModel>>> execute() async {
    return await _repositorySql.planBrandsAs();
  }

  @override
  List<Object?> get props => [_repositorySql];
}
