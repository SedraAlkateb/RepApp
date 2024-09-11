import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class HospitalsByPlaceUsecase extends Equatable {
  final  RepositorySql _repositorySql;
  HospitalsByPlaceUsecase(this._repositorySql);
  Future<Either<Failure, List<DoctorModel>>> execute(int id) async{
    return await _repositorySql.getHospitalByPlaceId(id);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




