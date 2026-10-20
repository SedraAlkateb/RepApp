import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/plans_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class AllPlanBrandsTypeUsecase extends Equatable {
  final PlansRepository _repository;
  AllPlanBrandsTypeUsecase(this._repository);
  Future<Either<Failure, List<PlanBrandModel>>> execute(Rep rep) async {
    return await _repository.getAllPlanBrandsType(rep);
  }

  @override
  List<Object?> get props => [_repository];
}
