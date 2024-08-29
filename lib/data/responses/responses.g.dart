// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message1Response _$Message1ResponseFromJson(Map<String, dynamic> json) =>
    Message1Response()
      ..st = (json['st'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$Message1ResponseToJson(Message1Response instance) =>
    <String, dynamic>{
      'st': instance.st,
      'message': instance.message,
    };

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) =>
    MessageResponse(
      json['message'] as String?,
    )..st = (json['st'] as num?)?.toInt();

Map<String, dynamic> _$MessageResponseToJson(MessageResponse instance) =>
    <String, dynamic>{
      'st': instance.st,
      'message': instance.message,
    };

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      json['token'] as String?,
    )
      ..st = (json['st'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'st': instance.st,
      'message': instance.message,
      'token': instance.token,
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
      (json['Places'] as List<dynamic>)
          .map((e) => PlaceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPlaceResponseToJson(AllPlaceResponse instance) =>
    <String, dynamic>{
      'Places': instance.places,
    };

AllPlaceBaseResponse _$AllPlaceBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllPlaceBaseResponse(
      AllPlaceResponse.fromJson(json['Places'] as Map<String, dynamic>),
    )
      ..st = (json['st'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllPlaceBaseResponseToJson(
        AllPlaceBaseResponse instance) =>
    <String, dynamic>{
      'st': instance.st,
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
      (json['Specializations'] as List<dynamic>)
          .map((e) => SpecResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllSpcResponseToJson(AllSpcResponse instance) =>
    <String, dynamic>{
      'Specializations': instance.specializations,
    };

AllSpcBaseResponse _$AllSpcBaseResponseFromJson(Map<String, dynamic> json) =>
    AllSpcBaseResponse(
      AllSpcResponse.fromJson(json['Specializations'] as Map<String, dynamic>),
    )
      ..st = (json['st'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllSpcBaseResponseToJson(AllSpcBaseResponse instance) =>
    <String, dynamic>{
      'st': instance.st,
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
      (json['Medical Representative Visits'] as List<dynamic>)
          .map((e) => MedicalVisitsResponse.fromJson(e as Map<String, dynamic>))
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
      AllMedicalVisitResponse.fromJson(
          json['Medical Representative Visits'] as Map<String, dynamic>),
    )
      ..st = (json['st'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllMedicalVisitBaseResponseToJson(
        AllMedicalVisitBaseResponse instance) =>
    <String, dynamic>{
      'st': instance.st,
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
      (json['City'] as List<dynamic>)
          .map((e) => CityResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllCityResponseToJson(AllCityResponse instance) =>
    <String, dynamic>{
      'City': instance.city,
    };

AllCityBaseResponse _$AllCityBaseResponseFromJson(Map<String, dynamic> json) =>
    AllCityBaseResponse(
      AllCityResponse.fromJson(json['City'] as Map<String, dynamic>),
    )
      ..st = (json['st'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllCityBaseResponseToJson(
        AllCityBaseResponse instance) =>
    <String, dynamic>{
      'st': instance.st,
      'message': instance.message,
      'City': instance.data,
    };

AllMedicalRepresentativeResponse _$AllMedicalRepresentativeResponseFromJson(
        Map<String, dynamic> json) =>
    AllMedicalRepresentativeResponse(
      (json['Medical Representative'] as List<dynamic>)
          .map((e) => CityResponse.fromJson(e as Map<String, dynamic>))
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
          AllMedicalRepresentativeResponse.fromJson(
              json['Medical Representative'] as Map<String, dynamic>),
        )
          ..st = (json['st'] as num?)?.toInt()
          ..message = json['message'] as String?;

Map<String, dynamic> _$AllMedicalRepresentativeBaseResponseToJson(
        AllMedicalRepresentativeBaseResponse instance) =>
    <String, dynamic>{
      'st': instance.st,
      'message': instance.message,
      'Medical Representative': instance.data,
    };

BrandResponse _$BrandResponseFromJson(Map<String, dynamic> json) =>
    BrandResponse(
      json['id'] as String?,
      json['title'] as String?,
      json['phTitle'] as String?,
    );

Map<String, dynamic> _$BrandResponseToJson(BrandResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'phTitle': instance.phTitle,
    };

AllBrandResponse _$AllBrandResponseFromJson(Map<String, dynamic> json) =>
    AllBrandResponse(
      (json['Brands'] as List<dynamic>)
          .map((e) => BrandResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllBrandResponseToJson(AllBrandResponse instance) =>
    <String, dynamic>{
      'Brands': instance.brands,
    };

AllBrandBaseResponse _$AllBrandBaseResponseFromJson(
        Map<String, dynamic> json) =>
    AllBrandBaseResponse(
      AllBrandResponse.fromJson(json['Brands'] as Map<String, dynamic>),
    )
      ..st = (json['st'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllBrandBaseResponseToJson(
        AllBrandBaseResponse instance) =>
    <String, dynamic>{
      'st': instance.st,
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
      (json['Pharmacy'] as List<dynamic>)
          .map((e) => PharmacyResponse.fromJson(e as Map<String, dynamic>))
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
      AllPharmacyResponse.fromJson(json['Pharmacy'] as Map<String, dynamic>),
    )
      ..st = (json['st'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AllPharmacyBaseResponseToJson(
        AllPharmacyBaseResponse instance) =>
    <String, dynamic>{
      'st': instance.st,
      'message': instance.message,
      'Pharmacy': instance.data,
    };
