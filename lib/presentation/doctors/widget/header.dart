import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildHeader(String? title) {
  return  Container(
    width: double.infinity,
    padding: EdgeInsets.only(bottom: 40.h, top: 20.h),
    decoration: BoxDecoration(
      color: ColorManager.medicalPrimary,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Icon(Icons.local_hospital, color: Colors.white, size: 50.sp),
        ),
        SizedBox(height: 15.h),
        Text(
          title ?? "",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
