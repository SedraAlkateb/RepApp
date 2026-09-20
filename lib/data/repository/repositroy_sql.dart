import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:domina_app/app/logger/app_logger.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/ex.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/repository_sql.dart';

final _log = AppLogger.get('RepositorySql');

class RepositroySqlImp extends RepositorySql {
  final AppSqlApi _databaseHelper;
  final ExcRepository excRepository;
  RepositroySqlImp(this._databaseHelper, this.excRepository);

  /// ينفّذ عملية قاعدة البيانات المحلية ويحوّل أي استثناء إلى [Left]
  /// مع تسجيله محلياً عبر [excRepository] تحت الوسم [tag].
  ///
  /// نوع [call] `dynamic` عمداً: عدة دوال في `AppSqlApi` (insertLogin وأخواتها)
  /// معرّفة بلا نوع إرجاع فتُرجع `Future<dynamic>`، ولا يصح إسناد هذا الـ Future
  /// إلى `FutureOr<T>` قبل انتظاره. لذلك ننتظر القيمة أولاً ثم نحوّلها إلى [T]
  /// داخل `try`، تماماً كما كانت تفعل الدوال قبل توحيدها.
  Future<Either<Failure, T>> _sqlCall<T>(
    String tag,
    FutureOr<dynamic> Function() call,
  ) async {
    try {
      final response = await call();
      return Right(response as T);
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      _log.warning('$tag failed: ${failure.massage}');
      excRepository.exceptionApi(ExceptionModel(failure.massage, tag));
      return Left(failure);
    }
  }

  /// مثل [_sqlCall] للعمليات التي لا تُرجع قيمة.
  Future<Either<Failure, Null>> _sqlRun(
    String tag,
    FutureOr<void> Function() call,
  ) =>
      _sqlCall<Null>(tag, () async {
        await call();
        return null;
      });

  @override
  Future<Either<Failure, List<BrandModel>>> getBrandsSql() =>
      _sqlCall('getBrandsSql', () => _databaseHelper.getBrands());

  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmacySql() =>
      _sqlCall('getPharmacySql', () => _databaseHelper.getPharmacy());

  @override
  Future<Either<Failure, List<PlaceModel>>> getPlaceSql() =>
      _sqlCall('getPlaceSql', () => _databaseHelper.getPlace());

  @override
  Future<Either<Failure, List<SpecDModel>>> getSpecSql() =>
      _sqlCall('getSpecSql', () => _databaseHelper.getSpec());

  @override
  Future<Either<Failure, Null>> insertBrandsSql(List<BrandModel> brandModel) =>
      _sqlCall(
          'insertBrandsSql', () => _databaseHelper.insertBrands(brandModel));

  @override
  Future<Either<Failure, Null>> insertPharmacy(
          List<PharmacyModel> pharmacyModel) =>
      _sqlCall('insertPharmacy',
          () => _databaseHelper.insertPharmacy(pharmacyModel));

  @override
  Future<Either<Failure, Null>> insertPlace(List<PlaceModel> placeModel) =>
      _sqlCall('insertPlace', () => _databaseHelper.insertPlace(placeModel));

  @override
  Future<Either<Failure, Null>> insertSpec(List<SpecDModel> specModel) =>
      _sqlCall('insertSpec', () => _databaseHelper.insertSpec(specModel));

  @override
  Future<Either<Failure, Null>> clearDatabase() =>
      _sqlRun('clearDatabase', () => _databaseHelper.clearDatabase());

  @override
  Future<Either<Failure, Null>> loginSql(LoginModel loginModel) =>
      _sqlCall('loginSql', () => _databaseHelper.insertLogin(loginModel));

  @override
  Future<Either<Failure, LoginModel?>> getRep() =>
      _sqlCall('getRep', () => _databaseHelper.getRep());

  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmaciesByPlaceId(
          int placeId) =>
      _sqlCall('getPharmaciesByPlaceId',
          () => _databaseHelper.getPharmaciesByPlaceId(placeId));

