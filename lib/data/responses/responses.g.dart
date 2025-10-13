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

CheckRepResponse _$CheckRepResponseFromJson(Map<String, dynamic> json) =>
    CheckRepResponse(
      json['accepted'] as bool?,
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CheckRepResponseToJson(CheckRepResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'accepted': instance.accepted,
    };

CopyRecResponse _$CopyRecResponseFromJson(Map<String, dynamic> json) =>
    CopyRecResponse(
      json['recip'] == null
          ? null
          : CopyRecipResponse.fromJson(json['recip'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$CopyRecResponseToJson(CopyRecResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'recip': instance.recip,
    };

CopyRecipResponse _$CopyRecipResponseFromJson(Map<String, dynamic> json) =>
    CopyRecipResponse(
      json['id'] as String?,
      json['repId'] as String?,
      json['type'] as String?,
      json['docId'] as String?,
      json['spName'] as String?,
      json['brand_1'] == null
          ? null
          : BrandRecipesResponse.fromJson(
              json['brand_1'] as Map<String, dynamic>),
      json['brand_2'] == null
          ? null
          : BrandRecipesResponse.fromJson(
              json['brand_2'] as Map<String, dynamic>),
      json['brand_3'] == null
          ? null
          : BrandRecipesResponse.fromJson(
              json['brand_3'] as Map<String, dynamic>),
      json['brand_4'] == null
          ? null
          : BrandRecipesResponse.fromJson(
              json['brand_4'] as Map<String, dynamic>),
      json['note1'] as String?,
      json['note2'] as String?,
      json['address'] as String?,
      json['phone'] as String?,
      json['total'] as String?,
      json['note_emp'] as String?,
      json['image1'] as String?,
      json['image2'] as String?,
      json['create_date'] as String?,
      json['print_date'] as String?,
    );

Map<String, dynamic> _$CopyRecipResponseToJson(CopyRecipResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'repId': instance.repId,
      'type': instance.type,
      'docId': instance.docId,
      'spName': instance.spName,
      'brand_1': instance.brand_1,
      'brand_2': instance.brand_2,
      'brand_3': instance.brand_3,
      'brand_4': instance.brand_4,
      'note1': instance.note1,
      'note2': instance.note2,
      'address': instance.address,
      'phone': instance.phone,
      'total': instance.total,
      'note_emp': instance.note_emp,
      'image1': instance.image1,
      'image2': instance.image2,
      'print_date': instance.print_date,
      'create_date': instance.create_date,
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

BrandRecipesResponse _$BrandRecipesResponseFromJson(
        Map<String, dynamic> json) =>
    BrandRecipesResponse(
      (json['id'] as num?)?.toInt(),
      json['title_en'] as String?,
    );

Map<String, dynamic> _$BrandRecipesResponseToJson(
        BrandRecipesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_en': instance.title_en,
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
      json['cityId'] as String?,
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
    )
      ..samplesCount = json['samplesCount'] as String?
      ..repType = json['repType'] as String?;

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'cityId': instance.cityId,
      'repId': instance.repId,
      'otherPlanId': instance.otherPlanId,
      'samplesCount': instance.samplesCount,
      'activePlanId': instance.activePlanId,
      'otherPlanStatus': instance.otherStatus,
      'name': instance.name,
      'repType': instance.repType,
      'percentage': instance.percentage,
      'endDate': instance.endDate,
      'startDate': instance.startDate,
      'recipesCount': instance.recipesCount,
      if (instance.otherStartDate case final value?) 'otherStartDate': value,
      if (instance.otherEndDate case final value?) 'otherEndDate': value,
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

NoVisitDoctorResponse _$NoVisitDoctorResponseFromJson(
        Map<String, dynamic> json) =>
    NoVisitDoctorResponse(
      json['docTitle'] as String?,
      json['spTitle'] as String?,
      json['address'] as String?,
      json['rate'] as String?,
      json['visits'] as String?,
      (json['remainingVisits'] as num?)?.toInt(),
      json['doneVisits'] as String?,
    );

Map<String, dynamic> _$NoVisitDoctorResponseToJson(
        NoVisitDoctorResponse instance) =>
    <String, dynamic>{
      'docTitle': instance.docTitle,
      'spTitle': instance.spTitle,
      'address': instance.address,
      'rate': instance.rate,
      'visits': instance.visits,
      'remainingVisits': instance.remainingVisits,
      'doneVisits': instance.doneVisits,
    };

AllNoVisitDoctorResponse _$AllNoVisitDoctorResponseFromJson(
        Map<String, dynamic> json) =>
    AllNoVisitDoctorResponse(
      (json['Representative'] as List<dynamic>?)
          ?.map(
              (e) => NoVisitDoctorResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllNoVisitDoctorResponseToJson(
        AllNoVisitDoctorResponse instance) =>
    <String, dynamic>{
      'Representative': instance.res,
    };

AllNoVisitDoctorBaseResponse _$AllNoVisitDoctorBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllNoVisitDoctorBaseResponse(
      json['Representative'] == null
          ? null
          : AllNoVisitDoctorResponse.fromJson(
              json['Representative'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllNoVisitDoctorBaseResponseToJson(
        AllNoVisitDoctorBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Representative': instance.data,
    };

VisitIssueResponse _$VisitIssueResponseFromJson(Map<String, dynamic> json) =>
    VisitIssueResponse(
      json['docTitle'] as String?,
      json['spTitle'] as String?,
      json['address'] as String?,
      json['visitDate'] as String?,
      json['issue'] as String?,
    );

Map<String, dynamic> _$VisitIssueResponseToJson(VisitIssueResponse instance) =>
    <String, dynamic>{
      'docTitle': instance.docTitle,
      'spTitle': instance.spTitle,
      'address': instance.address,
      'visitDate': instance.visitDate,
      'issue': instance.issue,
    };

AllVisitIssueResponse _$AllVisitIssueResponseFromJson(
        Map<String, dynamic> json) =>
    AllVisitIssueResponse(
      (json['Notes'] as List<dynamic>?)
          ?.map((e) => VisitIssueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllVisitIssueResponseToJson(
        AllVisitIssueResponse instance) =>
    <String, dynamic>{
      'Notes': instance.notes,
    };

AllVisitIssueBaseResponse _$AllVisitIssueBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllVisitIssueBaseResponse(
      json['Notes'] == null
          ? null
          : AllVisitIssueResponse.fromJson(
              json['Notes'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllVisitIssueBaseResponseToJson(
        AllVisitIssueBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Notes': instance.data,
    };

VisitNotesResponse _$VisitNotesResponseFromJson(Map<String, dynamic> json) =>
    VisitNotesResponse(
      json['docTitle'] as String?,
      json['spTitle'] as String?,
      json['address'] as String?,
      json['visitDate'] as String?,
      json['note'] as String?,
    );

Map<String, dynamic> _$VisitNotesResponseToJson(VisitNotesResponse instance) =>
    <String, dynamic>{
      'docTitle': instance.docTitle,
      'spTitle': instance.spTitle,
      'address': instance.address,
      'visitDate': instance.visitDate,
      'note': instance.note,
    };

AllVisitNotesResponse _$AllVisitNotesResponseFromJson(
        Map<String, dynamic> json) =>
    AllVisitNotesResponse(
      (json['Notes'] as List<dynamic>?)
          ?.map((e) => VisitNotesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllVisitNotesResponseToJson(
        AllVisitNotesResponse instance) =>
    <String, dynamic>{
      'Notes': instance.notes,
    };

AllVisitNotesBaseResponse _$AllVisitNotesBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllVisitNotesBaseResponse(
      json['Notes'] == null
          ? null
          : AllVisitNotesResponse.fromJson(
              json['Notes'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllVisitNotesBaseResponseToJson(
        AllVisitNotesBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Notes': instance.data,
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
      (json['flag'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SpecResponseToJson(SpecResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'flag': instance.flag,
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

CityResponse _$CityResponseFromJson(Map<String, dynamic> json) => CityResponse(
      json['id'] as String?,
      json['title'] as String?,
    );

Map<String, dynamic> _$CityResponseToJson(CityResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.name,
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

InfoDoctorBaseResponse _$InfoDoctorBaseResponseFromJson(
        Map<String, dynamic> json) =>
    InfoDoctorBaseResponse(
      json['Doctors'] == null
          ? null
          : DoctorResponse.fromJson(json['Doctors'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$InfoDoctorBaseResponseToJson(
        InfoDoctorBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Doctors': instance.data,
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
    )..title = json['title'] as String?;

Map<String, dynamic> _$PlanBrandResponseToJson(PlanBrandResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'repPlanId': instance.repPlanId,
      'brandId': instance.brandId,
      'brandType': instance.brandType,
      'title': instance.title,
      'spId': instance.spId,
      'amount': instance.amount,
    };

PlanBrandSpecResponse _$PlanBrandSpecResponseFromJson(
        Map<String, dynamic> json) =>
    PlanBrandSpecResponse(
      json['id'] as String?,
      json['titleAr'] as String?,
      json['brandId'] as String?,
      json['brandType'] as String?,
      json['spId'] as String?,
      json['phTitle'] as String?,
      json['totalAmount'] as String?,
    );

Map<String, dynamic> _$PlanBrandSpecResponseToJson(
        PlanBrandSpecResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brandId': instance.brandId,
      'brandType': instance.brandType,
      'titleAr': instance.titleAr,
      'spId': instance.spId,
      'phTitle': instance.phTitle,
      'totalAmount': instance.totalAmount,
    };

SearchDoctorsJsonResponse _$SearchDoctorsJsonResponseFromJson(
        Map<String, dynamic> json) =>
    SearchDoctorsJsonResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['spTitle'] as String?,
      json['placeTitle'] as String?,
    );

Map<String, dynamic> _$SearchDoctorsJsonResponseToJson(
        SearchDoctorsJsonResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'spTitle': instance.spTitle,
      'placeTitle': instance.placeTitle,
    };

DocDoctorsJsonResponse _$DocDoctorsJsonResponseFromJson(
        Map<String, dynamic> json) =>
    DocDoctorsJsonResponse(
      json['repName'] as String?,
      json['visitDate'] as String?,
      json['issue'] as String?,
      json['note'] as String?,
    );

Map<String, dynamic> _$DocDoctorsJsonResponseToJson(
        DocDoctorsJsonResponse instance) =>
    <String, dynamic>{
      'repName': instance.repName,
      'visitDate': instance.visitDate,
      'issue': instance.issue,
      'note': instance.note,
    };

ReciResponse _$ReciResponseFromJson(Map<String, dynamic> json) => ReciResponse(
      json['id'] as String?,
      json['docName'] as String?,
      json['create_date'] as String?,
      json['total'] as String?,
      json['note_emp'] as String?,
      json['docId'] as String?,
      json['recipeType'] as String?,
    );

Map<String, dynamic> _$ReciResponseToJson(ReciResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'docName': instance.docName,
      'create_date': instance.create_date,
      'total': instance.total,
      'note_emp': instance.note_emp,
      'docId': instance.docId,
      'recipeType': instance.recipeType,
    };

AllReciResponse _$AllReciResponseFromJson(Map<String, dynamic> json) =>
    AllReciResponse(
      reci: (json['Reci'] as List<dynamic>)
          .map((e) => ReciResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllReciResponseToJson(AllReciResponse instance) =>
    <String, dynamic>{
      'Reci': instance.reci,
    };

AllReciBaseResponse _$AllReciBaseResponseFromJson(Map<String, dynamic> json) =>
    AllReciBaseResponse(
      json['Reci'] == null
          ? null
          : AllReciResponse.fromJson(json['Reci'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllReciBaseResponseToJson(
        AllReciBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Reci': instance.data,
    };

BrandAmountResponse _$BrandAmountResponseFromJson(Map<String, dynamic> json) =>
    BrandAmountResponse(
      (json['totalSamplesDoctors'] as num?)?.toInt(),
      (json['totalSamplesHospitals'] as num?)?.toInt(),
      (json['totalSamplesDepartments'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BrandAmountResponseToJson(
        BrandAmountResponse instance) =>
    <String, dynamic>{
      'totalSamplesDoctors': instance.totalSamplesDoctors,
      'totalSamplesHospitals': instance.totalSamplesHospitals,
      'totalSamplesDepartments': instance.totalSamplesDepartments,
    };

PlanBrandSpecWithSamplesResponse _$PlanBrandSpecWithSamplesResponseFromJson(
        Map<String, dynamic> json) =>
    PlanBrandSpecWithSamplesResponse(
      PlanBrands: (json['PlanBrands'] as List<dynamic>)
          .map((e) => PlanBrandSpecResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands:
          BrandAmountResponse.fromJson(json['Brands'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlanBrandSpecWithSamplesResponseToJson(
        PlanBrandSpecWithSamplesResponse instance) =>
    <String, dynamic>{
      'PlanBrands': instance.PlanBrands,
      'Brands': instance.brands,
    };

RepresentativeResponse _$RepresentativeResponseFromJson(
        Map<String, dynamic> json) =>
    RepresentativeResponse(
      json['id'] as String?,
      json['name'] as String?,
      (json['unRead'] as num?)?.toInt(),
      json['activePlan'] as String?,
    );

Map<String, dynamic> _$RepresentativeResponseToJson(
        RepresentativeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unRead': instance.unRead,
      'activePlan': instance.activePlan,
    };

AllRepresentativeResponse _$AllRepresentativeResponseFromJson(
        Map<String, dynamic> json) =>
    AllRepresentativeResponse(
      (json['Representative'] as List<dynamic>?)
          ?.map(
              (e) => RepresentativeResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllRepresentativeResponseToJson(
        AllRepresentativeResponse instance) =>
    <String, dynamic>{
      'Representative': instance.data,
    };

AllRepresentativeBaseResponse _$AllRepresentativeBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllRepresentativeBaseResponse(
      json['Representative'] == null
          ? null
          : AllRepresentativeResponse.fromJson(
              json['Representative'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllRepresentativeBaseResponseToJson(
        AllRepresentativeBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Representative': instance.data,
    };

RepresentativeFutureResponse _$RepresentativeFutureResponseFromJson(
        Map<String, dynamic> json) =>
    RepresentativeFutureResponse(
      json['repId'] as String?,
      json['name'] as String?,
      json['flag'] as String?,
      json['futurePlan'] as String?,
    );

Map<String, dynamic> _$RepresentativeFutureResponseToJson(
        RepresentativeFutureResponse instance) =>
    <String, dynamic>{
      'repId': instance.id,
      'name': instance.name,
      'flag': instance.flag,
      'futurePlan': instance.activePlan,
    };

AllRepresentativeFutureResponse _$AllRepresentativeFutureResponseFromJson(
        Map<String, dynamic> json) =>
    AllRepresentativeFutureResponse(
      (json['Representative'] as List<dynamic>?)
          ?.map((e) =>
              RepresentativeFutureResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllRepresentativeFutureResponseToJson(
        AllRepresentativeFutureResponse instance) =>
    <String, dynamic>{
      'Representative': instance.data,
    };

AllRepresentativeFutureBaseResponse
    _$AllRepresentativeFutureBaseResponseFromJson(Map<String, dynamic> json) =>
        AllRepresentativeFutureBaseResponse(
          json['Representative'] == null
              ? null
              : AllRepresentativeFutureResponse.fromJson(
                  json['Representative'] as Map<String, dynamic>),
        )
          ..status = json['status'] as String?
          ..message = json['message'] as String?;

Map<String, dynamic> _$AllRepresentativeFutureBaseResponseToJson(
        AllRepresentativeFutureBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Representative': instance.data,
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

RepPlanBrandSpResponse _$RepPlanBrandSpResponseFromJson(
        Map<String, dynamic> json) =>
    RepPlanBrandSpResponse(
      (json['PlanBrands'] as List<dynamic>?)
          ?.map(
              (e) => PlanBrandSpecResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['Brands'] == null
          ? null
          : BrandAmountResponse.fromJson(
              json['Brands'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RepPlanBrandSpResponseToJson(
        RepPlanBrandSpResponse instance) =>
    <String, dynamic>{
      'PlanBrands': instance.PlanBrands,
      'Brands': instance.Brands,
    };

SearchDoctorsResponse _$SearchDoctorsResponseFromJson(
        Map<String, dynamic> json) =>
    SearchDoctorsResponse(
      (json['Representative'] as List<dynamic>?)
          ?.map((e) =>
              SearchDoctorsJsonResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchDoctorsResponseToJson(
        SearchDoctorsResponse instance) =>
    <String, dynamic>{
      'Representative': instance.Representative,
    };

DocDoctorsResponse _$DocDoctorsResponseFromJson(Map<String, dynamic> json) =>
    DocDoctorsResponse(
      (json['Representative'] as List<dynamic>?)
          ?.map(
              (e) => DocDoctorsJsonResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocDoctorsResponseToJson(DocDoctorsResponse instance) =>
    <String, dynamic>{
      'Representative': instance.Representative,
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

PlanBrandsBaseSpResponse _$PlanBrandsBaseSpResponseFromJson(
        Map<String, dynamic> json) =>
    PlanBrandsBaseSpResponse(
      json['PlanBrands'] == null
          ? null
          : RepPlanBrandSpResponse.fromJson(
              json['PlanBrands'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$PlanBrandsBaseSpResponseToJson(
        PlanBrandsBaseSpResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'PlanBrands': instance.data,
    };

SearchDoctorsBaseSpResponse _$SearchDoctorsBaseSpResponseFromJson(
        Map<String, dynamic> json) =>
    SearchDoctorsBaseSpResponse(
      json['Doctors'] == null
          ? null
          : SearchDoctorsResponse.fromJson(
              json['Doctors'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$SearchDoctorsBaseSpResponseToJson(
        SearchDoctorsBaseSpResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Doctors': instance.data,
    };

DocDoctorsBaseResponse _$DocDoctorsBaseResponseFromJson(
        Map<String, dynamic> json) =>
    DocDoctorsBaseResponse(
      json['Doctors'] == null
          ? null
          : DocDoctorsResponse.fromJson(
              json['Doctors'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$DocDoctorsBaseResponseToJson(
        DocDoctorsBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Doctors': instance.data,
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
      json['target'] as String?,
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
      'target': instance.target,
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
      json['target'] as String?,
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
      'target': instance.target,
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

InventoryResponse _$InventoryResponseFromJson(Map<String, dynamic> json) =>
    InventoryResponse(
      json['title'] as String?,
      json['used'] as String?,
      json['total'] as String?,
      (json['rest'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InventoryResponseToJson(InventoryResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'used': instance.used,
      'total': instance.total,
      'rest': instance.rest,
    };

InventoryResponseBaseResponse _$InventoryResponseBaseResponseFromJson(
        Map<String, dynamic> json) =>
    InventoryResponseBaseResponse(
      (json['Brands'] as List<dynamic>?)
              ?.map(
                  (e) => InventoryResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$InventoryResponseBaseResponseToJson(
        InventoryResponseBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Brands': instance.brand,
    };

RepInfoResponse _$RepInfoResponseFromJson(Map<String, dynamic> json) =>
    RepInfoResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['mobile'] as String?,
      json['address'] as String?,
      json['sampleCount'] as String?,
      json['recipesCount'] as String?,
      (json['repPlanId'] as num?)?.toInt(),
      (json['totalVisit'] as num?)?.toInt(),
      (json['visitDon'] as num?)?.toInt(),
      (json['visitnotYet'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RepInfoResponseToJson(RepInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'address': instance.address,
      'sampleCount': instance.sampleCount,
      'recipesCount': instance.recipesCount,
      'repPlanId': instance.repPlanId,
      'totalVisit': instance.totalVisit,
      'visitDon': instance.visitDon,
      'visitnotYet': instance.visitnotYet,
    };

RepVisitsResponse _$RepVisitsResponseFromJson(Map<String, dynamic> json) =>
    RepVisitsResponse(
      json['visitId'] as String?,
      json['visitDate'] as String?,
      json['placeTitle'] as String?,
      json['docTitle'] as String?,
      json['rate'] as String?,
      json['spTitle'] as String?,
      json['note'] as String?,
      json['issue'] as String?,
      json['special'] as String?,
      json['target'] as String?,
      json['flag'] as String?,
      (json['samples'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RepVisitsResponseToJson(RepVisitsResponse instance) =>
    <String, dynamic>{
      'visitId': instance.visitId,
      'visitDate': instance.visitDate,
      'placeTitle': instance.placeTitle,
      'docTitle': instance.docTitle,
      'rate': instance.rate,
      'spTitle': instance.spTitle,
      'note': instance.note,
      'issue': instance.issue,
      'special': instance.special,
      'target': instance.target,
      'flag': instance.flag,
      'samples': instance.samples,
    };

AllRepVisitsResponse _$AllRepVisitsResponseFromJson(
        Map<String, dynamic> json) =>
    AllRepVisitsResponse(
      (json['Representative'] as List<dynamic>?)
              ?.map(
                  (e) => RepVisitsResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AllRepVisitsResponseToJson(
        AllRepVisitsResponse instance) =>
    <String, dynamic>{
      'Representative': instance.repVisits,
    };

AllRepVisitsResponseBaseResponse _$AllRepVisitsResponseBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllRepVisitsResponseBaseResponse(
      json['Representative'] == null
          ? null
          : AllRepVisitsResponse.fromJson(
              json['Representative'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllRepVisitsResponseBaseResponseToJson(
        AllRepVisitsResponseBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Representative': instance.data,
    };

AllRepInfoResponse _$AllRepInfoResponseFromJson(Map<String, dynamic> json) =>
    AllRepInfoResponse(
      (json['Representative'] as List<dynamic>?)
              ?.map((e) => RepInfoResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AllRepInfoResponseToJson(AllRepInfoResponse instance) =>
    <String, dynamic>{
      'Representative': instance.repInfoResponse,
    };

AllRepInfoResponseBaseResponse _$AllRepInfoResponseBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllRepInfoResponseBaseResponse(
      json['Representative'] == null
          ? null
          : AllRepInfoResponse.fromJson(
              json['Representative'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllRepInfoResponseBaseResponseToJson(
        AllRepInfoResponseBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'Representative': instance.data,
    };

SpecializationPlanResponse _$SpecializationPlanResponseFromJson(
        Map<String, dynamic> json) =>
    SpecializationPlanResponse(
      json['name'] as String?,
      json['amount'] as String?,
    );

Map<String, dynamic> _$SpecializationPlanResponseToJson(
        SpecializationPlanResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
    };

ActiveBrandPlanResponse _$ActiveBrandPlanResponseFromJson(
        Map<String, dynamic> json) =>
    ActiveBrandPlanResponse(
      (json['specializations'] as List<dynamic>?)
              ?.map((e) => SpecializationPlanResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
      json['title'] as String?,
      json['type'] as String?,
    );

Map<String, dynamic> _$ActiveBrandPlanResponseToJson(
        ActiveBrandPlanResponse instance) =>
    <String, dynamic>{
      'specializations': instance.specializations,
      'title': instance.title,
      'type': instance.type,
    };

ActiveBrandPlanBaseResponse _$ActiveBrandPlanBaseResponseFromJson(
        Map<String, dynamic> json) =>
    ActiveBrandPlanBaseResponse(
      (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  ActiveBrandPlanResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ActiveBrandPlanBaseResponseToJson(
        ActiveBrandPlanBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
