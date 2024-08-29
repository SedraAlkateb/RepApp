
// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';


class AllSpeUsecase extends Equatable {
  Repository _repository;
  AllSpeUsecase(this._repository);
  Future<Either<Failure, List<SpecModel>>> execute(int id) async{
    return await _repository.allSpec(id);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repository];

}