  @override
  Future<Either<Failure, String>> asyncData(
      List<BrandModel> brands,
      //List<PharmacyModel> pharmacies,
      List<PlaceModel> places,
      List<SpecDModel> specs,
      List<DoctorModel> doctors,
      List<HospitalModel> hospitals,
      List<HospitalSpModel> hospitalSps,
      List<BrandSpModel> brandSps,
      VisitHospitalBase visitHospital,
      VisitDoctorBase visitDoctor,
      {List<PlanBrandModel>? planBrands}) async {
    try {
      final response = await _databaseHelper.asyncData(
        brands,
        //  pharmacies,
        places,
        specs,
        doctors,
        hospitals,
        hospitalSps,
        brandSps,
        visitHospital, visitDoctor,
        planBrands: planBrands,
      );
      if (response == "") {
        return Right(response);
      } else {
        Failure failure = Failure(6, response);
        excRepository
            .exceptionApi(ExceptionModel(failure.massage, "asyncData"));
        return Left(failure);
      }
    } catch (e) {
      Failure failure = ErrorHandler.handle(e).failure;
      excRepository.exceptionApi(ExceptionModel(failure.massage, "asyncData"));
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<BrandModel>>> getBrandsWithFlag() =>
      _sqlCall('getBrandsWithFlag', () => _databaseHelper.getBrandsWithFlag());

  @override
  Future<Either<Failure, Null>> insertDoctor(List<DoctorModel> doctorModel) =>
      _sqlCall('insertDoctor', () => _databaseHelper.insertdoctor(doctorModel));

  @override
  Future<Either<Failure, List<HospitalModel>>> getHospitalSql() =>
      _sqlCall('getHospitalSql', () => _databaseHelper.getHospital());

  @override
  Future<Either<Failure, Null>> insertHospital(
          List<HospitalModel> hospitalModel) =>
      _sqlCall('insertHospital',
          () => _databaseHelper.inserthospital(hospitalModel));

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorSql() =>
      _sqlCall('getDoctorSql', () => _databaseHelper.getDoctors());

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorByPlaceId(int placeId) =>
      _sqlCall('getDoctorByPlaceId',
          () => _databaseHelper.getDoctorByPlaceId(placeId));

  @override
  Future<Either<Failure, List<HospitalSpAllModel>>> getHospitalByPlaceId(
          int placeId) =>
      _sqlCall('getHospitalByPlaceId',
          () => _databaseHelper.getHospitalByPlaceId(placeId));

  @override
  Future<Either<Failure, Null>> insertVisitPharmacy(
          VisitPharmacyModel visitPharmacyModel) =>
      _sqlRun('insertVisitPharmacy',
          () => _databaseHelper.insertVisitPharmacy(visitPharmacyModel));

  @override
  Future<Either<Failure, List<VisitPharmacyAndPharmacy>>> getVisitPharmacy() =>
      _sqlCall('getVisitPharmacy', () => _databaseHelper.getVisitPharmacy());

  @override
  Future<Either<Failure, List<VisitDoctorAndDoctor>>> getVisitDoctor() =>
      _sqlCall('getVisitDoctor', () => _databaseHelper.getVisitDoctor());

  @override
  Future<Either<Failure, Null>> insertVisitDoctor(
          VisitDoctorModel visitDoctorModel) =>
      _sqlCall('insertVisitDoctor',
          () => _databaseHelper.insertVisitDoctor(visitDoctorModel));

  @override
  Future<Either<Failure, Null>> insertHospitalSp(
          List<HospitalSpModel> hospitalSps) =>
      _sqlCall('insertHospitalSp',
          () => _databaseHelper.insertHospitalSp(hospitalSps));

  @override
  Future<Either<Failure, Null>> insertVisitBrandPharmacy(
    List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
    VisitPharmacyModel visitPharmacyModel,
  ) =>
      _sqlRun(
          'insertVisitBrandPharmacy',
          () => _databaseHelper.insertVisitBrandPharmacy(
              visitPharmacyModel, visitBrandPharmacyModels));

  @override
  Future<Either<Failure, List<PharmacyBrandModel>>> getBrandsPharmacyByVisitId(
          int visitId) =>
      _sqlCall('getBrandsPharmacyByVisitId',
          () => _databaseHelper.getBrandsPharmacyByVisitId(visitId));

  @override
  Future<Either<Failure, List<PharmacyBrandModel>>> getBrandsDoctorByVisitId(
          int visitId) =>
      _sqlCall('getBrandsDoctorByVisitId',
          () => _databaseHelper.getBrandsDoctorByVisitId(visitId));

  @override
  Future<Either<Failure, Null>> insertVisitBrandDoctor(
          List<VisitBrandPharmacyModel> visitBrandDoctorModels,
          VisitDoctorModel visitDoctorModel) =>
      _sqlRun(
          'insertVisitBrandDoctor',
          () => _databaseHelper.insertVisitBrandDoctor(
              visitDoctorModel, visitBrandDoctorModels));

  @override
  Future<Either<Failure, List<SpecHospitalSp>>> specializationByHospitalId(
          int hospitalId) =>
      _sqlCall('specializationByHospitalId',
          () => _databaseHelper.specializationByHospitalId(hospitalId));

  @override
  Future<Either<Failure, Null>> insertVisitBrandHospital(
          VisitHospitalModel visitHospitalModel,
          List<VisitBrandPharmacyModel> visitBrandPharmacyModels,
          int hos,
          int spec) =>
      _sqlRun(
          'insertVisitBrandHospital',
          () => _databaseHelper.insertVisitBrandHospital(
              visitHospitalModel, visitBrandPharmacyModels, hos, spec));

  @override
  Future<Either<Failure, Null>> insertVisitHospital(
          VisitHospitalModel visitHospitalModel, int hos, int spec) =>
      _sqlRun(
          'insertVisitHospital',
          () => _databaseHelper.insertVisitHospital(
              visitHospitalModel, hos, spec));

  @override
  Future<Either<Failure, Null>> editIsLogin(int repId, int isLogin) =>
      _sqlRun('editIsLogin', () => _databaseHelper.editIsLogin(repId, isLogin));

  @override
  Future<Either<Failure, List<PharmacyBrandModel>>> getBrandsHospitalByVisitId(
          int visitId) =>
      _sqlCall('getBrandsHospitalByVisitId',
          () => _databaseHelper.getBrandsHospitalByVisitId(visitId));

  @override
  Future<Either<Failure, List<VisitHospitalAndHospital>>> getVisitHospital() =>
      _sqlCall('getVisitHospital', () => _databaseHelper.getVisitHospital());

  @override
  Future<Either<Failure, Null>> updateVisitDoctorFields(
          {required int id,
          String? kaswn,
          String? science,
          String? target,
          List<PharmacyBrandModel>? selectBrand}) =>
      _sqlRun(
          'updateVisitDoctorFields',
          () => _databaseHelper.updateVisitDoctorFields(
              id: id,
              kaswn: kaswn,
              science: science,
              target: target,
              selectBrand: selectBrand));

  @override
  Future<Either<Failure, Null>> updateVisitHospitalFields(
          {required int id,
          String? kaswn,
          String? science,
          String? target,
          List<PharmacyBrandModel>? selectBrand}) =>
      _sqlRun(
          'updateVisitHospitalFields',
          () => _databaseHelper.updateVisitHospitalFields(
              id: id,
              kaswn: kaswn,
              science: science,
              target: target,
              selectBrand: selectBrand));

  @override
  Future<Either<Failure, Null>> updateVisitPharmacy(
          {required int visitId, String? newNote}) =>
      _sqlRun(
          'updateVisitPharmacy',
          () => _databaseHelper.updateVisitPharmacy(
              visitId: visitId, newNote: newNote));

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorBySpec(int spId) =>
      _sqlCall('getDoctorBySpec', () => _databaseHelper.getDoctorBySpec(spId));

  @override
  Future<Either<Failure, List<HospitalModel>>> getHospitalBySpec(int spId) =>
      _sqlCall(
          'getHospitalBySpec', () => _databaseHelper.getHospitalBySpec(spId));

  @override
  Future<Either<Failure, List<PlanBrandModel>>> planBrandsAs() =>
      _sqlCall('planBrandsAs', () => _databaseHelper.planBrandsAs());

  @override
  Future<Either<Failure, List<VisitBrandPharmacyModel>>> visitBrandDoctorAs() =>
      _sqlCall(
          'visitBrandDoctorAs', () => _databaseHelper.visitBrandDoctorAs());

  @override
  Future<Either<Failure, List<VisitBrandPharmacyModel>>>
      visitBrandHospitalAs() => _sqlCall(
          'visitBrandHospitalAs', () => _databaseHelper.visitBrandHospitalAs());

  @override
  Future<Either<Failure, List<VisitBrandPharmacyModel>>>
      visitBrandPharmacyAs() => _sqlCall(
          'visitBrandPharmacyAs', () => _databaseHelper.visitBrandPharmacyAs());

  @override
  Future<Either<Failure, List<VisitDoctorModel>>> visitDoctorAs() =>
      _sqlCall('visitDoctorAs', () => _databaseHelper.visitDoctorAs());

  @override
  Future<Either<Failure, List<VisitHospitalModel>>> visitHospitalAs() =>
      _sqlCall('visitHospitalAs', () => _databaseHelper.visitHospitalAs());

  @override
  Future<Either<Failure, List<HospitalSpModel>>> visitHospitalSpAs() =>
      _sqlCall('visitHospitalSpAs', () => _databaseHelper.visitHospitalSpAs());

  @override
  Future<Either<Failure, List<VisitPharmacyModel>>> visitPharmacyAs() =>
      _sqlCall('visitPharmacyAs', () => _databaseHelper.visitPharmacyAs());

  @override
  Future<Either<Failure, Null>> clearDatabaseAll() =>
      _sqlRun('clearDatabaseAll', () => _databaseHelper.clearDatabaseAll());

  @override
  Future<Either<Failure, Null>> updateRep(
          int repId,
          int otherPlanId,
          int activePlanId,
          int otherStatus,
          String startDate,
          String endDate,
          String otherStartDate,
          String otherEndDate) =>
      _sqlRun(
          'updateRep',
          () => _databaseHelper.updateRep(repId, otherPlanId, activePlanId,
              otherStatus, startDate, endDate, otherStartDate, otherEndDate));

  @override
  Future<Either<Failure, List<HospitalSpAllModel>>>
      getAllHospitalSpecialization() => _sqlCall('getAllHospitalSpecialization',
          () => _databaseHelper.getAllHospitalSpecialization());

  @override
  Future<Either<Failure, Null>> updateAmounts(
          List<OtherBrandSpPlanModel> planBrands) =>
      _sqlCall(
          'updateAmounts', () => _databaseHelper.updateAmounts(planBrands));

  @override
  Future<Either<Failure, bool>> updateFlagsToDoctor() => _sqlCall(
      'updateFlagsToDoctor', () => _databaseHelper.updateFlagsToDoctor());

  @override
  Future<Either<Failure, bool>> updateFlagsToHospital() => _sqlCall(
      'updateFlagsToHospital', () => _databaseHelper.updateFlagsToHospital());

  @override
  Future<Either<Failure, Null>> updateOtherStatus(
          int repId, int status, List<OtherBrandSpPlanModel> planBrands) =>
      _sqlCall('updateOtherStatus',
          () => _databaseHelper.updateOtherStatus(repId, status, planBrands));

  @override
  Future<Either<Failure, List<BrandSpPlanModel>>> planBrandByRepPlanId(
          int repPlanId) =>
      _sqlCall('planBrandByRepPlanId',
          () => _databaseHelper.planBrandByRepPlanId(repPlanId));

  @override
  Future<Either<Failure, List<OtherBrandSpPlanModel>>>
      otherPlanBrandByRepPlanId(int repPlanId) => _sqlCall(
          'otherPlanBrandByRepPlanId',
          () => _databaseHelper.otherPlanBrandByRepPlanId(repPlanId));

  @override
  Future<Either<Failure, Null>> editIsPlan(int repId, int flag) =>
      _sqlRun('editIsPlan', () => _databaseHelper.editIsPlan(repId, flag));

  @override
  Future<Either<Failure, Null>> updateSave(int repId, int flag1) =>
      _sqlRun('updateSave', () => _databaseHelper.updateSave(repId, flag1));

  @override
  Future<Either<Failure, Null>> exceptionApi(ExceptionModel exceptionModel) =>
      _sqlRun('updateSave', () => _databaseHelper.exceptionApi(exceptionModel));

  @override
  Future<Either<Failure, List<ExceptionModel>>> allException() =>
      _sqlCall('updateSave', () => _databaseHelper.allException());

  @override
  Future<Either<Failure, NumVisit>> numVisit() =>
      _sqlCall('numVisit', () => _databaseHelper.numVisit());

  @override
  Future<Either<Failure, void>> numDocAndHos() =>
      _sqlCall('numDocAndHos', () => _databaseHelper.numDocAndHos());

  @override
  Future<Either<Failure, void>> editRecipe(InsertRecResponse recNum) =>
      _sqlCall('editRecipe', () => _databaseHelper.editRecipe(recNum));
}
