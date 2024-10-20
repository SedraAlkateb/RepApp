
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class UpdateFlagSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  UpdateFlagSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(bool hos, bool doc) async{
    return await _repositorySql.updateSpecifiedFlagsToOne(hos,doc);
  }
  @override
  List<Object?> get props => [_repositorySql];

}




