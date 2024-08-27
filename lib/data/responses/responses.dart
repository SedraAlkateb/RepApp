
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

class BaseResponse {
  int? st;
  String? massage;

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
class AllAdminResponse {

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;
  AllAdminResponse(this.name,this.id);
  // from json
  factory AllAdminResponse.fromJson(Map<String,dynamic>json)=>
      _$AllAdminResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$AllAdminResponseToJson(this);
}
@JsonSerializable()
class AllAdminBaseResponse extends BaseResponse{
  @JsonKey(name: "data")
  List<AllAdminResponse> data;
  AllAdminBaseResponse(this.data);
  // from json
  factory AllAdminBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AllAdminBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$AllAdminBaseResponseToJson(this);
}
@JsonSerializable()
class ViewAdminResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "salon")
  String? salon;
  @JsonKey(name: "services")
  List<Service1Response>? services;
  @JsonKey(name: "products")
  List<ProductResponse>? products;

  ViewAdminResponse(
      this.id,
      this.name,
      this.salon,
      this.services,
      this.products
      ); // from json
  factory ViewAdminResponse.fromJson(Map<String,dynamic>json)=>
      _$ViewAdminResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$ViewAdminResponseToJson(this);
}
@JsonSerializable()
class ViewAdminBaseResponse extends BaseResponse{
  @JsonKey(name: "data")
  ViewAdminResponse data;
  ViewAdminBaseResponse(this.data);
  // from json
  factory ViewAdminBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$ViewAdminBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$ViewAdminBaseResponseToJson(this);
}
/////////Salons
@JsonSerializable()
class SalonsResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "logo_image")
  String? logo_image;
  @JsonKey(name: "description")
  String? description;

  SalonsResponse(this.id, this.name, this.latitude, this.longitude,
      this.logo_image, this.description); // from json
  factory SalonsResponse.fromJson(Map<String,dynamic>json)=>
      _$SalonsResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$SalonsResponseToJson(this);
}
@JsonSerializable()
class SalonsBaseResponse extends BaseResponse{
  @JsonKey(name: "data")
  List<SalonsResponse> data;
  SalonsBaseResponse(this.data);
  // from json
  factory SalonsBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$SalonsBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$SalonsBaseResponseToJson(this);
}
///////////product
@JsonSerializable()
class ProductResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "quantity")
  int? quantity;


  ProductResponse(this.id, this.name, this.description, this.price, this.image,
      this.quantity); // from json
  factory ProductResponse.fromJson(Map<String,dynamic>json)=>
      _$ProductResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$ProductResponseToJson(this);
}

///Employee
@JsonSerializable()
class EmployeeResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "salary")
  int? salary;
  EmployeeResponse(this.id, this.name,this.image,
      this.salary); // from json
  factory EmployeeResponse.fromJson(Map<String,dynamic>json)=>
      _$EmployeeResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$EmployeeResponseToJson(this);
}

////Services

@JsonSerializable()
class Service1Response {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "time")
  String? time;

  Service1Response(this.id, this.name, this.description, this.price, this.status,
      this.date, this.time); // from json
  factory Service1Response.fromJson(Map<String,dynamic>json)=>
      _$Service1ResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$Service1ResponseToJson(this);
}

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "time")
  String? time;
  @JsonKey(name: "employee")
  String? employee;
  @JsonKey(name: "salons")
  List<SalonsResponse>? salons;


  ServiceResponse(this.id, this.name, this.description, this.price, this.status,
      this.date, this.time, this.employee,this.salons); //from json
  factory ServiceResponse.fromJson(Map<String,dynamic>json)=>
      _$ServiceResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$ServiceResponseToJson(this);
}


@JsonSerializable()
class ShowSalonResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "latitude")
  String? latitude;
  @JsonKey(name: "longitude")
  String? longitude;
  @JsonKey(name: "logo_image")
  String? logo_image;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "admin")
  String? admin;
  List<ProductResponse>?products;
  List<EmployeeResponse>? employees;
  ShowSalonResponse(
      this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.logo_image,
      this.description,
      this.status,
      this.admin,
      this.products,
      this.employees
    ); // from json
  factory ShowSalonResponse.fromJson(Map<String,dynamic>json)=>
      _$ShowSalonResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$ShowSalonResponseToJson(this);
}
@JsonSerializable()
class ShowSalonBaseResponse extends BaseResponse{
  @JsonKey(name: "data")
  ShowSalonResponse data;
  ShowSalonBaseResponse(this.data);
  // from json
  factory ShowSalonBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$ShowSalonBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$ShowSalonBaseResponseToJson(this);
}

@JsonSerializable()
class ServicesBaseResponse extends BaseResponse{
  @JsonKey(name: "data")
  List<Service1Response> data;
  ServicesBaseResponse(this.data);
  // from json
  factory ServicesBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$ServicesBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$ServicesBaseResponseToJson(this);
}

@JsonSerializable()
class ServiceBaseResponse extends BaseResponse{
  @JsonKey(name: "data")
  ServiceResponse data;
  ServiceBaseResponse(this.data);
  // from json
  factory ServiceBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$ServiceBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$ServiceBaseResponseToJson(this);
}

