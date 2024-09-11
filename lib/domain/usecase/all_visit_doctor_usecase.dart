
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class AllVisitDoctorUsecase extends Equatable {
 final Repository _repository;
  AllVisitDoctorUsecase(this._repository);
  Future<Either<Failure, List<MedicalVisits>>> execute(int id) async{
    return await _repository.allVisitDoctor(id);
  }

  @override

  List<Object?> get props => [_repository];

}




