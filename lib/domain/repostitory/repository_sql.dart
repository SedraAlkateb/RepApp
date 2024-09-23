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
  Future<Either<Failure,Null>>loginSql(LoginModel loginModel);
  Future<Either<Failure,LoginModel?>>getRep();
  Future<Either<Failure,String>>asyncData(
      List<BrandModel> brands,
      List<PharmacyModel> pharmacies,
      List<PlaceModel> places,
      List<SpecModel> specs,
      List<DoctorModel>doctors,
      List<HospitalModel>hospitals,
      List<HospitalSpModel>hospitalSps
      );
  Future<Either<Failure,List<BrandModel>>>getBrandsWithFlag();
  Future<Either<Failure,Null>>insertDoctor(List<DoctorModel> doctorModel);
  Future<Either<Failure,List<DoctorModel>>>getDoctorSql();


  Future<Either<Failure,Null>>insertHospital(List<HospitalModel> hospitalModel);
  Future<Either<Failure,List<HospitalModel>>>getHospitalSql();
  Future<Either<Failure,List<PharmacyModel>>>getPharmaciesByPlaceId(int placeId);
  Future<Either<Failure,List<DoctorModel>>>getDoctorByPlaceId( int placeId) ;
  Future<Either<Failure,List<HospitalModel>>> getHospitalByPlaceId( int placeId);
  Future<Either<Failure,Null>>insertVisitPharmacy(VisitPharmacyModel visitPharmacyModel) ;
  Future<Either<Failure,List<VisitPharmacyAndPharmacy>>> getVisitPharmacy();
  Future<Either<Failure,Null>>insertVisitDoctor(VisitDoctorModel visitDoctorModel) ;
  Future<Either<Failure,List<VisitDoctorAndDoctor>>> getVisitDoctor();
  Future<Either<Failure,Null>>insertHospitalSp(List<HospitalSpModel> hospitalSps);
  Future<Either<Failure,Null>>insertVisitBrandPharmacy(List<VisitBrandPharmacyModel> visitBrandPharmacyModels, VisitPharmacyModel visitPharmacyModel);
  Future<Either<Failure,Null>>insertVisitBrandDoctor(List<VisitBrandPharmacyModel> visitBrandDoctorModels, VisitDoctorModel visitDoctorModel);

  Future<Either<Failure,List<PharmacyBrandModel>>> getBrandsPharmacyByVisitId(int visitId);
  Future<Either<Failure,List<PharmacyBrandModel>>> getBrandsDoctorByVisitId(int visitId);

}