
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
