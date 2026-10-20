import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/visits_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class AllSenVisitDoctorUsecase extends Equatable {
  final VisitsRepository _repository;
  AllSenVisitDoctorUsecase(this._repository);
  Future<Either<Failure, List<NoVisitDocModel>>> execute(
      int repDet, int planId) async {
    return await _repository.visitDoc(repDet, planId);
  }

  @override
  List<Object?> get props => [_repository];
}
