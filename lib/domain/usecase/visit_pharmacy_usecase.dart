import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/visits_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class VisitPharmacyUsecase extends Equatable {
  final VisitsRepository _repository;
  VisitPharmacyUsecase(this._repository);
  Future<Either<Failure, MessageModel>> execute(
      VisitPharmacyRequestBody list1) async {
    return await _repository.visitPharmacy(list1);
  }

  @override
  List<Object?> get props => [_repository];
}
