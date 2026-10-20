import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_plans_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateBrandPlanSqlUsecase extends Equatable {
  final SqlPlansRepository _repositorySql;
  UpdateBrandPlanSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(
      List<OtherBrandSpPlanModel> planBrands) async {
    return await _repositorySql.updateAmounts(planBrands);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
