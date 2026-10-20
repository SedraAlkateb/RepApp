import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest);
}
