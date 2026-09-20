import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:equatable/equatable.dart';

class CopyReciUsecase extends Equatable {
  final Repository _repository;
  CopyReciUsecase(this._repository);
  Future<Either<Failure, CopyReciRequest>> execute(
      int docId, int recipeType) async {
    return await _repository.copyReci(docId, recipeType.toString());
  }

  @override
  List<Object?> get props => [_repository];
}
