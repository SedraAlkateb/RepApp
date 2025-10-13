import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:equatable/equatable.dart';
class GetInfoPlanBrandsUsecase extends Equatable {
  final  Repository _repository;
  const GetInfoPlanBrandsUsecase(this._repository);
  Future<Either<Failure, List<ActivePlanBrandModel>>> execute(int repPlan) async {
    return await _repository.getInfoPlanBrandsType(repPlan);
  }
  @override
  List<Object?> get props => [_repository];
}



