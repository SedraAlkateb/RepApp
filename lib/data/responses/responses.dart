import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

class BaseResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;
}

//////////ForMessage
@JsonSerializable()
class Message1Response extends BaseResponse {
  Message1Response();
  // from json
  factory Message1Response.fromJson(Map<String, dynamic> json) =>
      _$Message1ResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$Message1ResponseToJson(this);
}

@JsonSerializable()
class MessageResponse extends BaseResponse {
  @JsonKey(name: "message")
  String? message;
  MessageResponse(this.message);
  // from json
  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);
}

@JsonSerializable()
class CheckResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "active")
  String? active;
  CheckResponse(this.id, this.active);
  // from json
  factory CheckResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$CheckResponseToJson(this);
}

@JsonSerializable()
class CheckBaseResponse extends BaseResponse {
  @JsonKey(name: "representativePlan_Status")
  CheckResponse data;
  CheckBaseResponse(this.data);
  // from json
  factory CheckBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckBaseResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$CheckBaseResponseToJson(this);
}

@JsonSerializable()
class ReciNumResponse extends BaseResponse {
  @JsonKey(name: "recICounts")
  List<int>? recICounts;
  ReciNumResponse(this.recICounts);
  // from json
  factory ReciNumResponse.fromJson(Map<String, dynamic> json) =>
      _$ReciNumResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReciNumResponseToJson(this);
}

@JsonSerializable()
class BrandReResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title_en")
  String? title_en;
  BrandReResponse(this.id, this.title_en);
  // from json
  factory BrandReResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandReResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$BrandReResponseToJson(this);
}

@JsonSerializable()
class AllBrandResResponse extends BaseResponse {
  @JsonKey(name: "representativePlan_Status")
  List<BrandReResponse>? brandRes;
  AllBrandResResponse(this.brandRes);
  // from json
  factory AllBrandResResponse.fromJson(Map<String, dynamic> json) =>
      _$AllBrandResResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllBrandResResponseToJson(this);
}

@JsonSerializable()
class CheckReResponse extends BaseResponse {
  @JsonKey(name: "total")
  String? total;
  @JsonKey(name: "accepted")
  bool? accepted;
  CheckReResponse(this.total, this.accepted);
  // from json
  factory CheckReResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckReResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$CheckReResponseToJson(this);
}

@JsonSerializable()
class CheckRepResponse extends BaseResponse {
  @JsonKey(name: "accepted")
  bool? accepted;
  CheckRepResponse(this.accepted);
  // from json
  factory CheckRepResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckRepResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$CheckRepResponseToJson(this);
}
/////CopyReecResponse//////

@JsonSerializable()
class CopyRecResponse extends BaseResponse {
  @JsonKey(name: "recip")
  CopyRecipResponse? recip;
  CopyRecResponse(this.recip);
  // from json
  factory CopyRecResponse.fromJson(Map<String, dynamic> json) =>
      _$CopyRecResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$CopyRecResponseToJson(this);
}

@JsonSerializable()
class CopyRecipResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "repId")
  String? repId;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "docId")
  String? docId;
  @JsonKey(name: "spName")
  String? spName;
  @JsonKey(name: "brand_1")
  BrandRecipesResponse? brand_1;
  @JsonKey(name: "brand_2")
  BrandRecipesResponse? brand_2;
  @JsonKey(name: "brand_3")
  BrandRecipesResponse? brand_3;
  @JsonKey(name: "brand_4")
  BrandRecipesResponse? brand_4;
  @JsonKey(name: "note1")
  String? note1;
  @JsonKey(name: "note2")
  String? note2;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "total")
  String? total;
  @JsonKey(name: "note_emp")
  String? note_emp;
  @JsonKey(name: "image1")
  String? image1;
  @JsonKey(name: "image2")
  String? image2;
  @JsonKey(name: "print_date")
  String? print_date;
  @JsonKey(name: "create_date")
  String? create_date;

  CopyRecipResponse(
    this.id,
    this.repId,
    this.type,
    this.docId,
    this.spName,
    this.brand_1,
    this.brand_2,
    this.brand_3,
    this.brand_4,
    this.note1,
    this.note2,
    this.address,
    this.phone,
    this.total,
    this.note_emp,
    this.image1,
    this.image2,
    this.create_date,
    this.print_date,
  );

  // from json
  factory CopyRecipResponse.fromJson(Map<String, dynamic> json) =>
      _$CopyRecipResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$CopyRecipResponseToJson(this);
}

@JsonSerializable()
class CheckActiveResponse {
  @JsonKey(name: "activePlanId")
  String? activePlanId;
  @JsonKey(name: "otherPlanId")
  String? otherPlanId;
  @JsonKey(name: "otherstatus")
  String? otherstatus;
  CheckActiveResponse(this.activePlanId, this.otherPlanId, this.otherstatus);
  factory CheckActiveResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckActiveResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckActiveResponseToJson(this);
}

@JsonSerializable()
class BrandRecipesResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title_en")
  String? title_en;
  BrandRecipesResponse(this.id, this.title_en);
  factory BrandRecipesResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandRecipesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BrandRecipesResponseToJson(this);
}

@JsonSerializable()
class CheckActiveBaseResponse extends BaseResponse {
  @JsonKey(name: "representativePlans")
  CheckActiveResponse data;
  CheckActiveBaseResponse(this.data);
  factory CheckActiveBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckActiveBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckActiveBaseResponseToJson(this);
}

