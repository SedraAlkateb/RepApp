
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class RepPlanBrandSpUsecase extends Equatable {
  final  Repository _repository;
  RepPlanBrandSpUsecase(this._repository);
  Future<Either<Failure, AllPlanBrandSp>> execute(RepSp rep) async{
    return await _repository.getRepPlanBrandSp(rep);
  }

  @override
  List<Object?> get props => [_repository];

}




