import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/visits_repository.dart';
import 'package:equatable/equatable.dart';

class NoVisitHosUsecase extends Equatable {
  final VisitsRepository _repository;
  const NoVisitHosUsecase(this._repository);
  Future<Either<Failure, List<NoVisitDocModel>>> execute(
      int repDet, int planId) async {
    return await _repository.noVisitHos(repDet, planId);
  }

  @override
  List<Object?> get props => [_repository];
}
