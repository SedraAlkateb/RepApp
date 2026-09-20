import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repository/repository.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';

class AllBrandsResUsecase extends Equatable {
  final Repository _repository;
  AllBrandsResUsecase(this._repository);
  Future<Either<Failure, List<BrandRes>>> execute(int id) async {
    return await _repository.getBrandRes(id);
  }

  @override
  List<Object?> get props => [_repository];
}
