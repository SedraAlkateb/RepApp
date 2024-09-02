import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class RepositorySql {
  Future<Either<Failure,Null>>insertBrandsSql(List<BrandModel> brandModel);
  Future<Either<Failure,List<BrandModel>>>getBrandsSql();

  Future<Either<Failure,Null>>insertPharmacy(List<PharmacyModel> pharmacyModel);
  Future<Either<Failure,List<PharmacyModel>>>getPharmacySql();


  Future<Either<Failure,Null>>insertPlace(List<PlaceModel> placeModel);
  Future<Either<Failure,List<PlaceModel>>>getPlaceSql();

  Future<Either<Failure,Null>>insertSpec(List<SpecModel> specModel);
  Future<Either<Failure,List<SpecModel>>>getSpecSql();
  Future<Either<Failure,Null>>clearDatabase();

}