
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class NumDocHasSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  NumDocHasSqlUsecase(this._repositorySql);
  Future<Either<Failure, void>> execute()
  async
  {
    return await _repositorySql.numDocAndHos();
  }
  @override
  List<Object?> get props => [_repositorySql];
}