@JsonSerializable()
class TokenResponse {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "cityId")
  String? cityId;
  @JsonKey(name: "cityTitle")
  String? cityTitle;
  @JsonKey(name: "repId")
  String? repId;
  @JsonKey(name: "otherPlanId")
  String? otherPlanId;
  @JsonKey(name: "samplesCount")
  String? samplesCount;
  @JsonKey(name: "activePlanId")
  String? activePlanId;
  @JsonKey(name: "otherPlanStatus")
  String? otherStatus;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "repType")
  String? repType;
  @JsonKey(name: "percentage")
  int? percentage;
  @JsonKey(name: "endDate")
  String? endDate;
  @JsonKey(name: "startDate")
  String? startDate;
  @JsonKey(name: "recipesCount")
  String? recipesCount;
  @JsonKey(name: "otherStartDate", defaultValue: "-9")
  String? otherStartDate;
  @JsonKey(name: "otherEndDate", defaultValue: "-9")
  String? otherEndDate;
  TokenResponse(
      this.token,
      this.cityId,
      this.cityTitle,
      this.repId,
      this.otherPlanId,
      this.activePlanId,
      this.otherStatus,
      this.name,
      this.percentage,
      this.startDate,
      this.endDate,
      this.recipesCount,
      this.otherStartDate,
      this.otherEndDate);
  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
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
  factory BrandSpResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandSpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BrandSpResponseToJson(this);
}

@JsonSerializable()
class AllBrandSpResponse {
  @JsonKey(name: "brands_specializations")
  List<BrandSpResponse>? brandsSpecializations;
  AllBrandSpResponse(this.brandsSpecializations);
  factory AllBrandSpResponse.fromJson(Map<String, dynamic> json) =>
      _$AllBrandSpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllBrandSpResponseToJson(this);
}

@JsonSerializable()
class AllBrandSpBaseResponse extends BaseResponse {
  @JsonKey(name: "brands_specializations")
  AllBrandSpResponse? data;
  AllBrandSpBaseResponse(this.data);
  factory AllBrandSpBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllBrandSpBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllBrandSpBaseResponseToJson(this);
}

@JsonSerializable()
class NoVisitDoctorResponse {
  @JsonKey(name: "docTitle")
  String? docTitle;
  @JsonKey(name: "spTitle")
  String? spTitle;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "rate")
  String? rate;
  @JsonKey(name: "visits")
  String? visits;
  @JsonKey(name: "remainingVisits")
  int? remainingVisits;
  @JsonKey(name: "doneVisits")
  String? doneVisits;
  NoVisitDoctorResponse(this.docTitle, this.spTitle, this.address, this.rate,
      this.visits, this.remainingVisits, this.doneVisits);
  factory NoVisitDoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$NoVisitDoctorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NoVisitDoctorResponseToJson(this);
}

@JsonSerializable()
class AllNoVisitDoctorResponse {
  @JsonKey(name: "Representative")
  List<NoVisitDoctorResponse>? res;
  AllNoVisitDoctorResponse(this.res);
  factory AllNoVisitDoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$AllNoVisitDoctorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllNoVisitDoctorResponseToJson(this);
}

@JsonSerializable()
class AllNoVisitDoctorBaseResponse extends BaseResponse {
  @JsonKey(name: "Representative")
  AllNoVisitDoctorResponse? data;
  AllNoVisitDoctorBaseResponse(this.data);
  factory AllNoVisitDoctorBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllNoVisitDoctorBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllNoVisitDoctorBaseResponseToJson(this);
}

//
@JsonSerializable()
class VisitIssueResponse {
  @JsonKey(name: "docTitle")
  String? docTitle;
  @JsonKey(name: "spTitle")
  String? spTitle;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "visitDate")
  String? visitDate;
  @JsonKey(name: "issue")
  String? issue;
  VisitIssueResponse(
      this.docTitle, this.spTitle, this.address, this.visitDate, this.issue);
  factory VisitIssueResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitIssueResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VisitIssueResponseToJson(this);
}

@JsonSerializable()
class AllVisitIssueResponse {
  @JsonKey(name: "Notes")
  List<VisitIssueResponse>? notes;
  AllVisitIssueResponse(this.notes);
  factory AllVisitIssueResponse.fromJson(Map<String, dynamic> json) =>
      _$AllVisitIssueResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllVisitIssueResponseToJson(this);
}

@JsonSerializable()
class AllVisitIssueBaseResponse extends BaseResponse {
  @JsonKey(name: "Notes")
  AllVisitIssueResponse? data;
  AllVisitIssueBaseResponse(this.data);
  factory AllVisitIssueBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllVisitIssueBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllVisitIssueBaseResponseToJson(this);
}

@JsonSerializable()
class VisitNotesResponse {
  @JsonKey(name: "docTitle")
  String? docTitle;
  @JsonKey(name: "spTitle")
  String? spTitle;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "visitDate")
  String? visitDate;
  @JsonKey(name: "note")
  String? note;
  VisitNotesResponse(
      this.docTitle, this.spTitle, this.address, this.visitDate, this.note);
  factory VisitNotesResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitNotesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VisitNotesResponseToJson(this);
}

@JsonSerializable()
class AllVisitNotesResponse {
  @JsonKey(name: "Notes")
  List<VisitNotesResponse>? notes;
  AllVisitNotesResponse(this.notes);
  factory AllVisitNotesResponse.fromJson(Map<String, dynamic> json) =>
      _$AllVisitNotesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllVisitNotesResponseToJson(this);
}

@JsonSerializable()
class AllVisitNotesBaseResponse extends BaseResponse {
  @JsonKey(name: "Notes")
  AllVisitNotesResponse? data;
  AllVisitNotesBaseResponse(this.data);
  factory AllVisitNotesBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllVisitNotesBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllVisitNotesBaseResponseToJson(this);
}

@JsonSerializable()
class LoginResponse extends BaseResponse {
  @JsonKey(name: "data")
  TokenResponse? data;
  LoginResponse(this.data);
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class PlaceResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  PlaceResponse(this.id, this.title);
  factory PlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$PlaceResponseToJson(this);
}

