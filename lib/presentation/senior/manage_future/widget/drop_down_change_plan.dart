import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class DropDownChangePlan extends StatelessWidget {
  const DropDownChangePlan({
    super.key,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.validator,
    this.width,
    this.value,
    this.onTap,
    this.statusColor,
    required String errorText,
  });

  final String hintText;
  final List<FlagModel> items;
  final double? width;
  final ValueSetter<FlagModel?>? onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<FlagModel>? validator;
  final FlagModel? value;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    final Color contentColor = statusColor ?? ColorManager.primary1;
    final Color bgColor = contentColor.withOpacity(0.1);

    // 🛡️ خطوة الحماية الذهبية:
    // نتحقق بمطابقة الـ flag الرقمي الداخلي حتى لو تم إنشاء مصفوفة جديدة في الذاكرة
    final FlagModel? safelySelectedValue = value != null &&
        items.any((element) => element.flag == value!.flag)
        ? items.firstWhere((element) => element.flag == value!.flag)
        : null;

    return DropdownButtonFormField<FlagModel>(
      elevation: 8,
      validator: validator,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: contentColor, size: 20),

      selectedItemBuilder: (BuildContext context) {
        return items.map<Widget>((FlagModel item) {
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(15),
      isExpanded: true,

      items: items.map((FlagModel val) {
        final bool isSelected = safelySelectedValue != null && safelySelectedValue.flag == val.flag;

        return DropdownMenuItem<FlagModel>(
          value: val,
          onTap: onTap ?? () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? bgColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              val.name,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? contentColor : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      value: safelySelectedValue,
    );
  }
}