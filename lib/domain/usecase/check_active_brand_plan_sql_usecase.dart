
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:equatable/equatable.dart';
class CheckActiveBrandPlanSqlUsecase extends Equatable {
  final Repository _repository;
  CheckActiveBrandPlanSqlUsecase(this._repository);
  Future<Either<Failure, LoginModel>> execute(int repId) async{
    return await _repository.checkActivePlanBrand(repId);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repository];

}




