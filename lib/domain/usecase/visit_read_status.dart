import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/visits_repository.dart';
import 'package:equatable/equatable.dart';

class VisitReadStatus extends Equatable {
  final VisitsRepository _repository;
  const VisitReadStatus(this._repository);
  Future<Either<Failure, List<WhoReadModel>>> execute(
    String visitId,
    String visitType,
    int repType,
  ) async {
    return await _repository.getVisitReadStatus(visitId, visitType, repType);
  }

  @override
  List<Object?> get props => [_repository];
}
