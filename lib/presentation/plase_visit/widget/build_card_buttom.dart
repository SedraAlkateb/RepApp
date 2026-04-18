
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildCardButton(String label, Color bg, Color text, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10.r)),
    child: Text(label, style: TextStyle(color: text, fontWeight: FontWeight.bold)),
  );
}
Widget buildCardActionText(String label, IconData icon) {
  return Row(
    children: [
      Text(label, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      SizedBox(width: 4.w),
      Icon(icon, color: Colors.blue, size: 18.sp),
    ],
  );
}