import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class DocSpSearchUsecase extends Equatable {
  final Repository _repository;
  DocSpSearchUsecase(this._repository);
  Future<Either<Failure, List<HosDocSpSearchModel>>> execute(int repPlanId,int spId) async {
    return await _repository.docSpSearch(repPlanId, spId);
  }

  @override
  List<Object?> get props => [_repository];
}
