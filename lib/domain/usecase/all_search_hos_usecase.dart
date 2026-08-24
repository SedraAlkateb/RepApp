import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:equatable/equatable.dart';

class AllSearchHosUsecase extends Equatable {
  final Repository _repository;
  const AllSearchHosUsecase(this._repository);
  Future<Either<Failure, List<SearchHospitalModel>>> execute(
      String name,int repDet,{int? cityId}) async {
    return await _repository.getSearchHospitals(name,repDet,cityId:cityId );
  }

  @override
  List<Object?> get props => [_repository];
}
