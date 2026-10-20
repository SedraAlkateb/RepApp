import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/plans_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateRepPlanBrandAmount extends Equatable {
  final PlansRepository _repository;
  const UpdateRepPlanBrandAmount(this._repository);
  Future<Either<Failure, MessageModel>> execute(
      BrandAmountRequestBody list) async {
    return await _repository.updateRepPlanBrandAmount(list);
  }

  @override
  List<Object?> get props => [_repository];
}
