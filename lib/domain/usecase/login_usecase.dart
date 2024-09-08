
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/requests/requsets.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class LoginUsecase extends Equatable {
  Repository _repository;
  LoginUsecase(this._repository);
  Future<Either<Failure, LoginModel>> execute(LoginRequest loginRequest) async{
    return await _repository.login(loginRequest);
  }
  @override
  List<Object?> get props => [_repository];
}




