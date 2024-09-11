
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AllPharmacySqlUsecase extends Equatable {
 final RepositorySql _repositorySql;
  AllPharmacySqlUsecase(this._repositorySql);
  Future<Either<Failure, List<PharmacyModel>>> execute() async{
    return await _repositorySql.getPharmacySql();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_repositorySql];

}




