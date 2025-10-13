
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class NumVisitSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  NumVisitSqlUsecase(this._repositorySql);
  Future<Either<Failure, NumVisit>> execute()
  async
  {
    return await _repositorySql.numVisit();
  }
  @override
  List<Object?> get props => [_repositorySql];
}




