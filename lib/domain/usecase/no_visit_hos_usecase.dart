
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:equatable/equatable.dart';
class NoVisitHosUsecase extends Equatable {
  final  Repository _repository;
  const NoVisitHosUsecase(this._repository);
  Future<Either<Failure, List<NoVisitDocModel>>> execute(int repDet, int planId) async{
    return await _repository.noVisitHos(repDet,planId);
  }

  @override
  List<Object?> get props => [_repository];

}




