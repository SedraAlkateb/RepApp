
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class AllBrandsUsecase extends Equatable {
  Repository _repository;
  AllBrandsUsecase(this._repository);
  Future<Either<Failure, List<BrandModel>>> execute() async{
    return await _repository.allBrand();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repository];

}




