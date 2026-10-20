import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/plans_repository.dart';
import 'package:equatable/equatable.dart';

class GetPlanBrandsInfoUsecase extends Equatable {
  final PlansRepository _repository;
  const GetPlanBrandsInfoUsecase(this._repository);
  Future<Either<Failure, AllPlanBrandsInfo>> execute(int repPlanId) async {
    return await _repository.getInfoPlanBrands(repPlanId);
  }

  @override
  List<Object?> get props => [_repository];
}
