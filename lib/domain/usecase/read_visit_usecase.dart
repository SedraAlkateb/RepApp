import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/visits_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class ReadVisitUsecase extends Equatable {
  final VisitsRepository _repository;
  ReadVisitUsecase(this._repository);
  Future<Either<Failure, MessageModel>> execute(AsRead asRead) async {
    return await _repository.readVisit(asRead);
  }

  @override
  List<Object?> get props => [_repository];
}
