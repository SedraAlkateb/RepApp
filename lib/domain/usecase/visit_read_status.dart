
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:equatable/equatable.dart';
class VisitReadStatus extends Equatable {
  final  Repository _repository;
  const VisitReadStatus(this._repository);
  Future<Either<Failure, List<WhoReadModel>>> execute(String visitId, String visitType) async{
    return await _repository.getVisitReadStatus(visitId,visitType);
  }

  @override
  List<Object?> get props => [_repository];

}




