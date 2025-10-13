
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class ReadVisitUsecase  extends Equatable {
  final Repository _repository;
  ReadVisitUsecase(this._repository);
  Future<Either<Failure, Message1Response>> execute(AsRead asRead) async{
    return await _repository.readVisit(asRead);
  }
  @override
  List<Object?> get props => [_repository];

}




