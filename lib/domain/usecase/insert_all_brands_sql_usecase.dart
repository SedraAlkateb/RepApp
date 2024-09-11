
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertAllBrandsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  InsertAllBrandsSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<BrandModel>brandModel) async{
    return await _repositorySql.insertBrandsSql(brandModel);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repositorySql];

}




