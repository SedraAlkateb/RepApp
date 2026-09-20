import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/repository/repository_sql.dart';
import 'package:equatable/equatable.dart';

class UpdateSaveSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  UpdateSaveSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(int rep, int flag1) async {
    return await _repositorySql.updateSave(rep, flag1);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
