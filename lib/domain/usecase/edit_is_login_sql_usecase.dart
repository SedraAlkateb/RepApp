
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class EditIsLoginSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  EditIsLoginSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(int repId, int isLogin) async{
    return await _repositorySql.editIsLogin(repId, isLogin);
  }


  @override

  List<Object?> get props => [_repositorySql];

}




