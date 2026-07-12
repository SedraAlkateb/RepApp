import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoRowItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const InfoRowItem({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: ColorManager.secondaryColor1.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              size: 16.sp,
              color: ColorManager.secondaryColor1,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // يقص النص الطويل جداً بنقاط منعاً للـ Overflow
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}