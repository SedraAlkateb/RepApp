import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/plans_repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class ChangePlanBrandTypeUsecase extends Equatable {
  final PlansRepository _repository;
  ChangePlanBrandTypeUsecase(this._repository);
  Future<Either<Failure, MessageModel>> execute(
      ChangePlanBrandType changePlanBrandType) async {
    return await _repository.changePlanBrandType(changePlanBrandType);
  }

  @override
  List<Object?> get props => [_repository];
}
