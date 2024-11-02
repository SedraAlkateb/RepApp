
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class GetVisitHospitalUsecase extends Equatable {
  final Repository _repository;
  GetVisitHospitalUsecase(this._repository);
  Future<Either<Failure, List<VisitHospitalModel>>> execute(int repPlanId, int representativeId) async{
    return await _repository.getHosVisit(repPlanId, representativeId);
  }

  @override
  List<Object?> get props => [_repository];

}