@JsonSerializable()
class AllPlaceResponse {
  @JsonKey(name: "Places")
  List<PlaceResponse>? places;
  AllPlaceResponse(this.places);
  // from json
  factory AllPlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$AllPlaceResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllPlaceResponseToJson(this);
}

@JsonSerializable()
class AllPlaceBaseResponse extends BaseResponse {
  @JsonKey(name: "Places")
  AllPlaceResponse? data;
  AllPlaceBaseResponse(this.data);
  // from json
  factory AllPlaceBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllPlaceBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllPlaceBaseResponseToJson(this);
}

@JsonSerializable()
class SpecResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "flag")
  int? flag;
  SpecResponse(this.id, this.title, this.flag);
  // from json
  factory SpecResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$SpecResponseToJson(this);
}

@JsonSerializable()
class AllSpcResponse {
  @JsonKey(name: "Specializations")
  List<SpecResponse>? specializations;
  AllSpcResponse(this.specializations);
  // from json
  factory AllSpcResponse.fromJson(Map<String, dynamic> json) =>
      _$AllSpcResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllSpcResponseToJson(this);
}

@JsonSerializable()
class AllSpcBaseResponse extends BaseResponse {
  @JsonKey(name: "Specializations")
  AllSpcResponse? data;
  AllSpcBaseResponse(this.data);
  // from json
  factory AllSpcBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllSpcBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllSpcBaseResponseToJson(this);
}

///////////////////////////////////////////////////////////

@JsonSerializable()
class CityResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? name;
  CityResponse(this.id, this.name);
  // from json
  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$CityResponseToJson(this);
}

@JsonSerializable()
class AllCityResponse {
  @JsonKey(name: "City")
  List<CityResponse>? city;
  AllCityResponse(this.city);
  // from json
  factory AllCityResponse.fromJson(Map<String, dynamic> json) =>
      _$AllCityResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllCityResponseToJson(this);
}

@JsonSerializable()
class AllCityBaseResponse extends BaseResponse {
  @JsonKey(name: "City")
  AllCityResponse? data;
  AllCityBaseResponse(this.data);
  // from json
  factory AllCityBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllCityBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllCityBaseResponseToJson(this);
}

@JsonSerializable()
class AllMedicalRepresentativeResponse {
  @JsonKey(name: "Medical Representative")
  List<CityResponse>? MedicalRepresentative;
  AllMedicalRepresentativeResponse(this.MedicalRepresentative);
  // from json
  factory AllMedicalRepresentativeResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AllMedicalRepresentativeResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() =>
      _$AllMedicalRepresentativeResponseToJson(this);
}

@JsonSerializable()
class AllMedicalRepresentativeBaseResponse extends BaseResponse {
  @JsonKey(name: "Medical Representative")
  AllMedicalRepresentativeResponse? data;
  AllMedicalRepresentativeBaseResponse(this.data);
  // from json
  factory AllMedicalRepresentativeBaseResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AllMedicalRepresentativeBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() =>
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
  BrandResponse(this.id, this.title, this.phTitle, this.falg, this.sampleCoast);
  // from json
  factory BrandResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$BrandResponseToJson(this);
}

@JsonSerializable()
class AllBrandResponse {
  @JsonKey(name: "Brands")
  List<BrandResponse>? brands;
  AllBrandResponse(this.brands);
  // from json
  factory AllBrandResponse.fromJson(Map<String, dynamic> json) =>
      _$AllBrandResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllBrandResponseToJson(this);
}

@JsonSerializable()
class AllBrandBaseResponse extends BaseResponse {
  @JsonKey(name: "Brands")
  AllBrandResponse? data;
  AllBrandBaseResponse(this.data);
  // from json
  factory AllBrandBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllBrandBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllBrandBaseResponseToJson(this);
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
  PharmacyResponse(this.id, this.title, this.placeId, this.address);
  // from json
  factory PharmacyResponse.fromJson(Map<String, dynamic> json) =>
      _$PharmacyResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$PharmacyResponseToJson(this);
}

@JsonSerializable()
class AllPharmacyResponse {
  @JsonKey(name: "Pharmacy")
  List<PharmacyResponse>? pharmacy;
  AllPharmacyResponse(this.pharmacy);
  // from json
  factory AllPharmacyResponse.fromJson(Map<String, dynamic> json) =>
      _$AllPharmacyResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllPharmacyResponseToJson(this);
}

@JsonSerializable()
class AllPharmacyBaseResponse extends BaseResponse {
  @JsonKey(name: "Pharmacy")
  AllPharmacyResponse? data;
  AllPharmacyBaseResponse(this.data);
  // from json
  factory AllPharmacyBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllPharmacyBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllPharmacyBaseResponseToJson(this);
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
  HospitalResponse(this.id, this.title, this.placeId, this.address,
      this.placeTitle, this.note);
  factory HospitalResponse.fromJson(Map<String, dynamic> json) =>
      _$HospitalResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HospitalResponseToJson(this);
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
  @JsonKey(name: "workHours")
  String? workHours;

  DoctorResponse(
      this.id,
      this.title,
      this.placeId,
      this.address,
      this.spId,
      this.placeTitle,
      this.visits,
      this.note,
      this.rate,
      this.spTitle,
      this.workHours);
  // from json
  factory DoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$DoctorResponseToJson(this);
}

@JsonSerializable()
class InfoDoctorBaseResponse extends BaseResponse {
  @JsonKey(name: "Doctors")
  DoctorResponse? data;
  InfoDoctorBaseResponse(this.data);
  factory InfoDoctorBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$InfoDoctorBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InfoDoctorBaseResponseToJson(this);
}

