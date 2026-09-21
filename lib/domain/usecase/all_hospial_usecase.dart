import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class AllHospitalUsecase extends Equatable {
  final Repository _repository;
  AllHospitalUsecase(this._repository);
  Future<Either<Failure, List<HospitalModel>>> execute(int id) async {
    return await _repository.getAllHospital(id);
  }

  @override
  List<Object?> get props => [_repository];
}
