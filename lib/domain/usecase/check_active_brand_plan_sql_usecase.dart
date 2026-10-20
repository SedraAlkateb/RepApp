import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/plans_repository.dart';
import 'package:equatable/equatable.dart';

class CheckActiveBrandPlanUsecase extends Equatable {
  final PlansRepository _repository;
  CheckActiveBrandPlanUsecase(this._repository);
  Future<Either<Failure, LoginModel>> execute(int repId) async {
    return await _repository.checkActivePlanBrand(repId);
  }

  @override
  List<Object?> get props => [_repository];
}
