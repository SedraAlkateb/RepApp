

import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data.freezed.dart';

@freezed

class LoginObject with _$LoginObject {
factory LoginObject(String userName,String password)=_LoginObject;
}

@freezed

class ProfileObject with _$ProfileObject{
  factory ProfileObject(int user_id)=_ProfileObject;
}
@freezed

class SignUpObject with _$SignUpObject{
  factory SignUpObject (
  int city_id,
  int area_id,
  String street,
  int subscription_id,
  String firstName,
  String lastName,
  String email,
  String password,
  String phoneNumber,
  int transportation_line_id,
  int transfer_position_id,
  File? image,
  int university_id ,
      ) =_SignUpObject;
}

@freezed

class UpdateStudentObject with _$UpdateStudentObject{
  factory UpdateStudentObject (
      int studentId,
      {
    int? city_id,
    int? area_id,
    String? street,
    int? subscription_id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    int? transportation_line_id,
    int? transfer_position_id,
    File? image,
    int? university_id ,
}
  ) =_UpdateStudentObject;
}

@freezed

class ResetPasswordObject with _$ResetPasswordObject{
  factory ResetPasswordObject(String email,int code,String newPassword)=_ResetPasswordObject;
}
@freezed

class LostItemObject with _$LostItemObject{
  factory LostItemObject(
      int tripId,
      String description,
      File? image,
  )=_LostItemObject;
}

@freezed

class DailyReservationObject with _$DailyReservationObject{
  factory DailyReservationObject(
      int tripId,
      String name,
      int phone,
 int transfer_position_id,
      int seet,
      String fcm_token

      )=_DailyReservationObject;
}

@freezed

class ChangePasswordObject with _$ChangePasswordObject {
  factory ChangePasswordObject(
      String newPassword_confirmation,
      String oldPassword,
      String newPassword,      )
  =_ChangePasswordObject;
}

@freezed
class CreateSalonObject with _$CreateSalonObject {
  factory CreateSalonObject(
      String name,
      String desc,
      File ?image,
      String status,
      String lat,
      String lng
      )
  =_CreateSalonObject;
}
@freezed
class CreateAdminObject with _$CreateAdminObject {
  factory CreateAdminObject(
      String? name,
      String? password,
      int? id,
      )
  =_CreateAdminObject;
}
@freezed
class CreateServiceObject with _$CreateServiceObject {
  factory CreateServiceObject(
      String name,
      String desc,
      File ?image,
      String status,
      String price,
      int employeeId
      )
  =_CreateServiceObject;
}

@freezed
class CreateEmployeeObject with _$CreateEmployeeObject {
  factory CreateEmployeeObject(
      String name,
      String salary,
      File ?image,
      )
  =_CreateEmployeeObject;
}
@freezed
class CreateProductObject with _$CreateProductObject {
  factory CreateProductObject(
      String name,
      String desc,
      File ?image,
      String quantity,
      String price,
      )
  =_CreateProductObject;
}