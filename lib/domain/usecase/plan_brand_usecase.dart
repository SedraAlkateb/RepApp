import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/plans_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class PlanBrandUsecase extends Equatable {
  final PlansRepository _repository;
  PlanBrandUsecase(this._repository);
  Future<Either<Failure, MessageModel>> execute(
      RepPlanBrandBody list1) async {
    return await _repository.repPlanBrand(list1);
  }

  @override
  List<Object?> get props => [_repository];
}
