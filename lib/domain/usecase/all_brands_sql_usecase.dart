
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllBrandsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  AllBrandsSqlUsecase(this._repositorySql);
  Future<Either<Failure, List<BrandModel>>> execute() async{
    return await _repositorySql.getBrandsSql();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repositorySql];

}




