import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/plans_repository.dart';
import 'package:equatable/equatable.dart';

class ChangeRepPlanStatus extends Equatable {
  final PlansRepository _repository;
  const ChangeRepPlanStatus(this._repository);
  Future<Either<Failure, MessageModel>> execute(int id, int status) async {
    return await _repository.changeRepPlanStatus(id, status);
  }

  @override
  List<Object?> get props => [_repository];
}
