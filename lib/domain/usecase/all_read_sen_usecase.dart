
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class AllReadSenUsecase extends Equatable {
  final Repository _repository;
  AllReadSenUsecase(this._repository);
  Future<Either<Failure, Message1Response>> execute(ReadAll readAll) async{
    return await _repository.readAllVisits(readAll);
  }
  @override
  List<Object?> get props => [_repository];

}




