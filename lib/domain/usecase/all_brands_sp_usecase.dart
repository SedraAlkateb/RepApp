
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:equatable/equatable.dart';
class AllBrandsSpUsecase extends Equatable {
  final  Repository _repository;
  AllBrandsSpUsecase(this._repository);
  Future<Either<Failure, List<BrandSpModel>>> execute(int id) async{
    return await _repository.getBrandsSp(id);
  }

  @override
  List<Object?> get props => [_repository];

}




