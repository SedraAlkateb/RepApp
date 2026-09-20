import 'package:dartz/dartz.dart';
import 'package:domina_app/data/mapper/mapper.dart';

import 'package:domina_app/data/data_source/remote_data_source.dart';
import 'package:domina_app/data/network/error_handler.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/data/network/network_info.dart';
import 'package:domina_app/app/logger/app_logger.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/ex.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/repository/repository.dart';

final _log = AppLogger.get('Repository');

class RepositoryImp implements Repository {
  final RemoteDataSource _remoteDataSource;
  final ExcRepository excRepository;

  final NetworkInfo _networkInfo;

  RepositoryImp(this._remoteDataSource, this._networkInfo, this.excRepository);

  bool _isSuccess(BaseResponse response) =>
      response.status == null ||
      response.status == ApiInternalStatus.SUCCESS ||
      response.status == "200";

  void _logRemote(Failure failure, String tag) {
    insertLog(ExceptionRequestBody([ExceptionModel(failure.massage, tag)]));
  }

  void _logLocal(Failure failure, String tag) {
    excRepository.exceptionApi(ExceptionModel(failure.massage, tag));
  }

  /// النمط الموحّد لكل استدعاء بعيد:
  /// فحص الاتصال ← تنفيذ الطلب ← فحص حالة الرد ← تحويل الرد إلى الـ domain،
  /// وأي فشل (منطقي أو استثناء) يُسجَّل ويُرجَع كـ [Left].
  ///
  /// - [tag]: اسم العملية في سجل الأخطاء.
  /// - [isSuccess]: لتخصيص شرط النجاح (الافتراضي [_isSuccess]).
  /// - [failureCode]: لتخصيص كود الفشل المنطقي (الافتراضي [ApiInternalStatus.FAILURE]).
  /// - [logNoInternet]: تسجيل حالة انعدام الاتصال أيضاً.
  /// - [log]: وجهة السجل (الافتراضي: الخادم عبر [insertLog]).
  Future<Either<Failure, T>> _remoteCall<T, R extends BaseResponse>({
    required String tag,
    required Future<R> Function() call,
    required T Function(R response) map,
    bool Function(R response)? isSuccess,
    int Function(R response)? failureCode,
    bool logNoInternet = false,
    void Function(Failure failure, String tag)? log,
  }) async {
    void report(Failure failure) {
      _log.warning('$tag failed: ${failure.massage}');
      (log ?? _logRemote)(failure, tag);
    }

    try {
      if (await _networkInfo.isConnected) {
        final response = await call();
        if ((isSuccess ?? _isSuccess)(response)) {
          return Right(map(response));
        }
        final failure = Failure(
            failureCode?.call(response) ?? ApiInternalStatus.FAILURE,
            response.message ?? ResponseMassage.DEFAULT);
        report(failure);
        return Left(failure);
      }
      final failure = DataSource.NO_INTERNET_CONNECTION.getFailure();
      if (logNoInternet) report(failure);
      return Left(failure);
    } catch (error) {
      final failure = ErrorHandler.handle(error).failure;
      report(failure);
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest) =>
      _remoteCall(
        tag: 'login',
        call: () => _remoteDataSource.login(loginRequest),
        map: (response) => response.toDomain(),
        isSuccess: (response) =>
            response.status == "200" ||
            response.status == ApiInternalStatus.SUCCESS,
      );

  @override
  Future<Either<Failure, List<PlaceModel>>> allPlace(int id) => _remoteCall(
        tag: 'allPlace',
        call: () => _remoteDataSource.allPlaces(id),
        map: (response) => response.toDomain(),
        logNoInternet: true,
      );

  @override
  Future<Either<Failure, List<SpecDModel>>> allSpec(int repDet,
          {int? planId}) =>
      _remoteCall(
        tag: 'allSpec',
        call: () =>
            _remoteDataSource.allSpecializations(repDet, planId: planId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<BrandModel>>> allBrand(int id) => _remoteCall(
        tag: 'allBrand',
        call: () => _remoteDataSource.allBrand(id),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<CityModel>>> allCity() => _remoteCall(
        tag: 'allCity',
        call: () => _remoteDataSource.allCity(),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<PharmacyModel>>> getAllPharmacy(int repDet) =>
      _remoteCall(
        tag: 'getAllPharmacy',
        call: () => _remoteDataSource.getAllPharmacy(repDet),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<DoctorModel>>> getAllDoctor(int repDet) =>
      _remoteCall(
        tag: 'getAllDoctor',
        call: () => _remoteDataSource.getAllDoctor(repDet),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<HospitalModel>>> getAllHospital(int repDet) =>
      _remoteCall(
        tag: 'getAllHospital',
        call: () => _remoteDataSource.getAllHospital(repDet),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<HospitalSpModel>>> getAllHospitalSp(int repDet) =>
      _remoteCall(
        tag: 'getAllHospitalSp',
        call: () => _remoteDataSource.getAllHospitalSp(repDet),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, Message1Response>> visitPharmacy(
          VisitPharmacyRequestBody list1) =>
      _remoteCall(
        tag: 'visitPharmacy',
        call: () => _remoteDataSource.visitPharmacy(list1),
        map: (response) => response,
      );

  @override
  Future<Either<Failure, Message1Response>> visitDoctor(
          VisitDoctorRequestBody list1) =>
      _remoteCall(
        tag: 'visitDoctor',
        call: () => _remoteDataSource.visitDoctor(list1),
        map: (response) => response,
      );

  @override
  Future<Either<Failure, Message1Response>> visitHospital(
          VisitHospitalRequestBody list1) =>
      _remoteCall(
        tag: 'visitHospital',
        call: () => _remoteDataSource.visitHospital(list1),
        map: (response) => response,
      );

  @override
  Future<Either<Failure, List<BrandSpModel>>> getBrandsSp(int repDet) =>
      _remoteCall(
        tag: 'getBrandsSp',
        call: () => _remoteDataSource.getBrandsSp(repDet),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<PlanBrandModel>>> getAllPlanBrands(Rep rep) =>
      _remoteCall(
        tag: 'getAllPlanBrands',
        call: () => _remoteDataSource.getAllPlanBrands(rep.activeRepId,
            repPlanIdOther: rep.otherRepId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, Message1Response>> repPlanBrand(
          RepPlanBrandBody list1) =>
      _remoteCall(
        tag: 'repPlanBrand',
        call: () => _remoteDataSource.repPlanBrand(list1),
        map: (response) => response,
      );

  @override
  Future<Either<Failure, LoginModel>> checkActivePlanBrand(int repDe) =>
      _remoteCall(
        tag: 'checkActivePlanBrand',
        call: () => _remoteDataSource.checkActivePlanBrand(repDe),
        map: (response) => response.toDomain(),
        logNoInternet: true,
      );

  @override
  Future<Either<Failure, VisitDoctorBase>> getDocVisit(
          String repPlanId, String representativeId) =>
      _remoteCall(
        tag: 'getDocVisit',
        call: () => _remoteDataSource.getDocVisit(repPlanId, representativeId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, VisitHospitalBase>> getHosVisit(
          int repPlanId, int representativeId) =>
      _remoteCall(
        tag: 'getHosVisit',
        call: () => _remoteDataSource.getHosVisit(repPlanId, representativeId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<BrandRes>>> getBrandRes(int repDet) =>
      _remoteCall(
        tag: 'getBrandRes',
        call: () => _remoteDataSource.getBrandRes(repDet),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, InsertRecResponse>> insertReci(ReciRequest reciReq) =>
      _remoteCall(
        tag: 'insertReci',
        call: () => _remoteDataSource.insertReci(reciReq),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, CheckReResponse>> checkRe(int repDet) => _remoteCall(
        tag: 'checkRe',
        call: () => _remoteDataSource.checkRe(repDet),
        map: (response) => response,
      );

  @override
  Future<Either<Failure, List<int>>> reciNum() => _remoteCall(
        tag: 'reciNum',
        call: () => _remoteDataSource.reciNum(),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, CopyReciRequest>> copyReci(
          int docId, String recipeType) =>
      _remoteCall(
        tag: 'copyReci',
        call: () => _remoteDataSource.copyReci(docId, recipeType),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, CopyReciRequest>> getRepReci(int reciId) =>
      _remoteCall(
        tag: 'getRepReci',
        call: () => _remoteDataSource.getRepReci(reciId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, CheckRepResponse>> checkRep(int repId) => _remoteCall(
        tag: 'checkRep',
        call: () => _remoteDataSource.checkRep(repId),
        map: (response) => response,
      );

  @override
  Future<Either<Failure, List<DoctorNoteModel>>> visitNotes(int repId) =>
      _remoteCall(
        tag: 'visitNotes',
        call: () => _remoteDataSource.visitNotes(repId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<DoctorIssueModel>>> getVisitIssue(int repId) =>
      _remoteCall(
        tag: 'getVisitIssue',
        call: () => _remoteDataSource.getVisitIssue(repId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<AllRepresentative>>> getReps(
          int id, int cityId) =>
      _remoteCall(
        tag: 'getReps',
        call: () => _remoteDataSource.getReps(id, cityId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<NoVisitDocModel>>> getUnfinishedDoctorVisits(
          int repDet, int planId) =>
      _remoteCall(
        tag: 'noVisitDoc',
        call: () => _remoteDataSource.getUnfinishedDoctorVisits(repDet, planId),
        map: (response) => response.toDomain(),
        failureCode: (response) => int.parse(response.status ?? "0"),
      );

  @override
  Future<Either<Failure, List<NoVisitDocModel>>> noVisitDoc(
          int repDet, int planId) =>
      _remoteCall(
        tag: 'noVisitDoc',
        call: () => _remoteDataSource.noVisitDoc(repDet, planId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<NoVisitDocModel>>> visitDoc(
          int repDet, int planId) =>
      _remoteCall(
        tag: 'visitDoc',
        call: () => _remoteDataSource.visitDoc(repDet, planId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, Message1Response>> insertLog(
      ExceptionRequestBody list1) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.insertLog(list1);
        if (response.status == null ||
            response.status == ApiInternalStatus.SUCCESS ||
            response.status == "200") {
          return Right(response);
        } else {
          Failure failure = Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMassage.DEFAULT);
          return Left(failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      Failure failure = ErrorHandler.handle(error).failure;
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<InventoryModel>>> getInventory(
          int repDet, int planId) =>
      _remoteCall(
        tag: 'getInventory',
        call: () => _remoteDataSource.getInventory(repDet, planId),
        map: (response) => response.toDomain(),
        log: _logLocal,
      );

  @override
  Future<Either<Failure, InfoRep>> getInfoRep(int repDet, int planId) =>
      _remoteCall(
        tag: 'getInfoRep',
        call: () => _remoteDataSource.getRepInfo(repDet, planId),
        map: (response) => response.toDomain(),
        log: _logLocal,
      );

  @override
  Future<Either<Failure, List<RepVisitsModel>>> getRepVisits(
          VisitRepSen visitRepSen) =>
      _remoteCall(
        tag: 'getRepVisits',
        call: () => _remoteDataSource.getRepVisits(visitRepSen),
        map: (response) => response.toDomain(),
        log: _logLocal,
      );

  @override
  Future<Either<Failure, Message1Response>> readVisit(AsRead asRead) =>
      _remoteCall(
        tag: 'readVisit',
        call: () => _remoteDataSource.readVisit(asRead),
        map: (response) => response,
        log: _logLocal,
      );

  @override
  Future<Either<Failure, List<RepVisitsModel>>> getRepVisitsHos(
          VisitRepSen visitRepSen) =>
      _remoteCall(
        tag: 'getRepVisitsHos',
        call: () => _remoteDataSource.getRepVisitsHos(visitRepSen),
        map: (response) => response.toDomain(),
        log: _logLocal,
      );

  @override
  Future<Either<Failure, Message1Response>> changePlanBrandType(
          ChangePlanBrandType changePlanBrandType) =>
      _remoteCall(
        tag: 'changePlanBrandType',
        call: () => _remoteDataSource.changePlanBrandType(changePlanBrandType),
        map: (response) => response,
        log: _logLocal,
      );

  @override
  Future<Either<Failure, AllPlanBrandSp?>> getRepPlanBrandSp(RepSp rep) =>
      _remoteCall(
        tag: 'getRepPlanBrandSp',
        call: () => _remoteDataSource.getRepPlanBrandSp(
            rep.repPlanId, rep.spId, rep.repId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<doctorsModel>>> docSearch(String name, int repDet,
          {int? cityId}) =>
      _remoteCall(
        tag: 'docSearch',
        call: () => _remoteDataSource.docSearch(name, repDet, cityId: cityId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, Message1Response>> readAllVisits(ReadAll readAll) =>
      _remoteCall(
        tag: 'readAllVisits',
        call: () => _remoteDataSource.readAllVisits(readAll),
        map: (response) => response,
      );

  @override
  Future<Either<Failure, List<PlanBrandModel>>> getAllPlanBrandsType(Rep rep) =>
      _remoteCall(
        tag: 'getAllPlanBrands',
        call: () => _remoteDataSource.getAllPlanBrandsType(
            rep.activeRepId, rep.flag,
            repPlanIdOther: rep.otherRepId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<DocdoctorsModel>>> docReport(int docId) =>
      _remoteCall(
        tag: 'docReport',
        call: () => _remoteDataSource.docReport(docId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<ReciModel>>> getAllRepReci(int repDet) =>
      _remoteCall(
        tag: 'getAllRepReci',
        call: () => _remoteDataSource.getAllRepReci(repDet),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, InsertRecResponse>> updateReci(
          UpdateReciRequest reciReq) =>
      _remoteCall(
        tag: 'updateReci',
        call: () => _remoteDataSource.updateReci(reciReq),
        map: (response) => response.toDomain(),
        isSuccess: (response) =>
            response.message == ApiInternalStatus.SUCCESS ||
            response.status == "200",
      );

  @override
  Future<Either<Failure, DoctorModel>> getDocInfo(int docId) => _remoteCall(
        tag: 'getDocInfo',
        call: () => _remoteDataSource.getDocInfo(docId),
        map: (response) => response.toDomain(),
        isSuccess: (response) =>
            response.status == ApiInternalStatus.SUCCESS ||
            response.message == ApiInternalStatus.SUCCESS ||
            response.status == "200",
      );

  @override
  Future<Either<Failure, List<ActivePlanBrandModel>>> getInfoPlanBrandsType(
          int repPlan,
          {int status = 0}) =>
      _remoteCall(
        tag: 'getInfoPlanBrandsType',
        call: () =>
            _remoteDataSource.getinfoPlanBrandsType(repPlan, status: status),
        map: (response) => response.toDomain(),
        isSuccess: (response) =>
            response.status == ApiInternalStatus.SUCCESS ||
            response.message == ApiInternalStatus.SUCCESS ||
            response.status == "200",
      );

  @override
  Future<Either<Failure, Message1Response>> pharmacyOrder(
          PharmacyOrderRequestBody order) =>
      _remoteCall(
        tag: 'getInfoPlanBrandsType',
        call: () => _remoteDataSource.pharmacyOrder(order),
        map: (response) => response,
        isSuccess: (response) =>
            response.status == ApiInternalStatus.SUCCESS ||
            response.message == ApiInternalStatus.SUCCESS ||
            response.status == "200",
      );

  @override
  Future<Either<Failure, Message1Response>> changeRepPlanStatus(
          int id, int status) =>
      _remoteCall(
        tag: 'docReport',
        call: () => _remoteDataSource.changeRepPlanStatus(id, status),
        map: (response) => response,
      );

  @override
  Future<Either<Failure, List<SeniorCityModel>>> getCityAndTeamleader() =>
      _remoteCall(
        tag: 'getCityAndTeamleader',
        call: () => _remoteDataSource.getCityAndTeamleader(),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<AllRepresentativeFuture>>> getRepsFuture(int id,
          {int? cityId}) =>
      _remoteCall(
        tag: 'getRepsFuture',
        call: () => _remoteDataSource.getRepsFuture(id, cityId: cityId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<SearchHospitalModel>>> getSearchHospitals(
          String name, int repDet,
          {int? cityId}) =>
      _remoteCall(
        tag: 'getRepReci',
        call: () =>
            _remoteDataSource.getSearchHospitals(name, repDet, cityId: cityId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<SearchHospitalNoteModel>>>
      getSearchHospitalsNotes(int hosId, int spId) => _remoteCall(
            tag: 'getRepReci',
            call: () => _remoteDataSource.getSearchHospitalsNotes(hosId, spId),
            map: (response) => response.toDomain(),
          );

  @override
  Future<Either<Failure, List<SeniorCityModel>>> getSeniorByCityid(
          int cityId) =>
      _remoteCall(
        tag: 'getSeniorByCityid',
        call: () => _remoteDataSource.getSeniorByCityid(cityId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<WhoReadModel>>> getVisitReadStatus(
    String visitId,
    String visitType,
    int repType,
  ) =>
      _remoteCall(
        tag: 'getSeniorByCityid',
        call: () =>
            _remoteDataSource.getVisitReadStatus(visitId, visitType, repType),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, Message1Response>> updateRepPlanBrandAmount(
          BrandAmountRequestBody list) =>
      _remoteCall(
        tag: 'docReport',
        call: () => _remoteDataSource.updateRepPlanBrandAmount(list),
        map: (response) => response,
      );

  @override
  Future<Either<Failure, List<FinishedPlanModel>>> getFinishedPlans(
          int cityId) =>
      _remoteCall(
        tag: 'docReport',
        call: () => _remoteDataSource.getFinishedPlans(cityId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<PlanRepsModel>>> getPlanReps(int planId) =>
      _remoteCall(
        tag: 'getSeniorByCityid',
        call: () => _remoteDataSource.getPlanReps(planId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<NoVisitDocModel>>> getUnfinishedHosVisits(
          int repPlanId) =>
      _remoteCall(
        tag: 'noVisitDoc',
        call: () => _remoteDataSource.getUnfinishedHosVisits(repPlanId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<NoVisitDocModel>>> noVisitHos(
          int repDet, int planId) =>
      _remoteCall(
        tag: 'noVisitDoc',
        call: () => _remoteDataSource.noVisitHos(repDet, planId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<NoVisitDocModel>>> visitHos(int repPlanId) =>
      _remoteCall(
        tag: 'noVisitDoc',
        call: () => _remoteDataSource.visitHos(repPlanId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, DocHosByPlaceAndSp>> getSpDocHos(int repDet,
          {int? spId, int? placeId, int? cityId}) =>
      _remoteCall(
        tag: 'noVisitDoc',
        call: () => _remoteDataSource.getSpDocHos(repDet,
            spId: spId, placeId: placeId, cityId: cityId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<HosDocSpSearchModel>>> docSpSearch(
          int repPlanId, int spId) =>
      _remoteCall(
        tag: 'docHosSpSearch',
        call: () => _remoteDataSource.docSpSearch(repPlanId, spId),
        map: (response) => response.toDomain(),
      );

  @override
  Future<Either<Failure, List<HosDocSpSearchModel>>> hosSpSearch(
          int repPlanId, int spId) =>
      _remoteCall(
        tag: 'hosSpSearch',
        call: () => _remoteDataSource.hosSpSearch(repPlanId, spId),
        map: (response) => response.toDomain(),
      );
}
