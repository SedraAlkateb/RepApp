
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:equatable/equatable.dart';
class CheckActiveBrandPlanUsecase extends Equatable {
  final Repository _repository;
  CheckActiveBrandPlanUsecase(this._repository);
  Future<Either<Failure, LoginModel>> execute(int repId) async{
    return await _repository.checkActivePlanBrand(repId);
  }

  @override
  List<Object?> get props => [_repository];

}




