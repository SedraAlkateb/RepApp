import 'package:flutter/material.dart';

class DropDownChangePlan extends StatelessWidget {
  const DropDownChangePlan({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.validator,
    this.width,
    this.value,
    this.onTap,
    this.statusColor,
    required String errorText,
  });

  final String hintText;
  final List<dynamic> items;
  final double? width;
  final ValueSetter<dynamic> onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<dynamic>? validator;
  final String? value;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    final Color primaryNavy = const Color(0xFF0D47A1);

    // الألوان مع الشفافية (Opacity)
    final Color contentColor = statusColor ?? primaryNavy;
    final Color bgColor = contentColor.withOpacity(0.1);

    return DropdownButtonFormField<dynamic>(
      elevation: 8, // رفع خفيف للقائمة عند الفتح
      validator: validator,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: contentColor, size: 20),

      // تعديل شكل النص المختار (Selected Item)
      selectedItemBuilder: (BuildContext context) {
        return items.map<Widget>((dynamic item) {
          return Text(
            item.name,
            style: TextStyle(
              color: contentColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          );
        }).toList();
      },

      hint: Text(
        hintText,
        style: TextStyle(
          color: contentColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: bgColor,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

        // 1. الحدود الافتراضية
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),

        // 2. الحدود عند التمكين (قبل الضغط)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),

        // 3. الحل هنا: الحدود عند الضغط (Focus)
        // جعلناها BorderSide.none لإلغاء اللون الأزرق تماماً
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),

        // إذا كنت تريد ظهور حدود خفيفة بلونك الخاص عند الضغط بدلاً من الاختفاء التام:
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   borderSide: BorderSide(color: contentColor.withOpacity(0.5), width: 1),
        // ),
      ),


      // تعديل شكل القائمة المنسدلة (الخلفية والحواف)
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(15),
      isExpanded: true,

      items: items.map((dynamic val) {
        return DropdownMenuItem(
          value: val,
          onTap: onTap ?? () {},
          child: Container(

            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              // تمييز العنصر المختار داخل القائمة بخلفية شفافة
              color: value == val ? bgColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10), // حني الـ Items داخل القائمة
            ),
            child: Text(
              "${val.name}",
              style: TextStyle(
                fontSize: 14,
                color: value == val ? contentColor : Colors.black87,
                fontWeight: value == val ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      value: value,
    );
  }
}