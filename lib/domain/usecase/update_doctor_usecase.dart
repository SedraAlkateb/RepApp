
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class UpdateDoctorUsecase extends Equatable {
  final RepositorySql _repositorySql;
  UpdateDoctorUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(int visitId,String? science,String ?kaswn  ,String? target) async{
    return await _repositorySql.updateVisitDoctorFields(id: visitId,science:science,kaswn:kaswn ,target:target );
  }

  @override

  List<Object?> get props => [_repositorySql];

}




