import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class RepsRepository {
  Future<Either<Failure, CheckRepModel>> checkRep(int depId);

  Future<Either<Failure, List<AllRepresentative>>> getReps(int id, int cityId);

  Future<Either<Failure, List<InventoryModel>>> getInventory(
      int repDet, int planId);

  Future<Either<Failure, InfoRep>> getInfoRep(int repDet, int planId);

  Future<Either<Failure, List<SeniorCityModel>>> getSeniorByCityid(int cityId);

  Future<Either<Failure, List<SeniorCityModel>>> getCityAndTeamleader();
}
