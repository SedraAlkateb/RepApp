import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class PharmaciesByPlaceUsecase extends Equatable {
  final  RepositorySql _repositorySql;
  PharmaciesByPlaceUsecase(this._repositorySql);
  Future<Either<Failure, List<PharmacyModel>>> execute(int id) async{
    return await _repositorySql.getPharmaciesByPlaceId(id);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




