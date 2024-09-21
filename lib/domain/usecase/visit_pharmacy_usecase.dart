
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class VisitPharmacyUsecase extends Equatable {
  final  Repository _repository;
  VisitPharmacyUsecase(this._repository);
  Future<Either<Failure, Message1Response>> execute(VisitPharmacyRequestBody list1) async{
    return await _repository.visitPharmacy(list1);
  }
  @override
  List<Object?> get props => [_repository];

}




