import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class SqlDirectoryRepository {
  Future<Either<Failure, Null>> insertBrandsSql(List<BrandModel> brandModel);
  Future<Either<Failure, List<BrandModel>>> getBrandsSql();
  Future<Either<Failure, Null>> insertPharmacy(
      List<PharmacyModel> pharmacyModel);
  Future<Either<Failure, List<PharmacyModel>>> getPharmacySql();
  Future<Either<Failure, Null>> insertPlace(List<PlaceModel> placeModel);
  Future<Either<Failure, List<PlaceModel>>> getPlaceSql();
  Future<Either<Failure, Null>> insertSpec(List<SpecDModel> specModel);
  Future<Either<Failure, List<SpecDModel>>> getSpecSql();
  Future<Either<Failure, List<BrandModel>>> getBrandsWithFlag();
  Future<Either<Failure, Null>> insertDoctor(List<DoctorModel> doctorModel);
  Future<Either<Failure, List<DoctorModel>>> getDoctorSql();
  Future<Either<Failure, Null>> insertHospital(
      List<HospitalModel> hospitalModel);
  Future<Either<Failure, List<HospitalModel>>> getHospitalSql();
  Future<Either<Failure, List<PharmacyModel>>> getPharmaciesByPlaceId(
      int placeId);
  Future<Either<Failure, List<DoctorModel>>> getDoctorByPlaceId(int placeId);
  Future<Either<Failure, List<HospitalSpAllModel>>> getHospitalByPlaceId(
      int placeId);
  Future<Either<Failure, Null>> insertHospitalSp(
      List<HospitalSpModel> hospitalSps);
  Future<Either<Failure, List<SpecHospitalSp>>> specializationByHospitalId(
      int hospitalId);
  Future<Either<Failure, List<HospitalModel>>> getHospitalBySpec(int spId);
  Future<Either<Failure, List<DoctorModel>>> getDoctorBySpec(int spId);
  Future<Either<Failure, List<HospitalSpAllModel>>>
      getAllHospitalSpecialization();
}
