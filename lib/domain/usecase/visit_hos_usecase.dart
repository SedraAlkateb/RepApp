import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:equatable/equatable.dart';

class VisitHosUsecase extends Equatable {
  final Repository _repository;
  const VisitHosUsecase(this._repository);
  Future<Either<Failure, List<NoVisitDocModel>>> execute(int repPlanId) async {
    return await _repository.visitHos(repPlanId);
  }

  @override
  List<Object?> get props => [_repository];
}