@JsonSerializable()
class ShowProductResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "salons")
  List<SalonsResponse>? salons;
  @JsonKey(name: "admins")
  List<AllAdminResponse>?admins;

  ShowProductResponse(this.id, this.name, this.description, this.price,
      this.image, this.quantity, this.salons, this.admins); // from json
  factory ShowProductResponse.fromJson(Map<String,dynamic>json)=>
      _$ShowProductResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$ShowProductResponseToJson(this);
}
@JsonSerializable()
class ShowProductBaseResponse extends BaseResponse{
  @JsonKey(name: "data")
  ShowProductResponse data;
  ShowProductBaseResponse(this.data);
  // from json
  factory ShowProductBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$ShowProductBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$ShowProductBaseResponseToJson(this);
}

@JsonSerializable()
class ProductsBaseResponse extends BaseResponse{
  @JsonKey(name: "data")
  List<ProductResponse>? data;
  ProductsBaseResponse(this.data);
  // from json
  factory ProductsBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$ProductsBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$ProductsBaseResponseToJson(this);
}

@JsonSerializable()
class EmployeesBaseResponse extends BaseResponse{
  @JsonKey(name: "data")
  List<EmployeeResponse>? data;
  EmployeesBaseResponse(this.data);
  // from json
  factory EmployeesBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$EmployeesBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$EmployeesBaseResponseToJson(this);
}
@JsonSerializable()
class ShowEmployeeResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "salary")
  int? salary;
  @JsonKey(name: "service")
  Service1Response? service;
  @JsonKey(name: "admin")
  AllAdminResponse ? admin;
  @JsonKey(name: "salon")
  String  salon;


  ShowEmployeeResponse(this.id, this.name, this.image, this.salary,
      this.service, this.admin, this.salon);

  factory ShowEmployeeResponse.fromJson(Map<String,dynamic>json)=>
      _$ShowEmployeeResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$ShowEmployeeResponseToJson(this);
}
@JsonSerializable()
class ShowEmployeeBaseResponse extends BaseResponse{
  @JsonKey(name: "data")
  ShowEmployeeResponse data;
  ShowEmployeeBaseResponse(this.data);
  // from json
  factory ShowEmployeeBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$ShowEmployeeBaseResponseFromJson(json);
  // to json
  Map<String,dynamic>toJson()=>
      _$ShowEmployeeBaseResponseToJson(this);
}

@JsonSerializable()
class SalonCardResponse {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  SalonCardResponse(this.id, this.name);

  factory SalonCardResponse.fromJson(Map<String,dynamic>json)=>
      _$SalonCardResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$SalonCardResponseToJson(this);
}
@JsonSerializable()
class CardUserResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "salon")
  SalonCardResponse? salon;
  CardUserResponse(this.id, this.salon);

  factory CardUserResponse.fromJson(Map<String,dynamic>json)=>
      _$CardUserResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$CardUserResponseToJson(this);
}
@JsonSerializable()
class CardsUserResponse extends BaseResponse {
  List<CardUserResponse> cards;


  CardsUserResponse(this.cards);

  factory CardsUserResponse.fromJson(Map<String,dynamic>json)=>
      _$CardsUserResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$CardsUserResponseToJson(this);
}
@JsonSerializable()
class ServiceCardResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "price")
  int? price;


  ServiceCardResponse(
      this.id, this.name, this.price);

  factory ServiceCardResponse.fromJson(Map<String,dynamic>json)=>
      _$ServiceCardResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$ServiceCardResponseToJson(this);
}
@JsonSerializable()
class AppointmentCardResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "time")
  String? time;


  AppointmentCardResponse(this.id, this.date, this.time);

  factory AppointmentCardResponse.fromJson(Map<String,dynamic>json)=>
      _$AppointmentCardResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$AppointmentCardResponseToJson(this);
}
@JsonSerializable()
class AppointmentsResponse {

  //
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "appointment")
  AppointmentCardResponse? appointment;
  @JsonKey(name: "service")
  ServiceCardResponse? service;
  @JsonKey(name: "salon")
  SalonCardResponse? salon;

  AppointmentsResponse(this.id, this.appointment, this.service, this.salon);

  factory AppointmentsResponse.fromJson(Map<String,dynamic>json)=>
      _$AppointmentsResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$AppointmentsResponseToJson(this);
}
@JsonSerializable()
class AppointmentsBaseResponse extends BaseResponse {
  @JsonKey(name: "appointments")
  List<AppointmentsResponse> appointments;
  @JsonKey(name: "totalPrice")
  int ? totalPrice;
  AppointmentsBaseResponse(this.appointments,this.totalPrice);

  factory AppointmentsBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$AppointmentsBaseResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$AppointmentsBaseResponseToJson(this);
}
@JsonSerializable()
class ShowAppointmentBaseResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "service")
  ServiceCardResponse ? service;
  @JsonKey(name: "appointment")
  AppointmentCardResponse?appointment;
  @JsonKey(name: "salon")
  SalonCardResponse ?salon;

  ShowAppointmentBaseResponse(this.id,this.service,this.appointment,this.salon);

  factory ShowAppointmentBaseResponse.fromJson(Map<String,dynamic>json)=>
      _$ShowAppointmentBaseResponseFromJson(json);

  // to json
  Map<String,dynamic>toJson()=>
      _$ShowAppointmentBaseResponseToJson(this);
}


