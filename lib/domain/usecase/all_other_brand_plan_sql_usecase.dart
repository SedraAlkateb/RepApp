
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllOtherBrandPlanSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  AllOtherBrandPlanSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<OtherBrandSpPlanModel>>> execute(int repPlanId) async{
    return await _repositorySql.otherPlanBrandByRepPlanId(repPlanId);
  }
  @override
  List<Object?> get props => [_repositorySql];

}




