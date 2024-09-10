
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AsyncDataSqlUsecase extends Equatable {
  RepositorySql _repositorySql;
  AsyncDataSqlUsecase(this._repositorySql);
  Future<Either<Failure, String>> execute(List<BrandModel> brands, List<PharmacyModel> pharmacies, List<PlaceModel> places, List<SpecModel> specs) async{
    return await _repositorySql.asyncData(brands, pharmacies, places, specs);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




