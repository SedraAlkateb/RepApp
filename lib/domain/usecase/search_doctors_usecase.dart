import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:equatable/equatable.dart';
class SearchDoctorsUsecase extends Equatable {
  final  Repository _repository;
  SearchDoctorsUsecase(this._repository);
    Future<Either<Failure, List<doctorsModel>>> execute(  int cityId,
    String name,) async{
    return await _repository.docSearch(cityId,name);
  }
  @override

  List<Object?> get props => [_repository];

}




