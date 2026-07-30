import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';

class EditRecipeUsecase extends Equatable {
  final RepositorySql _repositorySql;
  EditRecipeUsecase(this._repositorySql);
  Future<Either<Failure, void>> execute(InsertRecResponse num) async {
    return await _repositorySql.editRecipe(num);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
