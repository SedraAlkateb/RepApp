import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_plans_repository.dart';
import 'package:equatable/equatable.dart';

class AllOtherBrandPlanSqlUsecase extends Equatable {
  final SqlPlansRepository _repositorySql;
  AllOtherBrandPlanSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<OtherBrandSpPlanModel>>> execute(
      int repPlanId) async {
    return await _repositorySql.otherPlanBrandByRepPlanId(repPlanId);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
