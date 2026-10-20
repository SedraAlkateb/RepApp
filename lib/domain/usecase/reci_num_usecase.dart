import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/recipes_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:equatable/equatable.dart';

class ReciNumUsecase extends Equatable {
  final RecipesRepository _repository;
  ReciNumUsecase(this._repository);
  Future<Either<Failure, List<int>>> execute() async {
    return await _repository.reciNum();
  }

  @override
  List<Object?> get props => [_repository];
}
