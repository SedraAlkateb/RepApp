
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertAllPlacesSqlUsecase extends Equatable {
  final  RepositorySql _repositorySql;
  InsertAllPlacesSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<PlaceModel>placeModel) async{
    return await _repositorySql.insertPlace(placeModel);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




