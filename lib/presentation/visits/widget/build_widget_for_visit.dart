import 'package:domina_app/presentation/uniti/box_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildEditableSection({
  required String title,
  required TextEditingController controller,
  required IconData icon,
  required bool isEditable,
  required Color iconColor,
  String? Function (String?) ?validator
}) {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            SizedBox(width: 10.w),
            Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: const Color(0xFF0D47A1))),
          ],
        ),
        SizedBox(height: 12.h),
        BoxTextField(
          validator:validator,
          controller: controller,
          enabled: !isEditable,
          maxLines: 3,
          minLines: 1,
          keyboardType: TextInputType.multiline,
          obscureText: false,
          inputFormatters: [],
          // ستايل الحقل ليكون مخفي الإطار عند عدم التعديل
        ),
      ],
    ),
  );
}
