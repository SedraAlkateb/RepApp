import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/recipes_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class InsertReciUsecase extends Equatable {
  final RecipesRepository _repository;
  InsertReciUsecase(this._repository);
  Future<Either<Failure, InsertRecResponse>> execute(
      ReciRequest reciRequest) async {
    return await _repository.insertReci(reciRequest);
  }

  @override
  List<Object?> get props => [_repository];
}
