
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';
import 'package:equatable/equatable.dart';
class AsyncDataSqlUsecase extends Equatable {
  final RepositorySql _repositorySql;
  AsyncDataSqlUsecase(this._repositorySql);
  Future<Either<Failure, String>> execute(List<BrandModel> brands, List<PharmacyModel> pharmacies, List<PlaceModel> places, List<SpecDModel> specs,List<DoctorModel>doctors,
      List<HospitalModel>hospitals,  List<HospitalSpModel>hospitalSps,   List<BrandSpModel> brandSps,  List<PlanBrandModel> planBrands) async{
    return await _repositorySql.asyncData(brands, pharmacies, places, specs,doctors,hospitals,hospitalSps,brandSps,planBrands);
  }

  @override
  List<Object?> get props => [_repositorySql];

}




