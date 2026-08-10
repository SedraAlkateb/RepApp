import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildHeader(String? title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.only(
      bottom: 40.h.clamp(32.0, 48.0),
      top: 20.h.clamp(18.0, 28.0),
    ),
    decoration: const BoxDecoration(
      color: ColorManager.medicalPrimary,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(
            15.w.clamp(14.0, 20.0),
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(
              20.r.clamp(18.0, 24.0),
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          child: Icon(
            Icons.local_hospital,
            color: Colors.white,
            size: 50.sp.clamp(44.0, 60.0),
          ),
        ),

        SizedBox(
          height: 15.h.clamp(12.0, 20.0),
        ),

        Text(
          title ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp.clamp(20.0, 28.0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}