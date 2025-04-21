
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class RemainingVisitsUsecase extends Equatable {
  final Repository _repository;
  RemainingVisitsUsecase(this._repository);
  Future<Either<Failure, List<NoVisitDocModel>>> execute(int repDet) async{
    return await _repository.getUnfinishedDoctorVisits(repDet);
  }

  @override
  List<Object?> get props => [_repository];

}




