
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';


class LoginSqlUsecase extends Equatable {
 final RepositorySql _repository;
  LoginSqlUsecase(this._repository);
  Future<Either<Failure, Null>> execute(LoginModel loginModel) async{
    return await _repository.loginSql(loginModel);
  }

  @override
  List<Object?> get props => [_repository];

}




