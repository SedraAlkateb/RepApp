
import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;
}
//////////ForMessage
@JsonSerializable()
class Message1Response extends BaseResponse{
  Message1Response();
  // from json
  factory Message1Response.fromJson(Map<String,dynamic>json)=>
      _$Message1ResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$Message1ResponseToJson(this);
}

@JsonSerializable()
class MessageResponse extends BaseResponse{
  @JsonKey(name: "message")
  String? message;
  MessageResponse(this.message);
  // from json
  factory MessageResponse.fromJson(Map<String,dynamic>json)=>
      _$MessageResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$MessageResponseToJson(this);
}
@JsonSerializable()
class CheckResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "active")
  String? active;
  CheckResponse(this.id,this.active);
  // from json
  factory CheckResponse.fromJson(Map<String,dynamic>json)=>
      _$CheckResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$CheckResponseToJson(this);
}
@JsonSerializable()
class CheckBaseResponse extends BaseResponse{
  @JsonKey(name: "representativePlan_Status")
  CheckResponse data;
  CheckBaseResponse(this.data);
  // from json
  factory CheckBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$CheckBaseResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$CheckBaseResponseToJson(this);
}

@JsonSerializable()
class CheckActiveResponse {
  @JsonKey(name: "activePlanId")
  String? activePlanId;
  @JsonKey(name: "otherPlanId")
  String? otherPlanId;
  @JsonKey(name: "otherstatus")
  String? otherstatus;
  CheckActiveResponse(this.activePlanId,this.otherPlanId,this.otherstatus);
  // from json
  factory CheckActiveResponse.fromJson(Map<String,dynamic>json)=>
      _$CheckActiveResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$CheckActiveResponseToJson(this);
}
@JsonSerializable()
class CheckActiveBaseResponse extends BaseResponse{
  @JsonKey(name: "representativePlans")
  CheckActiveResponse data;
  CheckActiveBaseResponse(this.data);
  // from json
  factory CheckActiveBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$CheckActiveBaseResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$CheckActiveBaseResponseToJson(this);
}

@JsonSerializable()
class TokenResponse {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "repId")
  String? repId;
  @JsonKey(name: "otherPlanId")
  String? otherPlanId;
  @JsonKey(name: "activePlanId")
  String? activePlanId;
  @JsonKey(name: "otherstatus")
  String? otherstatus;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "percentage")
  int? percentage;
  TokenResponse(this.token,this.repId,this.otherPlanId,this.activePlanId,this.name,this.percentage);
  // from json
  factory TokenResponse.fromJson(Map<String,dynamic>json)=>
      _$TokenResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$TokenResponseToJson(this);
}

@JsonSerializable()
class BrandSpResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "spId")
  String? spId;
  @JsonKey(name: "brandId")
  String? brandId;
  @JsonKey(name: "brandType")
  String? brandType;

  BrandSpResponse(this.id, this.spId, this.brandId, this.brandType);

  factory BrandSpResponse.fromJson(Map<String,dynamic>json)=>
      _$BrandSpResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$BrandSpResponseToJson(this);
}
@JsonSerializable()
class AllBrandSpResponse {
  @JsonKey(name: "brands_specializations")
  List<BrandSpResponse>? brandsSpecializations;
  AllBrandSpResponse(this.brandsSpecializations);
  // from json
  factory AllBrandSpResponse.fromJson(Map<String,dynamic>json)=>
      _$AllBrandSpResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllBrandSpResponseToJson(this);
}
@JsonSerializable()
class AllBrandSpBaseResponse extends BaseResponse{
  @JsonKey(name: "brands_specializations")
  AllBrandSpResponse? data;
  AllBrandSpBaseResponse(this.data);
  // from json
  factory AllBrandSpBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllBrandSpBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllBrandSpBaseResponseToJson(this);
}



