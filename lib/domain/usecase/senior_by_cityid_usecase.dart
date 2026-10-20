import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/reps_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class SeniorByCityIdUsecase extends Equatable {
  final RepsRepository _repository;
  const SeniorByCityIdUsecase(this._repository);
  Future<Either<Failure, List<SeniorCityModel>>> execute(int cityid) async {
    return await _repository.getSeniorByCityid(cityid);
  }

  @override
  List<Object?> get props => [_repository];
}
