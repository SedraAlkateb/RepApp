import 'dart:io';

import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data.freezed.dart';



@freezed
class DailyReservationObject with _$DailyReservationObject {
  factory DailyReservationObject(
      int tripId,
      String name,
      int phone,
      int transfer_position_id,
      int seet,
      String fcm_token) = _DailyReservationObject;
}





@freezed
class InsertRecipesObject with _$InsertRecipesObject {
  factory InsertRecipesObject(
    String repId,
    String type,
    String docId,
    String spName,
      BrandRes brand_1,
    String address,
    String phone,
    String total,
    String? create_date,
    String? print_date,
    String flagImage1,
      String flagImage2,
    String? note1,
    String? note2,
    String? note_emp,
    File? image1,
    File? image2,
      BrandRes? brand_2,
      BrandRes? brand_3,
      BrandRes? brand_4,
  ) = _InsertRecipesObject;

  factory InsertRecipesObject.empty() => InsertRecipesObject(
        UserInfo.repId.toString(),
        '0',
        '',
        '',
    BrandRes(0, ""),
        '',
        '',
        '',
        '',
        '',
    '',
    '',
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      );
}
