import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:equatable/equatable.dart';

class GetRepReciUsecase extends Equatable {
  final Repository _repository;
  GetRepReciUsecase(this._repository);
  Future<Either<Failure, CopyReciRequest>> execute(int reciId) async {
    return await _repository.getRepReci(reciId);
  }

  @override
  List<Object?> get props => [_repository];
}
