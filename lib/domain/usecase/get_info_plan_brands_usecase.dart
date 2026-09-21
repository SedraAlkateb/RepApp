import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:equatable/equatable.dart';

class GetInfoPlanBrandsUsecase extends Equatable {
  final Repository _repository;
  const GetInfoPlanBrandsUsecase(this._repository);
  Future<Either<Failure, List<ActivePlanBrandModel>>> execute(
      int repPlan,{int status=0}) async {
    return await _repository.getInfoPlanBrandsType(repPlan,status: status);
  }

  @override
  List<Object?> get props => [_repository];
}
