// كروت الإحصائيات (الزيارات، التصنيف، الأطباء)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    ) {
  return Container(
    width: 105.w.clamp(100.0, 150.0),

    padding: EdgeInsets.symmetric(
      vertical: 15.h.clamp(13.0, 20.0),
      horizontal: 8.w.clamp(8.0, 12.0),
    ),

    transform: Matrix4.translationValues(
      0,
      -25.h.clamp(20.0, 30.0),
      0,
    ),

    decoration: BoxDecoration(
      color: Colors.white,

      borderRadius: BorderRadius.circular(
        20.r.clamp(18.0, 24.0),
      ),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
        ),
      ],
    ),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color.withOpacity(0.6),
          size: 20.sp.clamp(19.0, 25.0),
        ),

        SizedBox(
          height: 5.h.clamp(5.0, 8.0),
        ),

        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp.clamp(17.0, 23.0),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0D47A1),
          ),
        ),

        SizedBox(
          height: 2.h.clamp(2.0, 4.0),
        ),

        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp.clamp(11.0, 15.0),
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}