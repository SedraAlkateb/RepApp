import 'dart:io';

class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}



class SignupRequest {
  String name;
  String password;
  String c_password;
  String phone_number;
  String email;

  SignupRequest(this.name, this.password, this.c_password, this.phone_number,
      this.email);
}

class AppointmentReq {
  int id;
  String date;
  String time;

  AppointmentReq(this.id, this.date, this.time);
}

class RegisterRequest {
  String first_name;
  String last_name;
  String email;
  String password;
  String whatsapp_number;

  RegisterRequest(this.first_name, this.last_name, this.email, this.password,
      this.whatsapp_number);
}

class Salon {
  String name;
  String description;
  String image;
  String status;

  Salon(this.name, this.description, this.image, this.status);
}

class ProfileRequest {
  String? first_name;
  String? last_name;
  String? email;
  String? phone_number;
  File? image;

  ProfileRequest({this.first_name,
    this.last_name,
    this.email,
    this.phone_number,
    this.image});
}

class Pagination {
  int page;
  int size;
  int isPaginate;

  Pagination(
      {required this.page, required this.size, required this.isPaginate});
}

class ChangePasswordRequest {
  String oldP;
  String newP;
  String confirmP;

  ChangePasswordRequest(
      {required this.oldP, required this.newP, required this.confirmP});
}

class StoreAdminRequest {
  String name;
  String password;
  int salonId;

  StoreAdminRequest(
      {required this.name, required this.password, required this.salonId});
}

class UpdateAdminReq {
  int id;
  String? name;
  String? password;
  int? salonId;

  UpdateAdminReq(this.id, {this.name, this.password, this.salonId});
}

class UpdateSalonReq {
  int id;
  String? name;
  String? description;
  int? adminId;
  File? logo_image;
  String? status;

  UpdateSalonReq(this.id,
      {this.name,
        this.description,
        this.adminId,
        this.logo_image,
        this.status});
}

class AddServiceReq {
  String name;
  String? description;
  File ?image;
  String status;
  int price;
  int employee_id;

  AddServiceReq(this.name, this.description, this.image, this.status,
      this.price, this.employee_id);
}

class AddEmployeeReq {
  String name;
  int salary;
  File image;

  AddEmployeeReq(this.name, this.salary, this.image);
}

class AddProductReq {
  String name;
  String description;
  int price;
  int quantity;
  File image;

  AddProductReq(this.name, this.description,
      this.price, this.quantity, this.image);
}

class EditAppointmentReq {
  int id;
  int serviceId;
  String ?date;
  String ?time;

  EditAppointmentReq(this.id, this.serviceId, this.date, this.time);
}