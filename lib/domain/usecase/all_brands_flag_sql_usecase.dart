
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllBrandsFlagSqlUsecase extends Equatable {
  RepositorySql _repositorySql;
  AllBrandsFlagSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<BrandModel>>> execute() async{
    return await _repositorySql.getBrandsWithFlag();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repositorySql];

}




