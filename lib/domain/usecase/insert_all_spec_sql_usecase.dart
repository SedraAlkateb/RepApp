
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertAllSpecsSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  InsertAllSpecsSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<SpecDModel>specModel) async{
    return await _repositorySql.insertSpec(specModel);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