@JsonSerializable()
class LoginResponse extends BaseResponse{
  @JsonKey(name: "data")
  TokenResponse? data;
  LoginResponse(this.data);
  // from json
  factory LoginResponse.fromJson(Map<String,dynamic>json)=>
      _$LoginResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$LoginResponseToJson(this);
}
@JsonSerializable()
class PlaceResponse {

  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  PlaceResponse(
      this.id,
      this.title
      );
  // from json
  factory PlaceResponse.fromJson(Map<String,dynamic>json)=>
      _$PlaceResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$PlaceResponseToJson(this);
}
@JsonSerializable()
class AllPlaceResponse {
  @JsonKey(name: "Places")
  List<PlaceResponse>? places;
  AllPlaceResponse(this.places);
  // from json
  factory AllPlaceResponse.fromJson(Map<String,dynamic>json)=>
      _$AllPlaceResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllPlaceResponseToJson(this);
}
@JsonSerializable()
class AllPlaceBaseResponse extends BaseResponse{
  @JsonKey(name: "Places")
  AllPlaceResponse? data;
  AllPlaceBaseResponse(this.data);
  // from json
  factory AllPlaceBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllPlaceBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllPlaceBaseResponseToJson(this);
}
@JsonSerializable()
class SpecResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  SpecResponse(this.id,this.title);
  // from json
  factory SpecResponse.fromJson(Map<String,dynamic>json)=>
      _$SpecResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$SpecResponseToJson(this);
}
@JsonSerializable()
class AllSpcResponse {
  @JsonKey(name: "Specializations")
  List<SpecResponse> ?specializations;
  AllSpcResponse(this.specializations);
  // from json
  factory AllSpcResponse.fromJson(Map<String,dynamic>json)=>
      _$AllSpcResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllSpcResponseToJson(this);
}
@JsonSerializable()
class AllSpcBaseResponse extends BaseResponse{
  @JsonKey(name: "Specializations")
  AllSpcResponse? data;
  AllSpcBaseResponse(this.data);
  // from json
  factory AllSpcBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllSpcBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllSpcBaseResponseToJson(this);
}
/////////////////////////////////////////////////////////////////////////
@JsonSerializable()
class MedicalVisitsResponse {
  @JsonKey(name: "visID")
  String? visID;
  @JsonKey(name: "visitDate")
  String? visitDate;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "note")
  String? note;
  @JsonKey(name: "issue")
  String? issue;
  @JsonKey(name: "spTitle")
  String? spTitle;
  @JsonKey(name: "special")
  String? special;
  @JsonKey(name: "brands")
  String? brands;


  MedicalVisitsResponse(
      this.visID,
      this.visitDate,
      this.title,
      this.address,
      this.note,
      this.issue,
      this.spTitle,
      this.special,
      this.brands); // from json
  factory MedicalVisitsResponse.fromJson(Map<String,dynamic>json)=>
      _$MedicalVisitsResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$MedicalVisitsResponseToJson(this);
}
@JsonSerializable()
class AllMedicalVisitResponse {
  @JsonKey(name: "Medical Representative Visits")
  List<MedicalVisitsResponse>? medicalVisits;
  AllMedicalVisitResponse(this.medicalVisits);
  // from json
  factory AllMedicalVisitResponse.fromJson(Map<String,dynamic>json)=>
      _$AllMedicalVisitResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllMedicalVisitResponseToJson(this);
}
@JsonSerializable()
class AllMedicalVisitBaseResponse extends BaseResponse{
  @JsonKey(name: "Medical Representative Visits")
  AllMedicalVisitResponse ?data;
  AllMedicalVisitBaseResponse(this.data);
  // from json
  factory AllMedicalVisitBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllMedicalVisitBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllMedicalVisitBaseResponseToJson(this);
}
///////////////////////////////////////////////////////////

@JsonSerializable()
class CityResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  CityResponse(this.id,this.name);
  // from json
  factory CityResponse.fromJson(Map<String,dynamic>json)=>
      _$CityResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$CityResponseToJson(this);
}
@JsonSerializable()
class AllCityResponse {
  @JsonKey(name: "City")
  List<CityResponse>? city;
  AllCityResponse(this.city);
  // from json
  factory AllCityResponse.fromJson(Map<String,dynamic>json)=>
      _$AllCityResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllCityResponseToJson(this);
}
@JsonSerializable()
class AllCityBaseResponse extends BaseResponse{
  @JsonKey(name: "City")
  AllCityResponse ?data;
  AllCityBaseResponse(this.data);
  // from json
  factory AllCityBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllCityBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllCityBaseResponseToJson(this);
}

