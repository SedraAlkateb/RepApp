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

  @POST("/loginU.php")
  Future<LoginResponse> login(
    @Part(name: "userName") String userName,
    @Part(name: "password") String password,
    @Part(name: "ver") int ver,
  );
  @POST("/getAllPlace.php")
  Future<AllPlaceBaseResponse> allPlace(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getAllSp.php")
  Future<AllSpcBaseResponse> allSpecializations(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getVisitDoc.php")
  Future<AllMedicalVisitBaseResponse> allVisitDoctor(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getCity.php")
  Future<AllCityBaseResponse> allCity();

  @POST("/getAllBrand.php")
  Future<AllBrandBaseResponse> allBrand(
    @Part(name: "repPlanId") int repPlanId,
  );
  @POST("/getAllPharmacy.php")
  Future<AllPharmacyBaseResponse> getAllPharmacy(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getAllDoctor.php")
  Future<AllDoctorsBaseResponse> getAllDoctor(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getAllHospital.php")
  Future<AllHospitalBaseResponse> getAllHospital(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getAllHospitalSp.php")
  Future<AllHospitalSpBaseResponse> getAllHospitalSp(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getBrandsSp.php")
  Future<AllBrandSpBaseResponse> getBrandsSp(
    @Part(name: "repDet") int repDet,
  );
  @POST("/getAllPlanBrands.php")
  Future<AllPlanBrandsBaseResponse> getAllPlanBrands(
    @Part(name: "repPlanIdActive") int repPlanIdActive,
    @Part(name: "repPlanIdOther") int repPlanIdOther,
  );
  @POST("/getHosVisit.php")
  Future<VisitHospitalBaseResponse> getHosVisit(
    @Part(name: "repPlanId") int repPlanId,
    @Part(name: "representativeId") int representativeId,
  );
  @POST("/getDocVisit.php")
  Future<VisitDoctorBaseResponse> getDocVisit(
    @Part(name: "repPlanId") String repPlanId,
    @Part(name: "representativeId") String representativeId,
  );

  @POST("/insertPlanBrands.php")
  Future<Message1Response> repPlanBrand(@Body() RepPlanBrandBody list);
  @POST("/pharmacyVisit.php")
  Future<Message1Response> visitPharmacy(@Body() VisitPharmacyRequestBody list);
  @POST("/docVisit.php")
  Future<Message1Response> visitDoctor(@Body() VisitDoctorRequestBody list);
  @POST("/hosVisit.php")
  Future<Message1Response> visitHospital(@Body() VisitHospitalRequestBody list);

  @POST("/checkPlanStatus.php")
  Future<CheckBaseResponse> checkPlanBrand(
    @Part(name: "repPlanId") int repPlanId,
  );
  @POST("/getPlans.php")
  Future<LoginResponse> checkActivePlanBrand(
      @Part(name: "repDet") int repDet, @Part(name: "ver") int ver);
  @POST("/reci/getBrands.php")
  Future<AllBrandResResponse> getBrandRes(
    @Part(name: "repDet") int repDet,
  );
  @POST("/reci/checkRe.php")
  Future<CheckReResponse> checkRe(@Part(name: "repDet") int repDet);
  @POST("/reci/checkRep.php")
  Future<CheckRepResponse> checkRep(@Part(name: "repDet") int repDet);
  @POST("/reci/insertReci.php")
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
  @POST("/reci/reciNum.php")
  Future<ReciNumResponse> reciNum();
  // @POST("/hosVisit.php")
  // Future<List<VisitHospitalRequestBody>> uploadVisitHospital();
  @POST("/reci/copyRe.php")
  Future<CopyRecResponse> copyReci(
    @Part(name: "docId") int docId,
    @Part(name: "recipeType") String recipeType,
  );

  @POST("/admin/getReps.php")
  Future<AllRepresentativeBaseResponse> getReps(
      @Part(name: "repDet") int id,

      );
  @POST("/admin/getVisitNotes.php")
  Future<AllVisitNotesBaseResponse> getVisitNotes(
    @Part(name: "repDet") int docId,
  );
  @POST("/admin/noVisitDoc.php")
  Future<AllNoVisitDoctorBaseResponse> noVisitDoc(
    @Part(name: "repDet") int docId,
  );
  @POST("/admin/visitDoc.php")
  Future<AllNoVisitDoctorBaseResponse> visitDoc(
      @Part(name: "repDet") int docId,
      );
  @POST("/admin/getVisitIssue.php")
  Future<AllVisitIssueBaseResponse> getVisitIssue(
      @Part(name: "repDet") int id,
      );
  @POST("/insertLog.php")
  Future<Message1Response> insertLog(@Body() ExceptionRequestBody list);

  @POST("/admin/inventory.php")
  Future<InventoryResponseBaseResponse> getInventory(
      @Part(name: "repDet") int id,

      );
  @POST("/admin/getRepInfo.php")
  Future<AllRepInfoResponseBaseResponse> getRepInfo(
      @Part(name: "repDet") int id
      );



}