@JsonSerializable()
class AllDoctorResponse {
  @JsonKey(name: "Doctors")
  List<DoctorResponse>? doctor;
  AllDoctorResponse(this.doctor);
  // from json
  factory AllDoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$AllDoctorResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllDoctorResponseToJson(this);
}

@JsonSerializable()
class AllDoctorsBaseResponse extends BaseResponse {
  @JsonKey(name: "Doctors")
  AllDoctorResponse? data;
  AllDoctorsBaseResponse(this.data);
  // from json
  factory AllDoctorsBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllDoctorsBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllDoctorsBaseResponseToJson(this);
}

//////
@JsonSerializable()
class AllHospitalResponse {
  @JsonKey(name: "Hospital")
  List<HospitalResponse>? hospital;
  AllHospitalResponse(this.hospital);
  // from json
  factory AllHospitalResponse.fromJson(Map<String, dynamic> json) =>
      _$AllHospitalResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllHospitalResponseToJson(this);
}

@JsonSerializable()
class AllHospitalBaseResponse extends BaseResponse {
  @JsonKey(name: "Hospital")
  AllHospitalResponse? data;
  AllHospitalBaseResponse(this.data);
  // from json
  factory AllHospitalBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllHospitalBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllHospitalBaseResponseToJson(this);
}

@JsonSerializable()
class AllHospitalSpResponse {
  @JsonKey(name: "Hospital")
  List<HospitalSpResponse>? HospitalSp;
  AllHospitalSpResponse(this.HospitalSp);
  // from json
  factory AllHospitalSpResponse.fromJson(Map<String, dynamic> json) =>
      _$AllHospitalSpResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllHospitalSpResponseToJson(this);
}

@JsonSerializable()
class AllHospitalSpBaseResponse extends BaseResponse {
  @JsonKey(name: "HospitalSp")
  AllHospitalSpResponse? data;
  AllHospitalSpBaseResponse(this.data);
  // from json
  factory AllHospitalSpBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllHospitalSpBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllHospitalSpBaseResponseToJson(this);
}

@JsonSerializable()
class HospitalSpResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "hospitalId")
  String? hospitalId;
  @JsonKey(name: "spId")
  String? spId;
  /////////////////////////`-
  @JsonKey(name: "totalDocs")
  String? totalDocs;
  @JsonKey(name: "rate")
  String? rate;
  @JsonKey(name: "visit")
  String? visit;
  /////////////////////////////////////////////

  @JsonKey(name: "note")
  String? note;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "place")
  String? place;
  @JsonKey(name: "spTitle")
  String? spTitle;

  HospitalSpResponse(
      this.id,
      this.hospitalId,
      this.spId,
      this.totalDocs,
      this.rate,
      this.visit,
      this.note,
      this.title,
      this.address,
      this.place,
      this.spTitle);

  factory HospitalSpResponse.fromJson(Map<String, dynamic> json) =>
      _$HospitalSpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalSpResponseToJson(this);
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
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "spId")
  String? spId;
  @JsonKey(name: "amount")
  String? amount;
  @JsonKey(name: "pharmaceuticalForm")
  String? pharmaceuticalForm;

  PlanBrandResponse(this.id, this.repPlanId, this.brandId, this.brandType,
      this.spId, this.amount, this.pharmaceuticalForm);
  // from json
  factory PlanBrandResponse.fromJson(Map<String, dynamic> json) =>
      _$PlanBrandResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$PlanBrandResponseToJson(this);
}

@JsonSerializable()
class PlanBrandSpecResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "brandId")
  String? brandId;
  @JsonKey(name: "brandType")
  String? brandType;
  @JsonKey(name: "titleAr")
  String? titleAr;
  @JsonKey(name: "spId")
  String? spId;
  @JsonKey(name: "phTitle")
  String? phTitle;
  @JsonKey(name: "totalAmount")
  String? totalAmount;

  PlanBrandSpecResponse(this.id, this.titleAr, this.brandId, this.brandType,
      this.spId, this.phTitle, this.totalAmount);
  // from json
  factory PlanBrandSpecResponse.fromJson(Map<String, dynamic> json) =>
      _$PlanBrandSpecResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$PlanBrandSpecResponseToJson(this);
}

@JsonSerializable()
class SearchDoctorsJsonResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "spTitle")
  String? spTitle;
  @JsonKey(name: "placeTitle")
  String? placeTitle;

  SearchDoctorsJsonResponse(this.id, this.name, this.spTitle, this.placeTitle);
  // from json
  factory SearchDoctorsJsonResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchDoctorsJsonResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$SearchDoctorsJsonResponseToJson(this);
}

@JsonSerializable()
class DocDoctorsJsonResponse {
  @JsonKey(name: "repName")
  String? repName;
  @JsonKey(name: "visitDate")
  String? visitDate;
  @JsonKey(name: "issue")
  String? issue;
  @JsonKey(name: "note")
  String? note;

  DocDoctorsJsonResponse(this.repName, this.visitDate, this.issue, this.note);
  // from json
  factory DocDoctorsJsonResponse.fromJson(Map<String, dynamic> json) =>
      _$DocDoctorsJsonResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$DocDoctorsJsonResponseToJson(this);
}

@JsonSerializable()
class ReciResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "docName")
  String? docName;
  @JsonKey(name: "create_date")
  String? create_date;
  @JsonKey(name: "total")
  String? total;
  @JsonKey(name: "note_emp")
  String? note_emp;
  @JsonKey(name: "docId")
  String? docId;
  @JsonKey(name: "recipeType")
  String? recipeType;
  ReciResponse(this.id, this.docName, this.create_date, this.total,
      this.note_emp, this.docId, this.recipeType); // from json
  factory ReciResponse.fromJson(Map<String, dynamic> json) =>
      _$ReciResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$ReciResponseToJson(this);
}

