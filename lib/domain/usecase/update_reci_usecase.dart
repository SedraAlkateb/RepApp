import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/recipes_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class UpdateReciUsecase extends Equatable {
  final RecipesRepository _repository;
  UpdateReciUsecase(this._repository);
  Future<Either<Failure, InsertRecResponse>> execute(
      UpdateReciRequest reciRequest) async {
    return await _repository.updateReci(reciRequest);
  }

  @override
  List<Object?> get props => [_repository];
}
