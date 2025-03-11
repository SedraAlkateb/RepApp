import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class AllPlanBrandsUsecase extends Equatable {
  final Repository _repository;
  AllPlanBrandsUsecase(this._repository);
  Future<Either<Failure, List<PlanBrandModel>>> execute( Rep rep) async{
    return await _repository.getAllPlanBrands(rep);
  }

  @override
  List<Object?> get props => [_repository];

}




