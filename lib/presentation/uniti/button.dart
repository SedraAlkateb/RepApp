import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ButtonWidget(Function()? onPressed,String text){
  return
    Padding(
      padding: EdgeInsets.symmetric(
          horizontal:2.w, vertical: 8.h
      ), // مسافة عن حواف الشاشة
      child: SizedBox(
        width: double.infinity, // لجعل الزر يأخذ عرض الصفحة بالكامل
        height: 50.h, // التحكم بطول (ارتفاع) الزر
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:  ColorManager.medicalPrimary, // نفس اللون الأزرق في صورك
            foregroundColor: Colors.white, // لون النص
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r), // زوايا منحنية لتناسب بقية الواجهة
            ),
            elevation: 2, // ظل خفيف للزر
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
}