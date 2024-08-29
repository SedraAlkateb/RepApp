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
