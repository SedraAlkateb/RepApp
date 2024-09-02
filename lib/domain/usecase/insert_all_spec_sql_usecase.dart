
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertAllSpecsSqlUsecase extends Equatable {
  RepositorySql _repositorySql;
  InsertAllSpecsSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<SpecModel>specModel) async{
    return await _repositorySql.insertSpec(specModel);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repositorySql];

}




