
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class UpdateActiveSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  UpdateActiveSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(int repId, int otherPlanId, int activePlanId, int otherstatus,  String startDate,String endDate,String otherStartDate,String otherEndDate) async{
    return await _repositorySql.updateRep(repId, otherPlanId, activePlanId, otherstatus, startDate, endDate, otherStartDate, otherEndDate);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




