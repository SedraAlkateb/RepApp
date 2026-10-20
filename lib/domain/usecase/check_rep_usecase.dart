import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/reps_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:equatable/equatable.dart';

class CheckRepUsecase extends Equatable {
  final RepsRepository _repository;
  CheckRepUsecase(this._repository);
  Future<Either<Failure, CheckRepModel>> execute(int id) async {
    return await _repository.checkRep(id);
  }

  @override
  List<Object?> get props => [_repository];
}
