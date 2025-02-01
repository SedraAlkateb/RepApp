
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class AllExceptionUsecase extends Equatable {
  final Repository _repository;
  AllExceptionUsecase(this._repository);
  Future<Either<Failure, Message1Response>> execute(ExceptionRequestBody exceptionRequest) async{
    return await _repository.insertLog(exceptionRequest);
  }

  @override

  List<Object?> get props => [_repository];

}




