import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/visits_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class AllReadSenUsecase extends Equatable {
  final VisitsRepository _repository;
  AllReadSenUsecase(this._repository);
  Future<Either<Failure, MessageModel>> execute(ReadAll readAll) async {
    return await _repository.readAllVisits(readAll);
  }

  @override
  List<Object?> get props => [_repository];
}
