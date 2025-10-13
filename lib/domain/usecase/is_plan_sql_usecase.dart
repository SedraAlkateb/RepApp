
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class IsPlanSqlUsecase extends Equatable {
 final RepositorySql _repositorySql;
 IsPlanSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(int repId,int flag) async{
    return await _repositorySql.editIsPlan(repId, flag);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




