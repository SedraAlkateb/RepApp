import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget hospitalWidget({
 required String spTitle,
  required String title,
  required String placeTitle,
   String? address,
   String? rate,
  required int id,
  required BuildContext context,
  required VoidCallback function,
  required String text
}){
  return  Container(
    margin: EdgeInsets.only(
        bottom: 16.h, right: 8.w, left: 8.w),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black
              .withOpacity(0.08), // درجة غمق الظل
          blurRadius: 15, // مدى نعومة الظل
          spreadRadius: 0, // مدى انتشار الظل
          offset: const Offset(0,
              6), // إزاحة الظل للأسفل ليعطي عمقاً (Shadow Offset)
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(spTitle ,
                  style: TextStyle(
                      color: Colors.blue, fontSize: 12.sp)),
            ),
            Expanded(
              child: Text(
                  textAlign: TextAlign.end,
                  title,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.medicalPrimary)),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on_outlined,
                size: 22.sp, color: Colors.grey),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Text(placeTitle,
                  style: TextStyle(
                      color: Colors.grey, fontSize: 15.sp)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on_outlined,
                size: 22.sp, color: Colors.grey),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Text(address ?? "",
                  style: TextStyle(
                      color: Colors.grey, fontSize: 15.sp)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.star_rate_outlined,
                size: 22.sp,
                color: ColorManager.medicalSecondary),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Text(rate ?? "",
                  style: TextStyle(
                      color: ColorManager.medicalSecondary,
                      fontSize: 15.sp)),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Divider(
          color: Colors.grey,
          thickness: 0.1,
        ),
        SizedBox(height: 8.h),
        // أزرار الأكشن
        Row(
          children: [
            const Spacer(),
            InkWell(
              onTap:function,
              child: buildCardButton(
                  text,
                  ColorManager.medicalPrimary,
                  Colors.white,
                  Icons.directions_run),
            ),
          ],
        ),
      ],
    ),
  );
}