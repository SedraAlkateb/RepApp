import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/sql_plans_repository.dart';
import 'package:equatable/equatable.dart';

class EditRecipeUsecase extends Equatable {
  final SqlPlansRepository _repositorySql;
  EditRecipeUsecase(this._repositorySql);
  Future<Either<Failure, void>> execute(InsertRecResponse num) async {
    return await _repositorySql.editRecipe(num);
  }

  @override
  List<Object?> get props => [_repositorySql];
}
