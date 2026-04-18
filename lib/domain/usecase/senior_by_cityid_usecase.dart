
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class SeniorByCityIdUsecase extends Equatable {
  final Repository _repository;
  const SeniorByCityIdUsecase(this._repository);
  Future<Either<Failure, List<SeniorCityModel>>> execute(int cityid) async{
    return await _repository.getSeniorByCityid(cityid);
  }

  @override
  List<Object?> get props => [_repository];

}