@JsonSerializable()
class AllMedicalRepresentativeResponse {
  @JsonKey(name: "Medical Representative")
  List<CityResponse> ?MedicalRepresentative;
  AllMedicalRepresentativeResponse(this.MedicalRepresentative);
  // from json
  factory AllMedicalRepresentativeResponse.fromJson(Map<String,dynamic>json)=>
      _$AllMedicalRepresentativeResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllMedicalRepresentativeResponseToJson(this);
}
@JsonSerializable()
class AllMedicalRepresentativeBaseResponse extends BaseResponse{
  @JsonKey(name: "Medical Representative")
  AllMedicalRepresentativeResponse? data;
  AllMedicalRepresentativeBaseResponse(this.data);
  // from json
  factory AllMedicalRepresentativeBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllMedicalRepresentativeBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllMedicalRepresentativeBaseResponseToJson(this);
}



@JsonSerializable()
class BrandResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "phTitle")
  String? phTitle;
  @JsonKey(name: "falg")
  int? falg;
  @JsonKey(name: "sampleCoast")
  String? sampleCoast;
  BrandResponse(this.id,this.title,this.phTitle,this.falg,this.sampleCoast);
  // from json
  factory BrandResponse.fromJson(Map<String,dynamic>json)=>
      _$BrandResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$BrandResponseToJson(this);
}
@JsonSerializable()
class AllBrandResponse {
  @JsonKey(name: "Brands")
  List<BrandResponse>? brands;
  AllBrandResponse(this.brands);
  // from json
  factory AllBrandResponse.fromJson(Map<String,dynamic>json)=>
      _$AllBrandResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllBrandResponseToJson(this);
}
@JsonSerializable()
class AllBrandBaseResponse extends BaseResponse{
  @JsonKey(name: "Brands")
  AllBrandResponse ?data;
  AllBrandBaseResponse(this.data);
  // from json
  factory AllBrandBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllBrandBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllBrandBaseResponseToJson(this);
}


@JsonSerializable()
class PharmacyResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "placeId")
  String? placeId;
  @JsonKey(name: "address")
  String? address;
  PharmacyResponse(this.id,this.title,this.placeId,this.address);
  // from json
  factory PharmacyResponse.fromJson(Map<String,dynamic>json)=>
      _$PharmacyResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$PharmacyResponseToJson(this);
}
@JsonSerializable()
class AllPharmacyResponse {
  @JsonKey(name: "Pharmacy")
  List<PharmacyResponse>? pharmacy;
  AllPharmacyResponse(this.pharmacy);
  // from json
  factory AllPharmacyResponse.fromJson(Map<String,dynamic>json)=>
      _$AllPharmacyResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllPharmacyResponseToJson(this);
}
@JsonSerializable()
class AllPharmacyBaseResponse extends BaseResponse{
  @JsonKey(name: "Pharmacy")
  AllPharmacyResponse ?data;
  AllPharmacyBaseResponse(this.data);
  // from json
  factory AllPharmacyBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllPharmacyBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllPharmacyBaseResponseToJson(this);
}
@JsonSerializable()
class HospitalResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "placeId")
  String? placeId;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "placeTitle")
  String? placeTitle;
    @JsonKey(name: "note")
  String? note;
  HospitalResponse(this.id,this.title,this.placeId,this.address,this.placeTitle,this.note);
  factory HospitalResponse.fromJson(Map<String,dynamic>json)=>
      _$HospitalResponseFromJson(json);
  Map<String,dynamic>toJson()=>
      _$HospitalResponseToJson(this);
}
//////
@JsonSerializable()
class DoctorResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "placeId")
  String? placeId;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "spId")
  String? spId;
    @JsonKey(name: "placeTitle")
  String? placeTitle;
    @JsonKey(name: "visits")
  String? visits;
    @JsonKey(name: "note")
  String? note;
    @JsonKey(name: "rate")
  String? rate;
      @JsonKey(name: "spTitle")
  String? spTitle;

  DoctorResponse(this.id,this.title,this.placeId,this.address,this.spId,this.placeTitle,this.visits,this.note,this.rate,this.spTitle);
  // from json
  factory DoctorResponse.fromJson(Map<String,dynamic>json)=>
      _$DoctorResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$DoctorResponseToJson(this);
}
@JsonSerializable()
class AllDoctorResponse{
  @JsonKey(name: "Doctors")
  List<DoctorResponse> ?doctor;
  AllDoctorResponse(this.doctor);
  // from json
  factory AllDoctorResponse.fromJson(Map<String,dynamic>json)=>
      _$AllDoctorResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllDoctorResponseToJson(this);
}
@JsonSerializable()
class AllDoctorsBaseResponse extends BaseResponse{
  @JsonKey(name: "Doctors")
  AllDoctorResponse? data;
  AllDoctorsBaseResponse(this.data);
  // from json
  factory AllDoctorsBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllDoctorsBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllDoctorsBaseResponseToJson(this);
}

