// ignore_for_file: must_be_immutable

import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// عنوان القسم
Widget _buildSectionTitle(String title, {bool hasDot = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (hasDot) Icon(Icons.circle, color: Colors.red, size: 8.sp),
        if (hasDot) SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF0D47A1),
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
        ),
      ],
    ),
  );
}

// حقل إدخال الملاحظات
Widget _buildNoteTextField(String hint) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TextField(
        maxLines: 4,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15.w),
        ),
      ),
    ),
  );
}

// القائمة المنسدلة المخصصة
Widget _buildCustomDropdown(String hint) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Align(
            alignment: Alignment.centerRight,
            child: Text(hint, style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
          ),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.blueGrey),
          items: [], // أضف العناصر هنا
          onChanged: (val) {},
        ),
      ),
    ),
  );
}


class BoxTextField extends StatelessWidget {
  const BoxTextField({
    Key? key,
    this.minLines,
    this.maxLines,
    this.enabled,
    this.hintStyle,
    this.inputFormatters,
    required this.keyboardType,
    this.prefixIcon, // جعلته اختياري ليناسب التصميم
    this.suffixIcon,
    required this.validator,
    required this.controller,
    required this.obscureText,
    this.onchange,
    this.hintText, // أضفت هينت تيكست ليكون مرن
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onchange;
  final bool obscureText;
  final int? minLines;
  final int? maxLines;
  final bool? enabled;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h), // مسافة سفلية متناسقة
      child: TextFormField(
        onChanged: onchange,
        inputFormatters: inputFormatters,
        maxLines: maxLines ?? 1,
        minLines: minLines,
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        readOnly: enabled ?? false,
        textAlign: TextAlign.right, // ليدعم اللغة العربية بشكل صحيح
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor:  ColorManager.inputBorder, // اللون الرمادي الفاتح من الصورة
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(fontSize: 13.sp, color: Colors.grey),

          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,

          // تحسين المسافات الداخلية ليكون النص مرتاحاً
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

          // الحدود الدائرية المتناسقة مع صورك (borderRadius: 15.r أو 20.r)
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none, // إخفاء الحدود الافتراضية
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 0.5), // حدود خفيفة جداً
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: Color(0xFF0D47A1), width: 1), // حدود زرقاء عند التركيز
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: Colors.red, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
        ),
      ),
    );
  }
}