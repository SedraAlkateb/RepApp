
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/data/network/requests/requsets.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class Repository{
  Future<Either<Failure,LoginModel>>login(LoginRequest loginRequest);
  Future<Either<Failure,List<PlaceModel>>>allPlace(int id);
  Future<Either<Failure,List<SpecModel>>>allSpec(int id);
  Future<Either<Failure,List<MedicalVisits>>>allVisitDoctor(int id);
  Future<Either<Failure,List<CityModel>>>allCity();
  Future<Either<Failure,List<BrandModel>>>allBrand(int id);
  Future<Either<Failure,List<CityModel>>>allMedicalRepresentative(int id);
  Future<Either<Failure,List<PharmacyModel>>>getAllPharmacy(int repDet);
  Future<Either<Failure,List<DoctorModel>>>getAllDoctor(int repDet);
  Future<Either<Failure,List<HospitalModel>>>getAllHospital(int repDet);
  Future<Either<Failure,List<HospitalSpModel>>>getAllHospitalSp(int repDet);
  Future<Either<Failure,Message1Response>>visitPharmacy(VisitPharmacyRequestBody list1);

  Future<Either<Failure,Message1Response>>visitDoctor(VisitDoctorRequestBody list1);
  Future<Either<Failure,Message1Response>>visitHospital(VisitHospitalRequestBody list1);
  Future<Either<Failure,List<BrandSpModel>>> getBrandsSp(int repDet);

}