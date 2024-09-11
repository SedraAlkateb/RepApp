
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertAllPharmacysSqlUsecase extends Equatable {
 final RepositorySql _repositorySql;
  InsertAllPharmacysSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<PharmacyModel>pharmacyModel) async{
    return await _repositorySql.insertPharmacy(pharmacyModel);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




