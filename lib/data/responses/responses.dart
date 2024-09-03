
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

class BaseResponse {
  int? st;
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
class TokenResponse extends BaseResponse{
  @JsonKey(name: "token")
  String? token;
  TokenResponse(this.token);
  // from json
  factory TokenResponse.fromJson(Map<String,dynamic>json)=>
      _$TokenResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$TokenResponseToJson(this);
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
  List<PlaceResponse> places;
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
  AllPlaceResponse data;
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
  List<SpecResponse> specializations;
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
  AllSpcResponse data;
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
  List<MedicalVisitsResponse> medicalVisits;
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
  AllMedicalVisitResponse data;
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
  List<CityResponse> city;
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
  AllCityResponse data;
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
  List<CityResponse> MedicalRepresentative;
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
  AllMedicalRepresentativeResponse data;
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
  BrandResponse(this.id,this.title,this.phTitle);
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
  List<BrandResponse> brands;
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
  AllBrandResponse data;
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
  List<PharmacyResponse> pharmacy;
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
  AllPharmacyResponse data;
  AllPharmacyBaseResponse(this.data);
  // from json
  factory AllPharmacyBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllPharmacyBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllPharmacyBaseResponseToJson(this);
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
    @JsonKey(name: "placeTitle")
  String? placeTitle;
    @JsonKey(name: "visits")
  String? visits;
    @JsonKey(name: "spTitle")
  String? spTitle;
  DoctorResponse(this.id,this.title,this.placeId,this.address,this.placeTitle,this.visits,this.spTitle);
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
  List<DoctorResponse> doctor;
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
  AllDoctorResponse data;
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
  List<DoctorResponse>? hospital;
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