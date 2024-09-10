
import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/repostitory/repository.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class PharmaciesByPlaceUsecase extends Equatable {
  RepositorySql _repositorySql;
  PharmaciesByPlaceUsecase(this._repositorySql);
  Future<Either<Failure, List<PharmacyModel>>> execute(int id) async{
    return await _repositorySql.getPharmaciesByPlaceId(id);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repositorySql];

}