@JsonSerializable()
class AllReciResponse {
  @JsonKey(name: 'Reci')
  List<ReciResponse> reci;

  AllReciResponse({
    required this.reci,
  });

  // from json
  factory AllReciResponse.fromJson(Map<String, dynamic> json) =>
      _$AllReciResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AllReciResponseToJson(this);
}

@JsonSerializable()
class AllReciBaseResponse extends BaseResponse {
  @JsonKey(name: "Reci")
  AllReciResponse? data;
  AllReciBaseResponse(this.data);
  // from json
  factory AllReciBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllReciBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllReciBaseResponseToJson(this);
}

@JsonSerializable()
class BrandAmountResponse {
  @JsonKey(name: 'totalSamplesDoctors')
  int? totalSamplesDoctors;

  @JsonKey(name: 'totalSamplesHospitals')
  int? totalSamplesHospitals;

  @JsonKey(name: 'totalSamplesDepartments')
  int? totalSamplesDepartments;

  BrandAmountResponse(this.totalSamplesDoctors, this.totalSamplesHospitals,
      this.totalSamplesDepartments); // from json
  factory BrandAmountResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandAmountResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$BrandAmountResponseToJson(this);
} //

@JsonSerializable()
class PlanBrandSpecWithSamplesResponse {
  @JsonKey(name: 'PlanBrands')
  List<PlanBrandSpecResponse> PlanBrands;

  @JsonKey(name: 'Brands')
  BrandAmountResponse brands;

  PlanBrandSpecWithSamplesResponse({
    required this.PlanBrands,
    required this.brands,
  });

  // from json
  factory PlanBrandSpecWithSamplesResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PlanBrandSpecWithSamplesResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() =>
      _$PlanBrandSpecWithSamplesResponseToJson(this);
}

@JsonSerializable()
class RepresentativeResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "unRead")
  int? unRead;
  @JsonKey(name: "activePlan")
  String? activePlan;

  RepresentativeResponse(this.id, this.name, this.unRead, this.activePlan);
  // from json
  factory RepresentativeResponse.fromJson(Map<String, dynamic> json) =>
      _$RepresentativeResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$RepresentativeResponseToJson(this);
}

@JsonSerializable()
class AllRepresentativeResponse {
  @JsonKey(name: "Representative")
  List<RepresentativeResponse>? data;
  AllRepresentativeResponse(this.data);
  // from json
  factory AllRepresentativeResponse.fromJson(Map<String, dynamic> json) =>
      _$AllRepresentativeResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllRepresentativeResponseToJson(this);
}

@JsonSerializable()
class AllRepresentativeBaseResponse extends BaseResponse {
  @JsonKey(name: "Representative")
  AllRepresentativeResponse? data;
  AllRepresentativeBaseResponse(this.data);
  // from json
  factory AllRepresentativeBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllRepresentativeBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllRepresentativeBaseResponseToJson(this);
}

//
@JsonSerializable()
class AllPlanBrandResponse {
  @JsonKey(name: "representPlan_brands")
  List<PlanBrandResponse>? planBrand;
  AllPlanBrandResponse(this.planBrand);
  // from json
  factory AllPlanBrandResponse.fromJson(Map<String, dynamic> json) =>
      _$AllPlanBrandResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllPlanBrandResponseToJson(this);
}

@JsonSerializable()
class RepPlanBrandSpResponse {
  @JsonKey(name: 'PlanBrands')
  List<PlanBrandSpecResponse>? PlanBrands;

  @JsonKey(name: 'Brands')
  BrandAmountResponse? Brands;

  RepPlanBrandSpResponse(this.PlanBrands, this.Brands);
  // from json
  factory RepPlanBrandSpResponse.fromJson(Map<String, dynamic> json) =>
      _$RepPlanBrandSpResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$RepPlanBrandSpResponseToJson(this);
}

@JsonSerializable()
class SearchDoctorsResponse {
  @JsonKey(name: 'Representative')
  List<SearchDoctorsJsonResponse>? Representative;
  SearchDoctorsResponse(this.Representative);
  // from json
  factory SearchDoctorsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchDoctorsResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$SearchDoctorsResponseToJson(this);
}

@JsonSerializable()
class DocDoctorsResponse {
  @JsonKey(name: 'Representative')
  List<DocDoctorsJsonResponse>? Representative;
  DocDoctorsResponse(this.Representative);
  // from json
  factory DocDoctorsResponse.fromJson(Map<String, dynamic> json) =>
      _$DocDoctorsResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$DocDoctorsResponseToJson(this);
}

@JsonSerializable()
class AllPlanBrandsBaseResponse extends BaseResponse {
  @JsonKey(name: "representativeActivePlan_brands")
  AllPlanBrandResponse? data;
  AllPlanBrandsBaseResponse(this.data);
  // from json
  factory AllPlanBrandsBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllPlanBrandsBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AllPlanBrandsBaseResponseToJson(this);
}

@JsonSerializable()
class PlanBrandsBaseSpResponse extends BaseResponse {
  @JsonKey(name: "PlanBrands")
  RepPlanBrandSpResponse? data;
  PlanBrandsBaseSpResponse(this.data);
  // from json
  factory PlanBrandsBaseSpResponse.fromJson(Map<String, dynamic> json) =>
      _$PlanBrandsBaseSpResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$PlanBrandsBaseSpResponseToJson(this);
}

@JsonSerializable()
class SearchDoctorsBaseSpResponse extends BaseResponse {
  @JsonKey(name: "Doctors")
  SearchDoctorsResponse? data;
  SearchDoctorsBaseSpResponse(this.data);
  // from json
  factory SearchDoctorsBaseSpResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchDoctorsBaseSpResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$SearchDoctorsBaseSpResponseToJson(this);
}

