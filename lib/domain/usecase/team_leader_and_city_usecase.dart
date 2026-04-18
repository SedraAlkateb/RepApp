
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class TeamLeaderAndCityUsecase extends Equatable {
  final Repository _repository;
  const TeamLeaderAndCityUsecase(this._repository);
  Future<Either<Failure, List<SeniorCityModel>>> execute() async{
    return await _repository.getCityAndTeamleader();
  }

  @override
  List<Object?> get props => [_repository];

}




