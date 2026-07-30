import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:equatable/equatable.dart';

class UnfinishedVisitHosUsecase extends Equatable {
  final Repository _repository;
  const UnfinishedVisitHosUsecase(this._repository);
  Future<Either<Failure, List<NoVisitDocModel>>> execute(int repPlanId) async {
    return await _repository.getUnfinishedHosVisits(repPlanId);
  }

  @override
  List<Object?> get props => [_repository];
}
