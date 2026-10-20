import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/log_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class AllExceptionUsecase extends Equatable {
  final LogRepository _repository;
  AllExceptionUsecase(this._repository);
  Future<Either<Failure, MessageModel>> execute(
      ExceptionRequestBody exceptionRequest) async {
    return await _repository.insertLog(exceptionRequest);
  }

  @override
  List<Object?> get props => [_repository];
}
