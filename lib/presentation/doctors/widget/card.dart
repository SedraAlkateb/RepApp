import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildInfoRow(IconData icon, String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
            Text(value,
                style: TextStyle(
                    color: const Color(0xFF0D47A1),
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp)),
          ],
        ),
      ),
      SizedBox(width: 15.w),
      Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10.r)),
        child: Icon(icon, color: Colors.blue, size: 20.sp),
      ),
    ],
  );
}
