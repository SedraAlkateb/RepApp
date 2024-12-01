import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:equatable/equatable.dart';

class CopyReciUsecase extends Equatable {
  final Repository _repository;
  CopyReciUsecase(this._repository);
  Future<Either<Failure, CopyReciRequest>> execute(int docId) async {
    return await _repository.copyReci(docId);
  }

  @override
  List<Object?> get props => [_repository];
}
