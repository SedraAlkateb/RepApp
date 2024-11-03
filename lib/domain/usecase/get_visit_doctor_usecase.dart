
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class GetVisitDoctorUsecase extends Equatable {
  final Repository _repository;
  GetVisitDoctorUsecase(this._repository);
  Future<Either<Failure, VisitDoctorBase>> execute(String repPlanId, String representativeId) async{
    return await _repository.getDocVisit(repPlanId, representativeId);
  }

  @override
  List<Object?> get props => [_repository];

}




