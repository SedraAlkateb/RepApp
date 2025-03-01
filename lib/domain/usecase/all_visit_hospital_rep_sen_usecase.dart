
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class AllVisitHospitalRepSenUsecase extends Equatable {
  final  Repository _repository;
  AllVisitHospitalRepSenUsecase(this._repository);
  Future<Either<Failure, List<RepVisitsModel>>> execute(VisitRepSen visitRepSen) async{
    return await _repository. getRepVisitsHos(visitRepSen);
  }
  @override
  List<Object?> get props => [_repository];

}




