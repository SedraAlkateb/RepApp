import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class RepositorySql {
  Future<Either<Failure, Null>> insertBrandsSql(List<BrandModel> brandModel);
  Future<Either<Failure, List<BrandModel>>> getBrandsSql();

  Future<Either<Failure, Null>> insertPharmacy(
      List<PharmacyModel> pharmacyModel);
  Future<Either<Failure, List<PharmacyModel>>> getPharmacySql();

  Future<Either<Failure, Null>> insertPlace(List<PlaceModel> placeModel);
  Future<Either<Failure, List<PlaceModel>>> getPlaceSql();
  Future<Either<Failure, Null>> insertSpec(List<SpecDModel> specModel);
  Future<Either<Failure, List<SpecDModel>>> getSpecSql();
  Future<Either<Failure, Null>> clearDatabase();
  Future<Either<Failure, Null>> clearDatabaseAll();

  Future<Either<Failure, Null>> loginSql(LoginModel loginModel);
  Future<Either<Failure, LoginModel?>> getRep();
  Future<Either<Failure, String>> asyncData(
      List<BrandModel> brands,
    //  List<PharmacyModel> pharmacies,
      List<PlaceModel> places,
      List<SpecDModel> specs,
      List<DoctorModel> doctors,
      List<HospitalModel> hospitals,
      List<HospitalSpModel> hospitalSps,
      List<BrandSpModel> brandSps,
      VisitHospitalBase visitHospital ,VisitDoctorBase visitDoctor,{List<PlanBrandModel>? planBrands}
      );
  Future<Either<Failure, List<BrandModel>>> getBrandsWithFlag();
  Future<Either<Failure, Null>> insertDoctor(List<DoctorModel> doctorModel);
  Future<Either<Failure, List<DoctorModel>>> getDoctorSql();

  Future<Either<Failure, Null>> insertHospital(
      List<HospitalModel> hospitalModel);
  Future<Either<Failure, List<HospitalModel>>> getHospitalSql();
  Future<Either<Failure, List<PharmacyModel>>> getPharmaciesByPlaceId(
      int placeId);
  Future<Either<Failure, List<DoctorModel>>> getDoctorByPlaceId(int placeId);
  Future<Either<Failure, List<HospitalModel>>> getHospitalByPlaceId(
      int placeId);
  Future<Either<Failure, Null>> insertVisitPharmacy(
      VisitPharmacyModel visitPharmacyModel);
  Future<Either<Failure, List<VisitPharmacyAndPharmacy>>> getVisitPharmacy();
  Future<Either<Failure, Null>> insertVisitDoctor(
      VisitDoctorModel visitDoctorModel);
  Future<Either<Failure, List<VisitDoctorAndDoctor>>> getVisitDoctor();
  Future<Either<Failure, List<VisitHospitalAndHospital>>> getVisitHospital();

  Future<Either<Failure, Null>> insertHospitalSp(
      List<HospitalSpModel> hospitalSps);
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

  Future<Either<Failure, List<SpecHospitalSp>>> specializationByHospitalId(
      int hospitalId);
  Future<Either<Failure, Null>> insertVisitBrandHospital(
      VisitHospitalModel visitHospitalModel,
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
      int hos,
      int spec);
  Future<Either<Failure, Null>> insertVisitHospital(
      VisitHospitalModel visitHospitalModel, int hos, int spec);
  Future<Either<Failure, Null>> editIsLogin(int repId, int isLogin);
  Future<Either<Failure, Null>> updateVisitPharmacy({
    required int visitId,
    String? newNote,
  });
  Future<Either<Failure, Null>> updateVisitDoctorFields({
    required int id,
    String? kaswn,
    String? science,
    String? target,
  });
  Future<Either<Failure, Null>> updateVisitHospitalFields({
    required int id,
    String? kaswn,
    String? science,
    String? target,
  });

  Future<Either<Failure, List<HospitalModel>>> getHospitalBySpec(int spId);
  Future<Either<Failure, List<DoctorModel>>> getDoctorBySpec(int spId);

/////////////////////////////////////////////////Visit Sync
  Future<Either<Failure, List<VisitDoctorModel>>> visitDoctorAs();
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> visitBrandDoctorAs();
  Future<Either<Failure, List<VisitHospitalModel>>> visitHospitalAs();
  Future<Either<Failure, List<HospitalSpModel>>> visitHospitalSpAs();
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> visitBrandHospitalAs();
  Future<Either<Failure, List<VisitPharmacyModel>>> visitPharmacyAs();
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> visitBrandPharmacyAs();
  Future<Either<Failure, List<PlanBrandModel>>> planBrandsAs();
  Future<Either<Failure, Null>> updateRep(
      int repId, int otherPlanId, int activePlanId, int otherstatus,
      String startDate,String endDate,String otherStartDate,String otherEndDate
      );
  Future<Either<Failure, List<HospitalSpAllModel>>>
      getAllHospitalSpecialization();
  Future<Either<Failure, Null>> updateAmounts(
      List<OtherBrandSpPlanModel> planBrands);
  Future<Either<Failure, Null>> updateSpecifiedFlagsToOne(bool hos, bool doc);
  Future<Either<Failure, Null>> updateOtherStatus(
      int repId , int status ,List<OtherBrandSpPlanModel> planBrands);
  Future<Either<Failure, List<BrandSpPlanModel>>> planBrandByRepPlanId(
      int repPlanId);
  Future<Either<Failure, List<OtherBrandSpPlanModel>>>
      otherPlanBrandByRepPlanId(int repPlanId);
  Future<Either<Failure, Null>> editIsPlan(int repId, int flag) ;
}
