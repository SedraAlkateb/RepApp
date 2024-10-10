// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as String?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

Message1Response _$Message1ResponseFromJson(Map<String, dynamic> json) =>
    Message1Response()
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$Message1ResponseToJson(Message1Response instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) =>
    MessageResponse(
      json['message'] as String?,
    )..status = json['status'] as String?;

Map<String, dynamic> _$MessageResponseToJson(MessageResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

CheckResponse _$CheckResponseFromJson(Map<String, dynamic> json) =>
    CheckResponse(
      json['id'] as String?,
      json['active'] as String?,
    );

Map<String, dynamic> _$CheckResponseToJson(CheckResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
    };

CheckBaseResponse _$CheckBaseResponseFromJson(Map<String, dynamic> json) =>
    CheckBaseResponse(
      CheckResponse.fromJson(
          json['representativePlan_Status'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CheckBaseResponseToJson(CheckBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'representativePlan_Status': instance.data,
    };

CheckActiveResponse _$CheckActiveResponseFromJson(Map<String, dynamic> json) =>
    CheckActiveResponse(
      json['activePlanId'] as String?,
      json['otherPlanId'] as String?,
      json['otherstatus'] as String?,
    );

Map<String, dynamic> _$CheckActiveResponseToJson(
        CheckActiveResponse instance) =>
    <String, dynamic>{
      'activePlanId': instance.activePlanId,
      'otherPlanId': instance.otherPlanId,
      'otherstatus': instance.otherstatus,
    };

CheckActiveBaseResponse _$CheckActiveBaseResponseFromJson(
        Map<String, dynamic> json) =>
    CheckActiveBaseResponse(
      CheckActiveResponse.fromJson(
          json['representativePlans'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CheckActiveBaseResponseToJson(
        CheckActiveBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'representativePlans': instance.data,
    };

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      json['token'] as String?,
      json['repId'] as String?,
      json['otherPlanId'] as String?,
      json['activePlanId'] as String?,
      json['name'] as String?,
      (json['percentage'] as num?)?.toInt(),
    )..otherstatus = json['otherstatus'] as String?;

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'repId': instance.repId,
      'otherPlanId': instance.otherPlanId,
      'activePlanId': instance.activePlanId,
      'otherstatus': instance.otherstatus,
      'name': instance.name,
      'percentage': instance.percentage,
    };

BrandSpResponse _$BrandSpResponseFromJson(Map<String, dynamic> json) =>
    BrandSpResponse(
      json['id'] as String?,
      json['spId'] as String?,
      json['brandId'] as String?,
      json['brandType'] as String?,
    );

Map<String, dynamic> _$BrandSpResponseToJson(BrandSpResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spId': instance.spId,
      'brandId': instance.brandId,
      'brandType': instance.brandType,
    };

AllBrandSpResponse _$AllBrandSpResponseFromJson(Map<String, dynamic> json) =>
    AllBrandSpResponse(
      (json['brands_specializations'] as List<dynamic>?)
          ?.map((e) => BrandSpResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllBrandSpResponseToJson(AllBrandSpResponse instance) =>
    <String, dynamic>{
      'brands_specializations': instance.brandsSpecializations,
    };

AllBrandSpBaseResponse _$AllBrandSpBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllBrandSpBaseResponse(
      json['brands_specializations'] == null
          ? null
          : AllBrandSpResponse.fromJson(
              json['brands_specializations'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllBrandSpBaseResponseToJson(
        AllBrandSpBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'brands_specializations': instance.data,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['data'] == null
          ? null
          : TokenResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

PlaceResponse _$PlaceResponseFromJson(Map<String, dynamic> json) =>
    PlaceResponse(
      json['id'] as String?,
      json['title'] as String?,
    );

Map<String, dynamic> _$PlaceResponseToJson(PlaceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

AllPlaceResponse _$AllPlaceResponseFromJson(Map<String, dynamic> json) =>
    AllPlaceResponse(
      (json['Places'] as List<dynamic>?)
          ?.map((e) => PlaceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPlaceResponseToJson(AllPlaceResponse instance) =>
    <String, dynamic>{
      'Places': instance.places,
    };

AllPlaceBaseResponse _$AllPlaceBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllPlaceBaseResponse(
      json['Places'] == null
          ? null
          : AllPlaceResponse.fromJson(json['Places'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllPlaceBaseResponseToJson(
        AllPlaceBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Places': instance.data,
    };

SpecResponse _$SpecResponseFromJson(Map<String, dynamic> json) => SpecResponse(
      json['id'] as String?,
      json['title'] as String?,
    );

Map<String, dynamic> _$SpecResponseToJson(SpecResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

AllSpcResponse _$AllSpcResponseFromJson(Map<String, dynamic> json) =>
    AllSpcResponse(
      (json['Specializations'] as List<dynamic>?)
          ?.map((e) => SpecResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllSpcResponseToJson(AllSpcResponse instance) =>
    <String, dynamic>{
      'Specializations': instance.specializations,
    };

AllSpcBaseResponse _$AllSpcBaseResponseFromJson(Map<String, dynamic> json) =>
    AllSpcBaseResponse(
      json['Specializations'] == null
          ? null
          : AllSpcResponse.fromJson(
              json['Specializations'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllSpcBaseResponseToJson(AllSpcBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Specializations': instance.data,
    };

MedicalVisitsResponse _$MedicalVisitsResponseFromJson(
        Map<String, dynamic> json) =>
    MedicalVisitsResponse(
      json['visID'] as String?,
      json['visitDate'] as String?,
      json['title'] as String?,
      json['address'] as String?,
      json['note'] as String?,
      json['issue'] as String?,
      json['spTitle'] as String?,
      json['special'] as String?,
      json['brands'] as String?,
    );

Map<String, dynamic> _$MedicalVisitsResponseToJson(
        MedicalVisitsResponse instance) =>
    <String, dynamic>{
      'visID': instance.visID,
      'visitDate': instance.visitDate,
      'title': instance.title,
      'address': instance.address,
      'note': instance.note,
      'issue': instance.issue,
      'spTitle': instance.spTitle,
      'special': instance.special,
      'brands': instance.brands,
    };

AllMedicalVisitResponse _$AllMedicalVisitResponseFromJson(
        Map<String, dynamic> json) =>
    AllMedicalVisitResponse(
      (json['Medical Representative Visits'] as List<dynamic>?)
          ?.map(
              (e) => MedicalVisitsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllMedicalVisitResponseToJson(
        AllMedicalVisitResponse instance) =>
    <String, dynamic>{
      'Medical Representative Visits': instance.medicalVisits,
    };

AllMedicalVisitBaseResponse _$AllMedicalVisitBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllMedicalVisitBaseResponse(
      json['Medical Representative Visits'] == null
          ? null
          : AllMedicalVisitResponse.fromJson(
              json['Medical Representative Visits'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllMedicalVisitBaseResponseToJson(
        AllMedicalVisitBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Medical Representative Visits': instance.data,
    };

CityResponse _$CityResponseFromJson(Map<String, dynamic> json) => CityResponse(
      json['id'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$CityResponseToJson(CityResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

AllCityResponse _$AllCityResponseFromJson(Map<String, dynamic> json) =>
    AllCityResponse(
      (json['City'] as List<dynamic>?)
          ?.map((e) => CityResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllCityResponseToJson(AllCityResponse instance) =>
    <String, dynamic>{
      'City': instance.city,
    };

AllCityBaseResponse _$AllCityBaseResponseFromJson(Map<String, dynamic> json) =>
    AllCityBaseResponse(
      json['City'] == null
          ? null
          : AllCityResponse.fromJson(json['City'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllCityBaseResponseToJson(
        AllCityBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'City': instance.data,
    };

AllMedicalRepresentativeResponse _$AllMedicalRepresentativeResponseFromJson(
        Map<String, dynamic> json) =>
    AllMedicalRepresentativeResponse(
      (json['Medical Representative'] as List<dynamic>?)
          ?.map((e) => CityResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllMedicalRepresentativeResponseToJson(
        AllMedicalRepresentativeResponse instance) =>
    <String, dynamic>{
      'Medical Representative': instance.MedicalRepresentative,
    };

AllMedicalRepresentativeBaseResponse
    _$AllMedicalRepresentativeBaseResponseFromJson(Map<String, dynamic> json) =>
        AllMedicalRepresentativeBaseResponse(
          json['Medical Representative'] == null
              ? null
              : AllMedicalRepresentativeResponse.fromJson(
                  json['Medical Representative'] as Map<String, dynamic>),
        )
          ..status = json['status'] as String?
          ..message = json['message'] as String?;

Map<String, dynamic> _$AllMedicalRepresentativeBaseResponseToJson(
        AllMedicalRepresentativeBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Medical Representative': instance.data,
    };

BrandResponse _$BrandResponseFromJson(Map<String, dynamic> json) =>
    BrandResponse(
      json['id'] as String?,
      json['title'] as String?,
      json['phTitle'] as String?,
      (json['falg'] as num?)?.toInt(),
      json['sampleCoast'] as String?,
    );

Map<String, dynamic> _$BrandResponseToJson(BrandResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'phTitle': instance.phTitle,
      'falg': instance.falg,
      'sampleCoast': instance.sampleCoast,
    };

AllBrandResponse _$AllBrandResponseFromJson(Map<String, dynamic> json) =>
    AllBrandResponse(
      (json['Brands'] as List<dynamic>?)
          ?.map((e) => BrandResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllBrandResponseToJson(AllBrandResponse instance) =>
    <String, dynamic>{
      'Brands': instance.brands,
    };

AllBrandBaseResponse _$AllBrandBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllBrandBaseResponse(
      json['Brands'] == null
          ? null
          : AllBrandResponse.fromJson(json['Brands'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllBrandBaseResponseToJson(
        AllBrandBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Brands': instance.data,
    };

PharmacyResponse _$PharmacyResponseFromJson(Map<String, dynamic> json) =>
    PharmacyResponse(
      json['id'] as String?,
      json['title'] as String?,
      json['placeId'] as String?,
      json['address'] as String?,
    );

Map<String, dynamic> _$PharmacyResponseToJson(PharmacyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'placeId': instance.placeId,
      'address': instance.address,
    };

AllPharmacyResponse _$AllPharmacyResponseFromJson(Map<String, dynamic> json) =>
    AllPharmacyResponse(
      (json['Pharmacy'] as List<dynamic>?)
          ?.map((e) => PharmacyResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPharmacyResponseToJson(
        AllPharmacyResponse instance) =>
    <String, dynamic>{
      'Pharmacy': instance.pharmacy,
    };

AllPharmacyBaseResponse _$AllPharmacyBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllPharmacyBaseResponse(
      json['Pharmacy'] == null
          ? null
          : AllPharmacyResponse.fromJson(
              json['Pharmacy'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllPharmacyBaseResponseToJson(
        AllPharmacyBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Pharmacy': instance.data,
    };

HospitalResponse _$HospitalResponseFromJson(Map<String, dynamic> json) =>
    HospitalResponse(
      json['id'] as String?,
      json['title'] as String?,
      json['placeId'] as String?,
      json['address'] as String?,
      json['placeTitle'] as String?,
      json['note'] as String?,
    );

Map<String, dynamic> _$HospitalResponseToJson(HospitalResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'placeId': instance.placeId,
      'address': instance.address,
      'placeTitle': instance.placeTitle,
      'note': instance.note,
    };

DoctorResponse _$DoctorResponseFromJson(Map<String, dynamic> json) =>
    DoctorResponse(
      json['id'] as String?,
      json['title'] as String?,
      json['placeId'] as String?,
      json['address'] as String?,
      json['spId'] as String?,
      json['placeTitle'] as String?,
      json['visits'] as String?,
      json['note'] as String?,
      json['rate'] as String?,
      json['spTitle'] as String?,
    );

Map<String, dynamic> _$DoctorResponseToJson(DoctorResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'placeId': instance.placeId,
      'address': instance.address,
      'spId': instance.spId,
      'placeTitle': instance.placeTitle,
      'visits': instance.visits,
      'note': instance.note,
      'rate': instance.rate,
      'spTitle': instance.spTitle,
    };

AllDoctorResponse _$AllDoctorResponseFromJson(Map<String, dynamic> json) =>
    AllDoctorResponse(
      (json['Doctors'] as List<dynamic>?)
          ?.map((e) => DoctorResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllDoctorResponseToJson(AllDoctorResponse instance) =>
    <String, dynamic>{
      'Doctors': instance.doctor,
    };

AllDoctorsBaseResponse _$AllDoctorsBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllDoctorsBaseResponse(
      json['Doctors'] == null
          ? null
          : AllDoctorResponse.fromJson(json['Doctors'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllDoctorsBaseResponseToJson(
        AllDoctorsBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Doctors': instance.data,
    };

AllHospitalResponse _$AllHospitalResponseFromJson(Map<String, dynamic> json) =>
    AllHospitalResponse(
      (json['Hospital'] as List<dynamic>?)
          ?.map((e) => HospitalResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllHospitalResponseToJson(
        AllHospitalResponse instance) =>
    <String, dynamic>{
      'Hospital': instance.hospital,
    };

AllHospitalBaseResponse _$AllHospitalBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllHospitalBaseResponse(
      json['Hospital'] == null
          ? null
          : AllHospitalResponse.fromJson(
              json['Hospital'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllHospitalBaseResponseToJson(
        AllHospitalBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Hospital': instance.data,
    };

AllHospitalSpResponse _$AllHospitalSpResponseFromJson(
        Map<String, dynamic> json) =>
    AllHospitalSpResponse(
      (json['Hospital'] as List<dynamic>?)
          ?.map((e) => HospitalSpResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllHospitalSpResponseToJson(
        AllHospitalSpResponse instance) =>
    <String, dynamic>{
      'Hospital': instance.HospitalSp,
    };

AllHospitalSpBaseResponse _$AllHospitalSpBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllHospitalSpBaseResponse(
      json['HospitalSp'] == null
          ? null
          : AllHospitalSpResponse.fromJson(
              json['HospitalSp'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllHospitalSpBaseResponseToJson(
        AllHospitalSpBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'HospitalSp': instance.data,
    };

HospitalSpResponse _$HospitalSpResponseFromJson(Map<String, dynamic> json) =>
    HospitalSpResponse(
      json['id'] as String?,
      json['hospitalId'] as String?,
      json['spId'] as String?,
      json['totalDocs'] as String?,
      json['rate'] as String?,
      json['visit'] as String?,
    );

Map<String, dynamic> _$HospitalSpResponseToJson(HospitalSpResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hospitalId': instance.hospitalId,
      'spId': instance.spId,
      'totalDocs': instance.totalDocs,
      'rate': instance.rate,
      'visit': instance.visit,
    };

PlanBrandResponse _$PlanBrandResponseFromJson(Map<String, dynamic> json) =>
    PlanBrandResponse(
      json['id'] as String?,
      json['repPlanId'] as String?,
      json['brandId'] as String?,
      json['brandType'] as String?,
      json['spId'] as String?,
      json['amount'] as String?,
    );

Map<String, dynamic> _$PlanBrandResponseToJson(PlanBrandResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'repPlanId': instance.repPlanId,
      'brandId': instance.brandId,
      'brandType': instance.brandType,
      'spId': instance.spId,
      'amount': instance.amount,
    };

AllPlanBrandResponse _$AllPlanBrandResponseFromJson(
        Map<String, dynamic> json) =>
    AllPlanBrandResponse(
      (json['representPlan_brands'] as List<dynamic>?)
          ?.map((e) => PlanBrandResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPlanBrandResponseToJson(
        AllPlanBrandResponse instance) =>
    <String, dynamic>{
      'representPlan_brands': instance.planBrand,
    };

AllPlanBrandsBaseResponse _$AllPlanBrandsBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllPlanBrandsBaseResponse(
      json['representativeActivePlan_brands'] == null
          ? null
          : AllPlanBrandResponse.fromJson(
              json['representativeActivePlan_brands'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllPlanBrandsBaseResponseToJson(
        AllPlanBrandsBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'representativeActivePlan_brands': instance.data,
    };
