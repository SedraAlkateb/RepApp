
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class UpdatePharmacyUsecase extends Equatable {
  final RepositorySql _repositorySql;
  UpdatePharmacyUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(int visitId,String newNote ) async{
    return await _repositorySql.updateVisitPharmacy(visitId: visitId,newNote:newNote );
  }

  @override

  List<Object?> get props => [_repositorySql];

}




