
import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repostitory/repository_sql.dart';

class RepositroySqlImp extends RepositorySql {
  final AppSqlApi _databaseHelper;

  RepositroySqlImp(this._databaseHelper);

  @override
  Future<Either<Failure, List<BrandModel>>> getBrandsSql() async {
    try {
      final response = await _databaseHelper.getBrands();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmacySql() async {
    try {
      final response = await _databaseHelper.getPharmacy();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<PlaceModel>>> getPlaceSql() async {
    try {
      final response = await _databaseHelper.getPlace();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<SpecDModel>>> getSpecSql() async {
    try {
      final response = await _databaseHelper.getSpec();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }


  @override
  Future<Either<Failure, Null>> insertBrandsSql(
      List<BrandModel> brandModel) async {
    try {
      final response = await _databaseHelper.insertBrands(brandModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertPharmacy(
      List<PharmacyModel> pharmacyModel) async {
    try {
      final response = await _databaseHelper.insertPharmacy(pharmacyModel);
      return Right(response);
    } catch (e) {
      print(e);
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertPlace(List<PlaceModel> placeModel) async {
    try {
      final response = await _databaseHelper.insertPlace(placeModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertSpec(List<SpecDModel> specModel) async {
    try {
      final response = await _databaseHelper.insertSpec(specModel);
      return Right(response);
    } catch (e) {
      return Left(
          ErrorHandler
              .handle(e)
              .failure
      );
    }
  }

  @override
  Future<Either<Failure, Null>> clearDatabase() async {
    try {
      await _databaseHelper.clearDatabase();
      return Right(null);
    } catch (e) {
      return Left(
          ErrorHandler
              .handle(e)
              .failure
      );
    }
  }

  @override
  Future<Either<Failure, Null>> loginSql(LoginModel loginModel) async {
    try {
      final response = await _databaseHelper.insertLogin(loginModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, LoginModel?>> getRep() async {
    try {
      final response = await _databaseHelper.getRep();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmaciesByPlaceId(
      int placeId) async {
    try {
      final response = await _databaseHelper.getPharmaciesByPlaceId(placeId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, String>> asyncData
      (List<BrandModel> brands, List<PharmacyModel> pharmacies,
      List<PlaceModel> places, List<SpecDModel> specs,
      List<DoctorModel>doctors,
      List<HospitalModel>hospitals,
      List<HospitalSpModel>hospitalSps,
      List<BrandSpModel> brandSps,
      List<PlanBrandModel> planBrands,
      VisitHospitalBase visitHospital ,VisitDoctorBase visitDoctor
      ) async {
    try {
      final response = await _databaseHelper.asyncData(
          brands,
          pharmacies,
          places,
          specs,
          doctors,
          hospitals,
          hospitalSps,
          brandSps,
          planBrands,
          visitHospital,visitDoctor
      );
      if (response == "") {
        return Right(response);
      } else {
        return Left(Failure(6, response));
      }
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<BrandModel>>> getBrandsWithFlag() async {
    try {
      final response = await _databaseHelper.getBrandsWithFlag();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertDoctor(
      List<DoctorModel> doctorModel) async {
    try {
      final response = await _databaseHelper.insertdoctor(doctorModel);
      return Right(response);
    } catch (e) {
      print(e);
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<HospitalModel>>> getHospitalSql() async {
    try {
      final response = await _databaseHelper.getHospital();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertHospital(
      List<HospitalModel> hospitalModel) async {
    try {
      final response = await _databaseHelper.inserthospital(hospitalModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorSql() async {
    try {
      // عملية قاعدة بيانات قد تفشل
      final response = await _databaseHelper.getDotors();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorByPlaceId(
      int placeId) async {
    try {
      final response = await _databaseHelper.getDoctorByPlaceId(placeId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<HospitalModel>>> getHospitalByPlaceId(
      int placeId) async {
    try {
      final response = await _databaseHelper.getHospitalByPlaceId(placeId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertVisitPharmacy(
      VisitPharmacyModel visitPharmacyModel) async {
    try {
      await _databaseHelper.insertVisitPharmacy(visitPharmacyModel);
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure,
      List<VisitPharmacyAndPharmacy>>> getVisitPharmacy() async {
    try {
      final response = await _databaseHelper.getVisitPharmacy();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<VisitDoctorAndDoctor>>> getVisitDoctor() async {
    try {
      final response = await _databaseHelper.getVisitDoctor();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertVisitDoctor(
      VisitDoctorModel visitDoctorModel) async {
    try {
      final response = await _databaseHelper.insertVisitDoctor(
          visitDoctorModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertHospitalSp(
      List<HospitalSpModel> hospitalSps) async {
    try {
      final response = await _databaseHelper.insertHospitalSp(hospitalSps);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertVisitBrandPharmacy(
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
      VisitPharmacyModel visitPharmacyModel,) async {
    try {
      await _databaseHelper.
      insertVisitBrandPharmacy(
          visitPharmacyModel,
          visitBrandPharmacyModels
      );
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<PharmacyBrandModel>>> getBrandsPharmacyByVisitId(
      int visitId) async {
    try {
      final response = await _databaseHelper.getBrandsPharmacyByVisitId(
          visitId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<PharmacyBrandModel>>> getBrandsDoctorByVisitId(
      int visitId) async {
    try {
      final response = await _databaseHelper.getBrandsDoctorByVisitId(visitId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertVisitBrandDoctor(
      List<VisitBrandPharmacyModel> visitBrandDoctorModels,
      VisitDoctorModel visitDoctorModel) async {
    try {
      await _databaseHelper.
      insertVisitBrandDoctor(
          visitDoctorModel,
          visitBrandDoctorModels
      );
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<SpecHospitalSp>>> specializationByHospitalId(
      int hospitalId) async {
    try {
      final response = await _databaseHelper.specializationByHospitalId(
          hospitalId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertVisitBrandHospital(
      VisitHospitalModel visitHospitalModel,
      List<VisitBrandPharmacyModel> visitBrandPharmacyModels, int hos,
      int spec) async {
    try {
      await _databaseHelper.
      insertVisitBrandHospital(
          visitHospitalModel,
          visitBrandPharmacyModels,
          hos, spec
      );
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> insertVisitHospital(
      VisitHospitalModel visitHospitalModel, int hos,
      int spec) async {
    try {
      await _databaseHelper.insertVisitHospital(visitHospitalModel, hos, spec);
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> editIsLogin(int repId, int isLogin) async {
    try {
      await _databaseHelper.editIsLogin(repId, isLogin);
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<PharmacyBrandModel>>> getBrandsHospitalByVisitId(
      int visitId) async {
    try {
      final response = await _databaseHelper.getBrandsHospitalByVisitId(
          visitId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure,
      List<VisitHospitalAndHospital>>> getVisitHospital() async {
    try {
      final response = await _databaseHelper.getVisitHospital();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> updateVisitDoctorFields(
      {required int id, String? kaswn, String? science,String?target}) async {
    try {
      await _databaseHelper.updateVisitDoctorFields(
          id: id, kaswn: kaswn, science: science,target:target);
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> updateVisitHospitalFields(
      {required int id, String? kaswn, String? science, String? target,}) async {
    try {
      await _databaseHelper.updateVisitHospitalFields(
          id: id, kaswn: kaswn, science: science,target:target);
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> updateVisitPharmacy(
      {required int visitId, String? newNote}) async {
    try {
      await _databaseHelper.updateVisitPharmacy(
          visitId: visitId, newNote: newNote);
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorBySpec(int spId) async {
    try {
      final response = await _databaseHelper.getDoctorBySpec(spId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<HospitalModel>>> getHospitalBySpec(
      int spId) async {
    try {
      final response = await _databaseHelper.getHospitalBySpec(spId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<PlanBrandModel>>> planBrandsAs() async {
    try {
      final response = await _databaseHelper.planBrandsAs();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure,
      List<VisitBrandPharmacyModel>>> visitBrandDoctorAs() async {
    try {
      final response = await _databaseHelper.visitBrandDoctorAs();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure,
      List<VisitBrandPharmacyModel>>> visitBrandHospitalAs() async {
    try {
      final response = await _databaseHelper.visitBrandHospitalAs();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure,
      List<VisitBrandPharmacyModel>>> visitBrandPharmacyAs() async {
    try {
      final response = await _databaseHelper.visitBrandPharmacyAs();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<VisitDoctorModel>>> visitDoctorAs() async {
    try {
      final response = await _databaseHelper.visitDoctorAs();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<VisitHospitalModel>>> visitHospitalAs() async {
    try {
      final response = await _databaseHelper.visitHospitalAs();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<HospitalSpModel>>> visitHospitalSpAs() async {
    try {
      final response = await _databaseHelper.visitHospitalSpAs();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, List<VisitPharmacyModel>>> visitPharmacyAs() async {
    try {
      final response = await _databaseHelper.visitPharmacyAs();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> clearDatabaseAll() async {
    try {
      await _databaseHelper.clearDatabaseAll();
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }



  @override
  Future<Either<Failure, Null>> updateRep(int repId, int otherPlanId, int activePlanId, int otherStatus
  ,String startDate,String endDate,String otherStartDate,String otherEndDate
      )  async {
    try {
       await _databaseHelper.updateRep(repId, otherPlanId, activePlanId, otherStatus, startDate, endDate, otherStartDate, otherEndDate);
      return Right(null);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<HospitalSpAllModel>>> getAllHospitalSpecialization()async {
    try {
      final response=  await _databaseHelper.getAllHospitalSpecialization();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> updateAmounts(List<OtherBrandSpPlanModel> planBrands) async {
    try {
      final response=  await _databaseHelper.updateAmounts(planBrands);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> updateSpecifiedFlagsToOne(bool hos, bool doc) async {
    try {
      final response=  await _databaseHelper.updateSpecifiedFlagsToOne(hos,doc);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, Null>> updateOtherStatus(int status, int repId,List<OtherBrandSpPlanModel> planBrands) async {
    try {
      final response=  await _databaseHelper.updateOtherStatus(status,repId,planBrands);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<BrandSpPlanModel>>> planBrandByRepPlanId(
      int repPlanId) async {
    try {
      final response=  await
      _databaseHelper.planBrandByRepPlanId(repPlanId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
  @override
  Future<Either<Failure, List<OtherBrandSpPlanModel>>> otherPlanBrandByRepPlanId(
      int repPlanId) async {
    try {
      final response=  await
      _databaseHelper.otherPlanBrandByRepPlanId(repPlanId);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }
}
