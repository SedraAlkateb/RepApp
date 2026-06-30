import 'dart:io';
import 'package:domina_app/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/loginU.php")//
  Future<LoginResponse> login(@Part(name: "userName") String userName,
      @Part(name: "password") String password, @Part(name: "ver") int ver);
  @POST("/getAllPlace.php")//
  Future<AllPlaceBaseResponse> allPlace(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getAllSp.php")//
  Future<AllSpcBaseResponse> allSpecializations(
    @Part(name: "repDet") int repDet,
  );

  @POST("/getCity.php")//
  Future<AllCityBaseResponse> allCity(
    @Part(name: "repId") int repId,
  );

  @POST("/getAllBrand.php")//
  Future<AllBrandBaseResponse> allBrand(
    @Part(name: "repPlanId") int repPlanId,
  );
  @POST("/getAllPharmacy.php")//\
  Future<AllPharmacyBaseResponse> getAllPharmacy(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getAllDoctor.php")//
  Future<AllDoctorsBaseResponse> getAllDoctor(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getAllHospital.php")//
  Future<AllHospitalBaseResponse> getAllHospital(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getAllHospitalSp.php")//
  Future<AllHospitalSpBaseResponse> getAllHospitalSp(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getBrandsSp.php")//
  Future<AllBrandSpBaseResponse> getBrandsSp(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getAllPlanBrands.php")//

  Future<AllPlanBrandsBaseResponse> getAllPlanBrands(/////////TODO
      @Part(name: "repPlanIdActive") int repPlanIdActive,
      {@Part(name: "repPlanIdOther") int? repPlanIdOther});
  @POST("/admin/docSearch.php")//
  Future<SearchDoctorsBaseSpResponse> docSearch(
    @Part(name: "cityId") int cityId,
    @Part(name: "name") String name,
  );

  @POST("/admin/docReport.php")//
  Future<DocDoctorsBaseResponse> docReport(
    @Part(name: "docId") int docId,
  );

  @POST("/getHosVisit.php")//
  Future<VisitHospitalBaseResponse> getHosVisit(
    @Part(name: "repPlanId") int repPlanId,
    @Part(name: "representativeId") int representativeId,
  );
  @POST("/getDocVisit.php")//
  Future<VisitDoctorBaseResponse> getDocVisit(
    @Part(name: "repPlanId") String repPlanId,
    @Part(name: "representativeId") String representativeId,
  );
  @POST("/insertPlanBrands.php")//
  Future<Message1Response> repPlanBrand(@Body() RepPlanBrandBody list );
  @POST("/pharmacyVisit.php")//\
  Future<Message1Response> visitPharmacy(@Body() VisitPharmacyRequestBody list);
  @POST("/getAllPlanBrandsType.php")//*
  Future<AllPlanBrandsBaseResponse> getAllPlanBrandsType(
      @Part(name: "repPlanIdActive") int repPlanIdActive,
      @Part(name: "flag") int? flag,
      {@Part(name: "repPlanIdOther") int? repPlanIdOther
      });
  @POST("/admin/getRepPlanBrandSp.php")//*
  Future<PlanBrandsBaseSpResponse> getRepPlanBrandSp(
      @Part(name: "repPlanId") int repPlanId,
      @Part(name: "spId") int? spId,
      @Part(name: "repId") int? repId);////////////////////////TODO
  @POST("/hosVisit.php")//
  Future<Message1Response> visitHospital(@Body() VisitHospitalRequestBody list);
  @POST("/docVisit.php")//
  Future<Message1Response> visitDoctor(@Body() VisitDoctorRequestBody list);
  @POST("/getPlans.php")
  Future<LoginResponse> checkActivePlanBrand(
      @Part(name: "repDet") int repDet, @Part(name: "ver") int ver);
  @POST("/reci/getBrands.php")//
  Future<AllBrandResResponse> getBrandRes(
    @Part(name: "repDet") int repDet,
  );
  @POST("/reci/checkRe.php")//
  Future<CheckReResponse> checkRe(@Part(name: "repDet") int repDet);
  @POST("/reci/checkRep.php")//
  Future<CheckRepResponse> checkRep(@Part(name: "repDet") int repDet);
  @POST("/reci/insertReci.php")//
  Future<Message1Response> insertReci(
    @Part(name: "recipeType") String recipeType,
    @Part(name: "repId") String repId,
    @Part(name: "type") String type,
    @Part(name: "docId") String docId,
    @Part(name: "spName") String spName,
    @Part(name: "brand_1") String brand_1,
    @Part(name: "address") String address,
    @Part(name: "phone") String phone,
    @Part(name: "total") String total, {
    @Part(name: "flagImage1") String? flagImage1,
    @Part(name: "flagImage2") String? flagImage2,
    @Part(name: "note1") String? note1,
    @Part(name: "note2") String? note2,
    @Part(name: "image1") File? image1,
    @Part(name: "image2") File? image2,
    @Part(name: "brand_2") String? brand_2,
    @Part(name: "brand_3") String? brand_3,
    @Part(name: "brand_4") String? brand_4,
    @Part(name: "note_emp") String? note_emp,
  });
  @POST("/reci/reciNum.php")//
  Future<ReciNumResponse> reciNum();
  // @POST("/hosVisit.php")
  // Future<List<VisitHospitalRequestBody>> uploadVisitHospital();
  @POST("/reci/copyRe.php")//
  Future<CopyRecResponse> copyReci(
    @Part(name: "docId") int docId,
    @Part(name: "recipeType") String recipeType,
  );

  @POST("/reci/getRepReci.php")//
  Future<CopyRecResponse> getRepReci(
    @Part(name: "reciId") int reciId,
  );
  // 3981
  @POST("/admin/getReps.php")//
  Future<AllRepresentativeBaseResponse> getReps(
    @Part(name: "repDet") int id,
    @Part(name: "cityId") int cityId,
  );

  @POST("/admin/getVisitNotes.php")//\
  Future<AllVisitNotesBaseResponse> getVisitNotes(
    @Part(name: "repDet") int docId,
  );
  @POST("/admin/noVisitDoc.php")//
  Future<AllNoVisitDoctorBaseResponse> noVisitDoc(
    @Part(name: "repDet") int docId,
      @Part(name: "planId") int planId,
      );
  @POST("/admin/getUnfinishedDoctorVisits.php")//
  Future<AllNoVisitDoctorBaseResponse> getUnfinishedDoctorVisits(
    @Part(name: "repDet") int docId,
      @Part(name: "planId") int planId,

      );
  @POST("/admin/visitDoc.php")//
  Future<AllNoVisitDoctorBaseResponse> visitDoc(
    @Part(name: "repDet") int docId,
      @Part(name: "planId") int planId,
  );
  @POST("/admin/getVisitIssue.php")//\
  Future<AllVisitIssueBaseResponse> getVisitIssue(
    @Part(name: "repDet") int id,
  );
  @POST("/insertLog.php")
  Future<Message1Response> insertLog(@Body() ExceptionRequestBody list);
  @POST("/admin/inventory.php")//
  Future<InventoryResponseBaseResponse> getInventory(
    @Part(name: "repDet") int id,
      @Part(name: "planId") int planId,

      );
  @POST("/admin/getRepInfo.php")//
  Future<AllRepInfoResponseBaseResponse> getRepInfo(
      @Part(name: "repDet") int id,
      @Part(name: "repPlan") int repPlan,

      );
  @POST("/admin/getRepVisits.php")//
  Future<AllRepVisitsResponseBaseResponse> getRepVisits(
      @Part(name: "repId") int repId, @Part(name: "userId") int userId
      );
  @POST("/admin/readVisit.php")//
  Future<Message1Response> readVisit(
      @Part(name: "visitId") int visitId,
      @Part(name: "userId") int userId,
      @Part(name: "status") int status,
      @Part(name: "reqType") int reqType
      );
  @POST("/admin/readAllVisits.php")//
  Future<Message1Response> readAllVisits(
      @Part(name: "repPlanId") int repPlanId,
      @Part(name: "userId") int userId,
      @Part(name: "type") int type,
      @Part(name: "flag") int flag
      );

  @POST("/admin/getRepVisitsHos.php")//
  Future<AllRepVisitsResponseBaseResponse> getRepVisitsHos(
      @Part(name: "repId") int repId, @Part(name: "userId") int userId
      );
  @POST("/admin/changePlanBrandType.php")//*
  Future<Message1Response> changePlanBrandType(
      @Part(name: "id") int id,
      @Part(name: "brandType") int brandType
      );

  @POST("/reci/getAllRepReci.php")//
  Future<AllReciBaseResponse> getAllRepReci(
    @Part(name: "repId") int repDet,
  );
  @POST("/admin/getDocInfo.php")//
  Future<InfoDoctorBaseResponse> getDocInfo(
    @Part(name: "docId") int docId,
  );
  @POST("/reci/updateReci.php")//
  Future<Message1Response> updateReci(
    @Part(name: "reciId") int reciId,
    @Part(name: "recipeType") int recipeType,
    @Part(name: "repId") String repId,
    @Part(name: "type") String type,
    @Part(name: "docId") String docId,
    @Part(name: "spName") String spName,
    @Part(name: "brand_1") String brand_1,
    @Part(name: "address") String address,
    @Part(name: "phone") String phone,
    @Part(name: "total") String total,
    @Part(name: "create_date") String create_date, {
    @Part(name: "note1") String? note1,
    @Part(name: "note2") String? note2,
    @Part(name: "flagImage1") String? flagImage1,
    @Part(name: "flagImage2") String? flagImage2,
    @Part(name: "note_emp") String? note_emp,
    @Part(name: "image1") File? image1,
    @Part(name: "image2") File? image2,
    @Part(name: "brand_2") String? brand_2,
    @Part(name: "brand_3") String? brand_3,
    @Part(name: "brand_4") String? brand_4,
    @Part(name: "print_date") String? print_date,
    @Part(name: "active") String? active,
  });

  @POST("/admin/getinfoPlanBrandsType.php")
  Future<ActiveBrandPlanBaseResponse> getinfoPlanBrandsType(
    @Part(name: "repPlanId") int repPlanId,
  );
  @POST("/pharmacyOrder.php")
  Future<Message1Response> pharmacyOrder(@Body() PharmacyOrderRequestBody list);

  @POST("/checkPlanStatus.php")
  Future<CheckBaseResponse> checkPlanBrand(
      @Part(name: "repPlanId") int repPlanId,
      );

  @POST("/admin/getRepsFuture.php")
  Future<AllRepresentativeFutureBaseResponse> getRepsFuture(
      @Part(name: "repDet") int id,
      );


  @POST("/admin/changeRepPlanStatus.php")
  Future<Message1Response> changeRepPlanStatus(
      @Part(name: "id") int id,
      @Part(name: "status") int status,
      );


  @POST("/admin/getVisitReadStatus.php")
  Future<AllReadResponse> getVisitReadStatus(
      @Part(name: "VisitId") String visitId,
      @Part(name: "visitType") String visitType,
      );
  @POST("/admin/getSeniorByCityid.php")
  Future<SeniorByCityidBaseResponse> getSeniorByCityid(
      @Part(name: "cityId") int cityId,
      );
  @POST("/admin/getCityAndTeamleader.php")
  Future<SeniorByCityidBaseResponse> getCityAndTeamleader();



  @POST("/admin/getHospitalsNotes.php")
  Future<AllSearchHospitalNoteBaseResponse> getSearchHospitalsNotes(
      @Part(name: "hosId") int hosId,
      @Part(name: "spId") int spId,
      );
  @POST("/admin/getHospitals.php")
  Future<AllSearchHospitalBaseResponse> getSearchHospitals(
      @Part(name: "name") String name,
      );
  @POST("/admin/updateRepPlanBrandAmount.php")
  Future<Message1Response> updateRepPlanBrandAmount(
      @Body() BrandAmountRequestBody list);

  @POST("/admin/getFinishedPlans.php")
  Future<FinishedPlansBaseResponse> getFinishedPlans(
      @Part(name: "cityId") int cityId,
      );

  @POST("/admin/getPlanReps.php")
  Future<PlanRepsBaseResponse> getPlanReps(
      @Part(name: "planId") int planId,
      );
}
