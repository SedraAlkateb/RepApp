// كروت الإحصائيات (الزيارات، التصنيف، الأطباء)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildStatCard(
    String title, String value, IconData icon, Color color) {
  return Container(
    width: 105.w,
    padding: EdgeInsets.symmetric(vertical: 15.h),
    transform: Matrix4.translationValues(
        0, -25.h, 0), // لجعل الكروت تتداخل مع الهيدر
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color.withOpacity(0.6), size: 20.sp),
        SizedBox(height: 5.h),
        Text(value,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0D47A1))),
        Text(title, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
      ],
    ),
  );
}
