
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class DeleteSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  DeleteSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute() async{
    return await _repositorySql.clearDatabase();
  }

  @override
  List<Object?> get props => [_repositorySql];

}