@JsonSerializable()
class DocDoctorsBaseResponse extends BaseResponse {
  @JsonKey(name: "Doctors")
  DocDoctorsResponse? data;
  DocDoctorsBaseResponse(this.data);
  factory DocDoctorsBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$DocDoctorsBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DocDoctorsBaseResponseToJson(this);
}

@JsonSerializable()
class VisitResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "repPlanId")
  String? repPlanId;
  @JsonKey(name: "representativeId")
  String? representativeId;
  @JsonKey(name: "docId")
  String? docId;
  @JsonKey(name: "visitDate")
  String? visitDate;
  @JsonKey(name: "note")
  String? note;
  @JsonKey(name: "issue")
  String? issue;
  @JsonKey(name: "special")
  String? special;
  @JsonKey(name: "target")
  String? target;

  VisitResponse(this.id, this.repPlanId, this.representativeId, this.docId,
      this.visitDate, this.note, this.issue, this.special, this.target);

  factory VisitResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$VisitResponseToJson(this);
}

@JsonSerializable()
class VisitHosResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "repPlanId")
  String? repPlanId;
  @JsonKey(name: "representativeId")
  String? representativeId;
  @JsonKey(name: "spId")
  String? docId;
  @JsonKey(name: "visitDate")
  String? visitDate;
  @JsonKey(name: "note")
  String? note;
  @JsonKey(name: "issue")
  String? issue;
  @JsonKey(name: "special")
  String? special;
  @JsonKey(name: "target")
  String? target;

  VisitHosResponse(this.id, this.repPlanId, this.representativeId, this.docId,
      this.visitDate, this.note, this.issue, this.special, this.target);

  factory VisitHosResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitHosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitHosResponseToJson(this);
}

@JsonSerializable()
class VisitBrandPharmacyResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "visitId")
  String? visitId;
  @JsonKey(name: "brandId")
  String? brandId;
  @JsonKey(name: "amount")
  String? amount;
  @JsonKey(name: "flag")
  String? flag;
  VisitBrandPharmacyResponse(
      this.id, this.visitId, this.brandId, this.amount, this.flag);

  factory VisitBrandPharmacyResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitBrandPharmacyResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$VisitBrandPharmacyResponseToJson(this);
}

@JsonSerializable()
class VisitDoctorResponse {
  @JsonKey(name: "docVisitTemp", defaultValue: [])
  List<VisitResponse>? visitDoctor;

  VisitDoctorResponse(this.visitDoctor);
  factory VisitDoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitDoctorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VisitDoctorResponseToJson(this);
}

@JsonSerializable()
class VisitDoctorBrandResponse {
  @JsonKey(name: "brands_visit", defaultValue: [])
  List<VisitBrandPharmacyResponse>? brand;
  VisitDoctorBrandResponse(this.brand);
  factory VisitDoctorBrandResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitDoctorBrandResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VisitDoctorBrandResponseToJson(this);
}

@JsonSerializable()
class VisitDoctorBaseResponse extends BaseResponse {
  @JsonKey(name: "docVisitTemp")
  VisitDoctorResponse? data;
  @JsonKey(name: "Brands Visit")
  VisitDoctorBrandResponse? brandsVisit;
  VisitDoctorBaseResponse(this.data, this.brandsVisit);
  factory VisitDoctorBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitDoctorBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VisitDoctorBaseResponseToJson(this);
}

@JsonSerializable()
class VisitHospitalResponse {
  @JsonKey(name: "hosVisitTemp", defaultValue: [])
  List<VisitHosResponse>? visitHospital;
  VisitHospitalResponse(this.visitHospital);
  factory VisitHospitalResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitHospitalResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VisitHospitalResponseToJson(this);
}

@JsonSerializable()
class VisitHospitalBaseResponse extends BaseResponse {
  @JsonKey(name: "HosVisitTemp")
  VisitHospitalResponse? data;
  @JsonKey(name: "Brands Visit")
  VisitDoctorBrandResponse? brandsVisit;
  VisitHospitalBaseResponse(this.data, this.brandsVisit);
  factory VisitHospitalBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitHospitalBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VisitHospitalBaseResponseToJson(this);
}

@JsonSerializable()
class InventoryResponse {
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "used")
  String? used;
  @JsonKey(name: "total")
  String? total;
  @JsonKey(name: "rest")
  int? rest;
  @JsonKey(name: "type")
  String? type;
  InventoryResponse(this.title, this.used, this.total, this.rest, this.type);

  factory InventoryResponse.fromJson(Map<String, dynamic> json) =>
      _$InventoryResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$InventoryResponseToJson(this);
}

@JsonSerializable()
class InventoryResponseBaseResponse extends BaseResponse {
  @JsonKey(name: "Brands", defaultValue: [])
  List<InventoryResponse>? brand;
  InventoryResponseBaseResponse(this.brand);
  factory InventoryResponseBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$InventoryResponseBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryResponseBaseResponseToJson(this);
}

@JsonSerializable()
class RepInfoResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "mobile")
  String? mobile;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "sampleCount")
  String? sampleCount;

  @JsonKey(name: "recipesCount")
  String? recipesCount;
  @JsonKey(name: "repPlanId")
  int? repPlanId;
  @JsonKey(name: "totalVisit")
  int? totalVisit;
  @JsonKey(name: "totDocVisit")
  String? totDocVisit;
  @JsonKey(name: "totHosVisit")
  String? totHosVisit;
  @JsonKey(name: "visitDon")
  int? visitDon;
  @JsonKey(name: "visitDonDoc")
  String? visitDonDoc;
  @JsonKey(name: "visitDonHos")
  String? visitDonHos;
  @JsonKey(name: "visitnotYet")
  int? visitnotYet;

  RepInfoResponse(
      this.id,
      this.name,
      this.mobile,
      this.address,
      this.sampleCount,
      this.recipesCount,
      this.repPlanId,
      this.totalVisit,
      this.totDocVisit,
      this.totHosVisit,
      this.visitDon,
      this.visitDonDoc,
      this.visitDonHos,
      this.visitnotYet);

  factory RepInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$RepInfoResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$RepInfoResponseToJson(this);
}

