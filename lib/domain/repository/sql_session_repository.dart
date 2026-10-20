import 'package:dartz/dartz.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class SqlSessionRepository {
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
      VisitHospitalBase visitHospital,
      VisitDoctorBase visitDoctor,
      {List<PlanBrandModel>? planBrands,
      bool replaceExisting = false,
      bool keepPlanBrand = false});
  Future<Either<Failure, Null>> editIsLogin(int repId, int isLogin);
  Future<Either<Failure, Null>> updateRep(
      int repId,
      int otherPlanId,
      int activePlanId,
      int otherstatus,
      String startDate,
      String endDate,
      String otherStartDate,
      String otherEndDate);
  Future<Either<Failure, Null>> editIsPlan(int repId, int flag);
  Future<Either<Failure, Null>> updateSave(int repId, int flag1);
  Future<Either<Failure, Null>> exceptionApi(ExceptionModel exceptionModel);
  Future<Either<Failure, List<ExceptionModel>>> allException();
}
