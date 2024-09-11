import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class IsLoginSqlUsecase extends Equatable {
  RepositorySql _repositorySql;
  IsLoginSqlUsecase(this._repositorySql);
  Future<Either<Failure, LoginModel?>> execute() async{
    return await _repositorySql.getRep();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repositorySql];

}




