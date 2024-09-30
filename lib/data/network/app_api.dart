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
  @POST("/logout")
  Future<MessageResponse> logout(
      );
  @POST("/loginU.php")
  Future<LoginResponse> login(
      @Part(name: "userName") String userName,
      @Part(name: "password") String password,
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
  Future<AllCityBaseResponse> allCity(
      );
  @POST("/getRep.php")
  Future<AllMedicalRepresentativeBaseResponse> allMedicalRepresentative(
      @Part(name: "repDet") int repDet,
      );
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
  @POST("/pharmacyVisit.php")
  Future<Message1Response> visitPharmacy(
      @Body() VisitPharmacyRequestBody list
      );

  @POST("/visitDoctor.php")
  Future<Message1Response> visitDoctor(
      @Body() VisitDoctorRequestBody list
      );
  @POST("/visitDoctor.php")
  Future<Message1Response> visitHospital(
      @Body() VisitHospitalRequestBody list
      );
/*
  @POST("/visitDoctorBrand.php")
  Future<MessageResponse> visitDoctorBrand(
      @Body() List<VisitBrandDoctorModel> list
      );
  @POST("/visitHospital.php")
  Future<MessageResponse> visitHospital(
      @Body() List<VisitHospitalModel> list
      );
  @POST("/visitHospitalBrand.php")
  Future<MessageResponse> visitHospitalBrand(
      @Body() List<VisitBrandHospitalModel> list
      );
 */
}