@JsonSerializable()
class RepVisitsResponse {
  @JsonKey(name: "visitId")
  String? visitId;
  @JsonKey(name: "visitDate")
  String? visitDate;
  @JsonKey(name: "placeTitle")
  String? placeTitle;
  @JsonKey(name: "docTitle")
  String? docTitle;
  @JsonKey(name: "rate")
  String? rate;
  @JsonKey(name: "spTitle")
  String? spTitle;
  @JsonKey(name: "note")
  String? note;
  @JsonKey(name: "issue")
  String? issue;
  @JsonKey(name: "special")
  String? special;
  @JsonKey(name: "target")
  String? target;
  @JsonKey(name: "flag")
  String? flag;
  @JsonKey(name: "samples")
  List<String>? samples;
  RepVisitsResponse(
      this.visitId,
      this.visitDate,
      this.placeTitle,
      this.docTitle,
      this.rate,
      this.spTitle,
      this.note,
      this.issue,
      this.special,
      this.target,
      this.flag,
      this.samples);

  factory RepVisitsResponse.fromJson(Map<String, dynamic> json) =>
      _$RepVisitsResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$RepVisitsResponseToJson(this);
}

@JsonSerializable()
class AllRepVisitsResponse {
  @JsonKey(name: "Representative", defaultValue: [])
  List<RepVisitsResponse>? repVisits;
  AllRepVisitsResponse(this.repVisits);
  factory AllRepVisitsResponse.fromJson(Map<String, dynamic> json) =>
      _$AllRepVisitsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllRepVisitsResponseToJson(this);
}

@JsonSerializable()
class AllRepVisitsResponseBaseResponse extends BaseResponse {
  @JsonKey(name: "Representative")
  AllRepVisitsResponse? data;
  AllRepVisitsResponseBaseResponse(this.data);
  factory AllRepVisitsResponseBaseResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AllRepVisitsResponseBaseResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AllRepVisitsResponseBaseResponseToJson(this);
}

@JsonSerializable()
class AllRepInfoResponse {
  @JsonKey(name: "Representative", defaultValue: [])
  List<RepInfoResponse>? repInfoResponse;
  AllRepInfoResponse(this.repInfoResponse);
  factory AllRepInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AllRepInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllRepInfoResponseToJson(this);
}

@JsonSerializable()
class AllRepInfoResponseBaseResponse extends BaseResponse {
  @JsonKey(name: "Representative")
  AllRepInfoResponse? data;
  AllRepInfoResponseBaseResponse(this.data);
  factory AllRepInfoResponseBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllRepInfoResponseBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllRepInfoResponseBaseResponseToJson(this);
}

@JsonSerializable()
class SpecializationPlanResponse {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "amount")
  String? amount;
  SpecializationPlanResponse(this.name, this.amount);
  factory SpecializationPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecializationPlanResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SpecializationPlanResponseToJson(this);
}

@JsonSerializable()
class ActiveBrandPlanResponse {
  @JsonKey(name: "specializations", defaultValue: [])
  List<SpecializationPlanResponse>? specializations;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "pharmaceuticalFormTitle")
  String? pharmaceuticalFormTitle;

  ActiveBrandPlanResponse(this.specializations, this.title, this.type,
      this.pharmaceuticalFormTitle);

  factory ActiveBrandPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveBrandPlanResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveBrandPlanResponseToJson(this);
}

@JsonSerializable()
class ActiveBrandPlanBaseResponse extends BaseResponse {
  @JsonKey(name: "data", defaultValue: [])
  List<ActiveBrandPlanResponse> data;
  ActiveBrandPlanBaseResponse(this.data);
  factory ActiveBrandPlanBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveBrandPlanBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveBrandPlanBaseResponseToJson(this);
}

@JsonSerializable()
class AllSearchHospitalBaseResponse extends BaseResponse {
  @JsonKey(name: 'Hospitals')
  AllSearchHospitalResponse allSearchHospitalResponse;

  AllSearchHospitalBaseResponse({
    required this.allSearchHospitalResponse,
  });

  // from json
  factory AllSearchHospitalBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$AllSearchHospitalBaseResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AllSearchHospitalBaseResponseToJson(this);
}

@JsonSerializable()
class AllSearchHospitalResponse {
  @JsonKey(name: 'Hospitals')
  List<SearchHospitalResponse> searchHospital;

  AllSearchHospitalResponse({
    required this.searchHospital,
  });

  // from json
  factory AllSearchHospitalResponse.fromJson(Map<String, dynamic> json) =>
      _$AllSearchHospitalResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AllSearchHospitalResponseToJson(this);
}

@JsonSerializable()
class SearchHospitalResponse {
  @JsonKey(name: "hosId")
  String? hosId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "spId")
  String? spId;

  SearchHospitalResponse(this.hosId, this.name, this.spId); // from json
  factory SearchHospitalResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchHospitalResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$SearchHospitalResponseToJson(this);
}

@JsonSerializable()
class AllSearchHospitalNoteBaseResponse extends BaseResponse {
  @JsonKey(name: 'Hospitals')
  AllSearchHospitalNoteResponse allSearchHospitalNoteResponse;

  AllSearchHospitalNoteBaseResponse({
    required this.allSearchHospitalNoteResponse,
  });

  // from json
  factory AllSearchHospitalNoteBaseResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AllSearchHospitalNoteBaseResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() =>
      _$AllSearchHospitalNoteBaseResponseToJson(this);
}

