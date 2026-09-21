import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class GetVisitHospitalUsecase extends Equatable {
  final Repository _repository;
  GetVisitHospitalUsecase(this._repository);
  Future<Either<Failure, VisitHospitalBase>> execute(
      int repPlanId, int representativeId) async {
    return await _repository.getHosVisit(repPlanId, representativeId);
  }

  @override
  List<Object?> get props => [_repository];
}
