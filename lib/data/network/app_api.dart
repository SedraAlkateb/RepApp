import 'package:domina_app/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  @POST("/logout")
  Future<MessageResponse> logout(
      );
  @POST("/loginSuperAdmin")
  Future<TokenResponse> login(
      @Part(name: "email") String email,
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
      );
  @POST("/getAllPharmacy.php")
  Future<AllPharmacyBaseResponse> getAllPharmacy(
      @Part(name: "repDet") int repDet,
      );
}
