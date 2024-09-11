
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllPlacesSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  AllPlacesSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<PlaceModel>>> execute() async{
    return await _repositorySql.getPlaceSql();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repositorySql];

}




