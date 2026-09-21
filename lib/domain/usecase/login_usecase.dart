import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class LoginUsecase extends Equatable {
  final Repository _repository;
  LoginUsecase(this._repository);
  Future<Either<Failure, LoginModel>> execute(LoginRequest loginRequest) async {
    return await _repository.login(loginRequest);
  }

  @override
  List<Object?> get props => [_repository];
}
