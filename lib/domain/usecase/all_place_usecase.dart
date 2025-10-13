
// ignore_for_file: must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';


class AllPlaceUsecase extends Equatable {
  Repository _repository;
  AllPlaceUsecase(this._repository);
  Future<Either<Failure, List<PlaceModel>>> execute(int id) async{
    return await _repository.allPlace(id);
  }

  @override
  List<Object?> get props => [_repository];

}




