import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dataPlan(String? startDate, String? endData) {
  return Card(
    shadowColor: ColorManager.secondaryColor7,
    child: Text(
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ColorManager.secondaryColor7,
        fontSize: 17.sp,
        fontWeight: FontWeight.bold,
      ),
      "\nتاريخ الخطة : ${startDate ?? 'غير متاح'} >>> ${endData ?? 'غير متاح'} \n ",
    ),
    margin: EdgeInsets.symmetric(horizontal: 20),
  );
}
