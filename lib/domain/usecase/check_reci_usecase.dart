import 'package:dartz/dartz.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:equatable/equatable.dart';

class CheckReciUsecase extends Equatable {
  final Repository _repository;
  CheckReciUsecase(this._repository);
  Future<Either<Failure, CheckReResponse>> execute(int repDet) async {
    return await _repository.checkRe(repDet);
  }

  @override
  List<Object?> get props => [_repository];
}
