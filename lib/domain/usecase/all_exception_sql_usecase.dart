import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_session_repository.dart';
import 'package:equatable/equatable.dart';

class AllExceptionSqlUsecase extends Equatable {
  final SqlSessionRepository _repository;
  AllExceptionSqlUsecase(this._repository);
  Future<Either<Failure, List<ExceptionModel>>> execute() async {
    return await _repository.allException();
  }

  @override
  List<Object?> get props => [_repository];
}
