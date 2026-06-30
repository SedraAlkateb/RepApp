// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class GetPanRepsUsecase extends Equatable {
  Repository _repository;
  GetPanRepsUsecase(this._repository);
  Future<Either<Failure, List<PlanRepsModel>>> execute(int planId) async {
    return await _repository.getPlanReps(planId);
  }

  @override
  List<Object?> get props => [_repository];
}
