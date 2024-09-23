
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class InsertVisitBrandDoctorSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  InsertVisitBrandDoctorSqlUsecase(this._repositorySql);
  Future<Either<Failure, Null>> execute(List<VisitBrandPharmacyModel>visitBrandPharmacyModels,  VisitDoctorModel visitDoctorModel) async{
    return await _repositorySql.insertVisitBrandDoctor(visitBrandPharmacyModels,visitDoctorModel);
  }
  @override
  List<Object?> get props => [_repositorySql];
}



