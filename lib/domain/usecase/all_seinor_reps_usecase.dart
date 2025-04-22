import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';


class AllSeinor_Rep_Usecase extends Equatable {
 final Repository _repository;
  AllSeinor_Rep_Usecase(this._repository);
  Future<Either<Failure, List<AllRepresentative>>> execute(int id,int cityId) async{
    return await _repository.getReps(id,cityId);
  }

  @override

  List<Object?> get props => [_repository];

}