//////
@JsonSerializable()
class AllHospitalResponse{
  @JsonKey(name: "Hospital")
  List<HospitalResponse>? hospital;
  AllHospitalResponse(this.hospital);
  // from json
  factory AllHospitalResponse.fromJson(Map<String,dynamic>json)=>
      _$AllHospitalResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllHospitalResponseToJson(this);
}
@JsonSerializable()
class
AllHospitalBaseResponse extends BaseResponse{
  @JsonKey(name: "Hospital")
  AllHospitalResponse? data;
  AllHospitalBaseResponse(this.data);
  // from json
  factory AllHospitalBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllHospitalBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllHospitalBaseResponseToJson(this);
}

@JsonSerializable()
class AllHospitalSpResponse{
  @JsonKey(name: "Hospital")
  List<HospitalSpResponse>? HospitalSp;
  AllHospitalSpResponse(this.HospitalSp);
  // from json
  factory AllHospitalSpResponse.fromJson(Map<String,dynamic>json)=>
      _$AllHospitalSpResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllHospitalSpResponseToJson(this);
}
@JsonSerializable()
class
AllHospitalSpBaseResponse extends BaseResponse{
  @JsonKey(name: "HospitalSp")
  AllHospitalSpResponse? data;
  AllHospitalSpBaseResponse(this.data);
  // from json
  factory AllHospitalSpBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllHospitalSpBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllHospitalSpBaseResponseToJson(this);
}
@JsonSerializable()
class HospitalSpResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "hospitalId")
  String? hospitalId;
  @JsonKey(name: "spId")
  String? spId;
  @JsonKey(name: "totalDocs")
  String? totalDocs;
  @JsonKey(name: "rate")
  String? rate;
  @JsonKey(name: "visit")
  String? visit;

  HospitalSpResponse(this.id, this.hospitalId, this.spId, this.totalDocs,
      this.rate, this.visit); // from json
  factory HospitalSpResponse.fromJson(Map<String,dynamic>json)=>
      _$HospitalSpResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$HospitalSpResponseToJson(this);
}



/////////////////////
@JsonSerializable()
class PlanBrandResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "repPlanId")
  String? repPlanId;
  @JsonKey(name: "brandId")
  String? brandId;
  @JsonKey(name: "brandType")
  String? brandType;
  @JsonKey(name: "spId")
  String? spId;
  @JsonKey(name: "amount")
  String? amount;

  PlanBrandResponse(this.id, this.repPlanId, this.brandId, this.brandType,
      this.spId, this.amount);
  // from json
  factory PlanBrandResponse.fromJson(Map<String,dynamic>json)=>
      _$PlanBrandResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$PlanBrandResponseToJson(this);
}
@JsonSerializable()
class AllPlanBrandResponse{
  @JsonKey(name: "representPlan_brands")
  List<PlanBrandResponse> ?planBrand;
  AllPlanBrandResponse(this.planBrand);
  // from json
  factory AllPlanBrandResponse.fromJson(Map<String,dynamic>json)=>
      _$AllPlanBrandResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllPlanBrandResponseToJson(this);
}
@JsonSerializable()
class AllPlanBrandsBaseResponse extends BaseResponse{
  @JsonKey(name: "representativeActivePlan_brands")
  AllPlanBrandResponse? data;
  AllPlanBrandsBaseResponse(this.data);
  // from json
  factory AllPlanBrandsBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllPlanBrandsBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllPlanBrandsBaseResponseToJson(this);
}
