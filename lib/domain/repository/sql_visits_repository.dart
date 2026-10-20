import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class SqlVisitsRepository {
  Future<Either<Failure, Null>> insertVisitPharmacy(
      VisitPharmacyModel visitPharmacyModel);
  Future<Either<Failure, List<VisitPharmacyAndPharmacy>>> getVisitPharmacy();
  Future<Either<Failure, Null>> insertVisitDoctor(
      VisitDoctorModel visitDoctorModel);
  Future<Either<Failure, List<VisitDoctorAndDoctor>>> getVisitDoctor();
  Future<Either<Failure, List<VisitHospitalAndHospital>>> getVisitHospital();
  Future<Either<Failure, Null>> insertVisitBrandPharmacy(
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
      VisitPharmacyModel visitPharmacyModel);
  Future<Either<Failure, Null>> insertVisitBrandDoctor(
      List<VisitBrandPharmacyModel> visitBrandDoctorModels,
      VisitDoctorModel visitDoctorModel);
  Future<Either<Failure, List<PharmacyBrandModel>>> getBrandsPharmacyByVisitId(
      int visitId);
  Future<Either<Failure, List<PharmacyBrandModel>>> getBrandsDoctorByVisitId(
      int visitId);
  Future<Either<Failure, List<PharmacyBrandModel>>> getBrandsHospitalByVisitId(
      int visitId);
  Future<Either<Failure, Null>> insertVisitBrandHospital(
      VisitHospitalModel visitHospitalModel,
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
      int hos,
      int spec);
  Future<Either<Failure, Null>> insertVisitHospital(
      VisitHospitalModel visitHospitalModel, int hos, int spec);
  Future<Either<Failure, Null>> updateVisitPharmacy({
    required int visitId,
    String? newNote,
  });
  Future<Either<Failure, Null>> updateVisitDoctorFields(
      {required int id,
      String? kaswn,
      String? science,
      String? target,
      List<PharmacyBrandModel>? selectBrand});
  Future<Either<Failure, Null>> updateVisitHospitalFields(
      {required int id,
      String? kaswn,
      String? science,
      String? target,
      List<PharmacyBrandModel>? selectBrand});
/////////////////////////////////////////////////Visit Sync
  Future<Either<Failure, List<VisitDoctorModel>>> visitDoctorAs();
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> visitBrandDoctorAs();
  Future<Either<Failure, List<VisitHospitalModel>>> visitHospitalAs();
  Future<Either<Failure, List<HospitalSpModel>>> visitHospitalSpAs();
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> visitBrandHospitalAs();
  Future<Either<Failure, List<VisitPharmacyModel>>> visitPharmacyAs();
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> visitBrandPharmacyAs();
  Future<Either<Failure, bool>> updateFlagsToDoctor(
      {List<int>? visitIds, List<int>? brandIds});
  Future<Either<Failure, bool>> updateFlagsToHospital(
      {List<int>? visitIds, List<int>? brandIds});
  Future<Either<Failure, NumVisit>> numVisit();
  Future<Either<Failure, void>> numDocAndHos();
}
