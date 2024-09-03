
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/data/network/requests/requsets.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class Repository{
  Future<Either<Failure,Token>>login(LoginRequest loginRequest);
  Future<Either<Failure,MessageResponse>>logout();
  Future<Either<Failure,List<PlaceModel>>>allPlace(int id);
  Future<Either<Failure,List<SpecModel>>>allSpec(int id);
  Future<Either<Failure,List<MedicalVisits>>>allVisitDoctor(int id);
  Future<Either<Failure,List<CityModel>>>allCity();
  Future<Either<Failure,List<BrandModel>>>allBrand();
  Future<Either<Failure,List<CityModel>>>allMedicalRepresentative(int id);
  Future<Either<Failure,List<PharmacyModel>>>getAllPharmacy(int repDet);
Future<Either<Failure,List<DoctorModel>>>getAllDoctor(int repDet);
Future<Either<Failure,List<DoctorModel>>>getAllHospital(int repDet);
}