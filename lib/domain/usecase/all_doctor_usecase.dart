import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class AllDoctorUsecase extends Equatable {
  final Repository _repository;
  AllDoctorUsecase(this._repository);
  Future<Either<Failure, List<DoctorModel>>> execute(int id) async {
    return await _repository.getAllDoctor(id);
  }

  @override
  List<Object?> get props => [_repository];
}
