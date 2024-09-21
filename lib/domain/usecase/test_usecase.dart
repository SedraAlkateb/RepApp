
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class TestUsecase extends Equatable {
  final  Repository _repository;
  TestUsecase(this._repository);
  Future<Either<Failure, MessageResponse>> execute(List<VisitPharmacyModel> list) async{
    return await _repository.testt(list);
  }
  @override
  List<Object?> get props => [_repository];

}




