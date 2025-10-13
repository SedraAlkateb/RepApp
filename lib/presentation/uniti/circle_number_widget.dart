import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleNumberWidget extends StatelessWidget {
  final int number;

  CircleNumberWidget({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: ColorManager.secondaryColor2,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$number',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

