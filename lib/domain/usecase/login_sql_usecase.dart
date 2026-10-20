import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_session_repository.dart';
import 'package:equatable/equatable.dart';

class LoginSqlUsecase extends Equatable {
  final SqlSessionRepository _repository;
  LoginSqlUsecase(this._repository);
  Future<Either<Failure, Null>> execute(LoginModel loginModel) async {
    return await _repository.loginSql(loginModel);
  }

  @override
  List<Object?> get props => [_repository];
}
