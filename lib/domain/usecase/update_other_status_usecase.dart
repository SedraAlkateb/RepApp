
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class UpdateOtherStatusUsecase extends Equatable {
  final RepositorySql _repositorySql;
  UpdateOtherStatusUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(int repId , int status ,List<OtherBrandSpPlanModel> planBrands ) async{
    return await _repositorySql.updateOtherStatus(repId,status,planBrands);
  }

  @override

  List<Object?> get props => [_repositorySql];

}




