import 'package:dartz/dartz.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';

abstract class Repository {
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest);

  Future<Either<Failure, List<PlaceModel>>> allPlace(int id);

  Future<Either<Failure, List<SpecDModel>>> allSpec(int repDet, {int? planId});

  Future<Either<Failure, List<CityModel>>> allCity();

  Future<Either<Failure, List<BrandModel>>> allBrand(int id);

  Future<Either<Failure, List<PharmacyModel>>> getAllPharmacy(int repDet);

  Future<Either<Failure, List<DoctorModel>>> getAllDoctor(int repDet);

  Future<Either<Failure, List<HospitalModel>>> getAllHospital(int repDet);

  Future<Either<Failure, List<HospitalSpModel>>> getAllHospitalSp(int repDet);

  Future<Either<Failure, Message1Response>> visitPharmacy(
      VisitPharmacyRequestBody list1);

  Future<Either<Failure, Message1Response>> visitDoctor(
      VisitDoctorRequestBody list1);

  Future<Either<Failure, Message1Response>> visitHospital(
      VisitHospitalRequestBody list1);

  Future<Either<Failure, List<BrandSpModel>>> getBrandsSp(int repDet);

  Future<Either<Failure, List<PlanBrandModel>>> getAllPlanBrands(Rep rep);

  Future<Either<Failure, AllPlanBrandSp?>> getRepPlanBrandSp(RepSp rep);

  Future<Either<Failure, List<PlanBrandModel>>> getAllPlanBrandsType(Rep rep);

  Future<Either<Failure, Message1Response>> repPlanBrand(
      RepPlanBrandBody list1);

  Future<Either<Failure, LoginModel>> checkActivePlanBrand(int repDe);

  Future<Either<Failure, VisitHospitalBase>> getHosVisit(
      int repPlanId, int representativeId);

  Future<Either<Failure, VisitDoctorBase>> getDocVisit(
      String repPlanId, String representativeId);

  Future<Either<Failure, List<BrandRes>>> getBrandRes(int repDet);

  Future<Either<Failure, InsertRecResponse>> insertReci(ReciRequest reciReq);

  Future<Either<Failure, CheckReResponse>> checkRe(int repDet);

  Future<Either<Failure, List<int>>> reciNum();

  Future<Either<Failure, CopyReciRequest>> copyReci(
      int docId, String recipeType);
  Future<Either<Failure, CopyReciRequest>> getRepReci(int reciId);
  Future<Either<Failure, CheckRepResponse>> checkRep(int depId);

  Future<Either<Failure, List<DoctorNoteModel>>> visitNotes(int depId);
  Future<Either<Failure, List<AllRepresentative>>> getReps(int id, int cityId);

  Future<Either<Failure, List<NoVisitDocModel>>> noVisitDoc(
      int repDet, int planId);

  Future<Either<Failure, List<NoVisitDocModel>>> visitDoc(
      int repDet, int planId);
  Future<Either<Failure, List<NoVisitDocModel>>> getUnfinishedDoctorVisits(
      int repDet, int planId);
  Future<Either<Failure, List<DoctorIssueModel>>> getVisitIssue(int repDet);

  Future<Either<Failure, Message1Response>> insertLog(
      ExceptionRequestBody list1);

  Future<Either<Failure, List<InventoryModel>>> getInventory(
      int repDet, int planId);

  Future<Either<Failure, InfoRep>> getInfoRep(int repDet, int planId);

  Future<Either<Failure, List<RepVisitsModel>>> getRepVisits(
      VisitRepSen visitRepSen);

  Future<Either<Failure, Message1Response>> readVisit(AsRead asRead);

  Future<Either<Failure, List<RepVisitsModel>>> getRepVisitsHos(
      VisitRepSen visitRepSen);

  Future<Either<Failure, Message1Response>> changePlanBrandType(
      ChangePlanBrandType changePlanBrandType);

  Future<Either<Failure, Message1Response>> readAllVisits(ReadAll readAll);
  Future<Either<Failure, List<DocdoctorsModel>>> docReport(int docId);
  Future<Either<Failure, List<doctorsModel>>> docSearch(
    int cityId,
    String name,
      int repDet
  );
  Future<Either<Failure, List<ReciModel>>> getAllRepReci(int repDet);
  Future<Either<Failure, Message1Response>> updateReci(
      UpdateReciRequest reciReq);
  Future<Either<Failure, DoctorModel>> getDocInfo(int docId);
  Future<Either<Failure, List<ActivePlanBrandModel>>> getInfoPlanBrandsType(
      int repPlan);

  Future<Either<Failure, Message1Response>> pharmacyOrder(
      PharmacyOrderRequestBody order);

  Future<Either<Failure, List<AllRepresentativeFuture>>> getRepsFuture(
      int id, int planId);

  Future<Either<Failure, Message1Response>> updateRepPlanBrandAmount(
      BrandAmountRequestBody list);
  Future<Either<Failure, Message1Response>> changeRepPlanStatus(
      int id, int status);

  Future<Either<Failure, List<WhoReadModel>>> getVisitReadStatus(
    String visitId,
    String visitType,
    int repType,
  );
  Future<Either<Failure, List<SeniorCityModel>>> getSeniorByCityid(int cityId);
  Future<Either<Failure, List<SeniorCityModel>>> getCityAndTeamleader();
  Future<Either<Failure, List<SearchHospitalModel>>> getSearchHospitals(
      String name,int repDet);
  Future<Either<Failure, List<SearchHospitalNoteModel>>>
      getSearchHospitalsNotes(int hosId, int spId);
  Future<Either<Failure, List<FinishedPlanModel>>> getFinishedPlans(int cityId);
  Future<Either<Failure, List<PlanRepsModel>>> getPlanReps(int planId);

  Future<Either<Failure, List<NoVisitDocModel>>> noVisitHos(
    int repDet,
    int planId,
  );

  Future<Either<Failure, List<NoVisitDocModel>>> visitHos(
    int repPlanId,
  );
  Future<Either<Failure, List<NoVisitDocModel>>> getUnfinishedHosVisits(
    int repPlanId,
  );
  Future<Either<Failure, DocHosByPlaceAndSp>> getSpDocHos(int repDet,      {
    int? spId,
    int ?placeId,
  });

}
