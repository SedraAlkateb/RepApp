
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertAllPlacesSqlUsecase extends Equatable {
  RepositorySql _repositorySql;
  InsertAllPlacesSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<PlaceModel>placeModel) async{
    return await _repositorySql.insertPlace(placeModel);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repositorySql];

}