@JsonSerializable()
class AllSearchHospitalNoteResponse {
  @JsonKey(name: 'Representative')
  List<SearchHospitalNoteResponse> searchHospitalNote;

  AllSearchHospitalNoteResponse({
    required this.searchHospitalNote,
  });

  // from json
  factory AllSearchHospitalNoteResponse.fromJson(Map<String, dynamic> json) =>
      _$AllSearchHospitalNoteResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AllSearchHospitalNoteResponseToJson(this);
}

@JsonSerializable()
class SearchHospitalNoteResponse {
  @JsonKey(name: "hosId")
  String? hosId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "spId")
  String? spId;
  @JsonKey(name: "note")
  String? note;
  @JsonKey(name: "issue")
  String? issue;
  @JsonKey(name: "visitDate")
  String? visitDate;

  SearchHospitalNoteResponse(
      this.hosId, this.name, this.spId, this.note, this.issue, this.visitDate);

  factory SearchHospitalNoteResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchHospitalNoteResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$SearchHospitalNoteResponseToJson(this);
}

@JsonSerializable()
class SeniorByCityidBaseResponse extends BaseResponse {
  List<SeniorByCityidResponse>? data;
  SeniorByCityidBaseResponse(this.data);
  factory SeniorByCityidBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$SeniorByCityidBaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeniorByCityidBaseResponseToJson(this);
}

@JsonSerializable()
class SeniorByCityidResponse {
  @JsonKey(name: "rep_id")
  String? rep_id;
  @JsonKey(name: "rep_name")
  String? rep_name;
  @JsonKey(name: "city_id")
  String? city_id;
  @JsonKey(name: "city_name")
  String? city_name;
  SeniorByCityidResponse(
      this.rep_id, this.rep_name, this.city_id, this.city_name);
  factory SeniorByCityidResponse.fromJson(Map<String, dynamic> json) =>
      _$SeniorByCityidResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeniorByCityidResponseToJson(this);
}

@JsonSerializable()
class AllReadResponse extends BaseResponse {
  @JsonKey(name: "data", defaultValue: [])
  List<ReadResponse>? readResponse;
  AllReadResponse(this.readResponse);
  factory AllReadResponse.fromJson(Map<String, dynamic> json) =>
      _$AllReadResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllReadResponseToJson(this);
}

@JsonSerializable()
class ReadResponse {
  @JsonKey(name: "userId")
  String? userId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "repType")
  String? repType;
  @JsonKey(name: "role")
  String? role;

  ReadResponse(this.userId, this.name, this.repType, this.role); // from json
  factory ReadResponse.fromJson(Map<String, dynamic> json) =>
      _$ReadResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$ReadResponseToJson(this);
}

@JsonSerializable()
class AllRepresentativeFutureBaseResponse extends BaseResponse {
  @JsonKey(name: "Representative")
  AllRepresentativeFutureResponse? data;
  AllRepresentativeFutureBaseResponse(this.data);
  // from json
  factory AllRepresentativeFutureBaseResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AllRepresentativeFutureBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() =>
      _$AllRepresentativeFutureBaseResponseToJson(this);
}

@JsonSerializable()
class AllRepresentativeFutureResponse {
  @JsonKey(name: "Representative")
  List<RepresentativeFutureResponse>? data;
  AllRepresentativeFutureResponse(this.data);
  // from json
  factory AllRepresentativeFutureResponse.fromJson(Map<String, dynamic> json) =>
      _$AllRepresentativeFutureResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() =>
      _$AllRepresentativeFutureResponseToJson(this);
}

@JsonSerializable()
class RepresentativeFutureResponse {
  @JsonKey(name: "repId")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "flag")
  String? flag;
  @JsonKey(name: "futurePlan")
  String? futurePlan;
  @JsonKey(name: "samplesCount")
  String? samplesCount;
  @JsonKey(name: "reptype")
  String reptype;
  RepresentativeFutureResponse(this.id, this.name, this.flag, this.futurePlan,
      this.samplesCount, this.reptype);

  // from json
  factory RepresentativeFutureResponse.fromJson(Map<String, dynamic> json) =>
      _$RepresentativeFutureResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$RepresentativeFutureResponseToJson(this);
}

@JsonSerializable()
class FinishedPlanResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "cityId")
  String? cityId;
  @JsonKey(name: "startDate")
  String? startDate;
  @JsonKey(name: "endDate")
  String? endDate;
  @JsonKey(name: "active")
  String? active;

  FinishedPlanResponse(this.id, this.cityId, this.startDate, this.endDate,
      this.active); // from json
  factory FinishedPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$FinishedPlanResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$FinishedPlanResponseToJson(this);
}

@JsonSerializable()
class FinishedPlansBaseResponse extends BaseResponse {
  @JsonKey(name: "Plans")
  List<FinishedPlanResponse>? plans;
  FinishedPlansBaseResponse(this.plans);
  // from json
  factory FinishedPlansBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$FinishedPlansBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$FinishedPlansBaseResponseToJson(this);
}

@JsonSerializable()
class PlanRepsResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "repPlan")
  String? repPlan;

  PlanRepsResponse(this.id, this.name, this.repPlan); // from json
  factory PlanRepsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlanRepsResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$PlanRepsResponseToJson(this);
}

@JsonSerializable()
class PlanRepsBaseResponse extends BaseResponse {
  @JsonKey(name: "Representative")
  List<PlanRepsResponse>? rep;
  PlanRepsBaseResponse(this.rep);
  // from json
  factory PlanRepsBaseResponse.fromJson(Map<String, dynamic> json) =>
      _$PlanRepsBaseResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$PlanRepsBaseResponseToJson(this);
}
