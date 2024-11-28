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

ReciNumResponse _$ReciNumResponseFromJson(Map<String, dynamic> json) =>
    ReciNumResponse(
      (json['recICounts'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ReciNumResponseToJson(ReciNumResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'recICounts': instance.recICounts,
    };

BrandReResponse _$BrandReResponseFromJson(Map<String, dynamic> json) =>
    BrandReResponse(
      json['id'] as String?,
      json['title_en'] as String?,
    );

Map<String, dynamic> _$BrandReResponseToJson(BrandReResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_en': instance.title_en,
    };

AllBrandResResponse _$AllBrandResResponseFromJson(Map<String, dynamic> json) =>
    AllBrandResResponse(
      (json['representativePlan_Status'] as List<dynamic>?)
          ?.map((e) => BrandReResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllBrandResResponseToJson(
        AllBrandResResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'representativePlan_Status': instance.brandRes,
    };

CheckReResponse _$CheckReResponseFromJson(Map<String, dynamic> json) =>
    CheckReResponse(
      json['total'] as String?,
      json['accepted'] as bool?,
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CheckReResponseToJson(CheckReResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'total': instance.total,
      'accepted': instance.accepted,
    };

CopyReeciResponse _$CopyReeciResponseFromJson(Map<String, dynamic> json) =>
    CopyReeciResponse(
      CheckResponse.fromJson(
          json['representativePlan_Status'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CopyReeciResponseToJson(CopyReeciResponse instance) =>
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
      json['otherPlanStatus'] as String?,
      json['name'] as String?,
      (json['percentage'] as num?)?.toInt(),
      json['startDate'] as String?,
      json['endDate'] as String?,
      json['recipesCount'] as String?,
      json['otherStartDate'] as String?,
      json['otherEndDate'] as String?,
    )..samplesCount = json['samplesCount'] as String?;

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) {
  final val = <String, dynamic>{
    'token': instance.token,
    'repId': instance.repId,
    'otherPlanId': instance.otherPlanId,
    'samplesCount': instance.samplesCount,
    'activePlanId': instance.activePlanId,
    'otherPlanStatus': instance.otherStatus,
    'name': instance.name,
    'percentage': instance.percentage,
    'endDate': instance.endDate,
    'startDate': instance.startDate,
    'recipesCount': instance.recipesCount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('otherStartDate', instance.otherStartDate);
  writeNotNull('otherEndDate', instance.otherEndDate);
  return val;
}

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
      json['workHours'] as String?,
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
      'workHours': instance.workHours,
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

VisitResponse _$VisitResponseFromJson(Map<String, dynamic> json) =>
    VisitResponse(
      json['id'] as String?,
      json['repPlanId'] as String?,
      json['representativeId'] as String?,
      json['docId'] as String?,
      json['visitDate'] as String?,
      json['note'] as String?,
      json['issue'] as String?,
      json['special'] as String?,
    );

Map<String, dynamic> _$VisitResponseToJson(VisitResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'repPlanId': instance.repPlanId,
      'representativeId': instance.representativeId,
      'docId': instance.docId,
      'visitDate': instance.visitDate,
      'note': instance.note,
      'issue': instance.issue,
      'special': instance.special,
    };

VisitHosResponse _$VisitHosResponseFromJson(Map<String, dynamic> json) =>
    VisitHosResponse(
      json['id'] as String?,
      json['repPlanId'] as String?,
      json['representativeId'] as String?,
      json['spId'] as String?,
      json['visitDate'] as String?,
      json['note'] as String?,
      json['issue'] as String?,
      json['special'] as String?,
    );

Map<String, dynamic> _$VisitHosResponseToJson(VisitHosResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'repPlanId': instance.repPlanId,
      'representativeId': instance.representativeId,
      'spId': instance.docId,
      'visitDate': instance.visitDate,
      'note': instance.note,
      'issue': instance.issue,
      'special': instance.special,
    };

VisitBrandPharmacyResponse _$VisitBrandPharmacyResponseFromJson(
        Map<String, dynamic> json) =>
    VisitBrandPharmacyResponse(
      json['id'] as String?,
      json['visitId'] as String?,
      json['brandId'] as String?,
      json['amount'] as String?,
      json['flag'] as String?,
    );

Map<String, dynamic> _$VisitBrandPharmacyResponseToJson(
        VisitBrandPharmacyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'visitId': instance.visitId,
      'brandId': instance.brandId,
      'amount': instance.amount,
      'flag': instance.flag,
    };

VisitDoctorResponse _$VisitDoctorResponseFromJson(Map<String, dynamic> json) =>
    VisitDoctorResponse(
      (json['docVisitTemp'] as List<dynamic>?)
              ?.map((e) => VisitResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$VisitDoctorResponseToJson(
        VisitDoctorResponse instance) =>
    <String, dynamic>{
      'docVisitTemp': instance.visitDoctor,
    };

VisitDoctorBrandResponse _$VisitDoctorBrandResponseFromJson(
        Map<String, dynamic> json) =>
    VisitDoctorBrandResponse(
      (json['brands_visit'] as List<dynamic>?)
              ?.map((e) => VisitBrandPharmacyResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$VisitDoctorBrandResponseToJson(
        VisitDoctorBrandResponse instance) =>
    <String, dynamic>{
      'brands_visit': instance.brand,
    };

VisitDoctorBaseResponse _$VisitDoctorBaseResponseFromJson(
        Map<String, dynamic> json) =>
    VisitDoctorBaseResponse(
      json['docVisitTemp'] == null
          ? null
          : VisitDoctorResponse.fromJson(
              json['docVisitTemp'] as Map<String, dynamic>),
      json['Brands Visit'] == null
          ? null
          : VisitDoctorBrandResponse.fromJson(
              json['Brands Visit'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$VisitDoctorBaseResponseToJson(
        VisitDoctorBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'docVisitTemp': instance.data,
      'Brands Visit': instance.brandsVisit,
    };

VisitHospitalResponse _$VisitHospitalResponseFromJson(
        Map<String, dynamic> json) =>
    VisitHospitalResponse(
      (json['hosVisitTemp'] as List<dynamic>?)
              ?.map((e) => VisitHosResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$VisitHospitalResponseToJson(
        VisitHospitalResponse instance) =>
    <String, dynamic>{
      'hosVisitTemp': instance.visitHospital,
    };

VisitHospitalBaseResponse _$VisitHospitalBaseResponseFromJson(
        Map<String, dynamic> json) =>
    VisitHospitalBaseResponse(
      json['HosVisitTemp'] == null
          ? null
          : VisitHospitalResponse.fromJson(
              json['HosVisitTemp'] as Map<String, dynamic>),
      json['Brands Visit'] == null
          ? null
          : VisitDoctorBrandResponse.fromJson(
              json['Brands Visit'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$VisitHospitalBaseResponseToJson(
        VisitHospitalBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'HosVisitTemp': instance.data,
      'Brands Visit': instance.brandsVisit,
    };
