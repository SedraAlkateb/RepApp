
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class AllInventoryUsecase extends Equatable {
  final Repository _repository;
  AllInventoryUsecase(this._repository);
  Future<Either<Failure, List<InventoryModel>>> execute(int repDet,int planId ) async{
    return await _repository.getInventory(repDet,planId);
  }

  @override
  List<Object?> get props => [_repository];

}

