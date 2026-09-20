import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class InfoRepUsecase extends Equatable {
  final Repository _repository;
  InfoRepUsecase(this._repository);
  Future<Either<Failure, InfoRep>> execute(int id, int planId) async {
    return await _repository.getInfoRep(id, planId);
  }

  @override
  List<Object?> get props => [_repository];
}
