import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedPlaceCard extends StatefulWidget {
  final dynamic place; // مرر الموديل الخاص بك هنا
  final VoidCallback onTap;

  const AnimatedPlaceCard(
      {super.key, required this.place, required this.onTap});

  @override
  State<AnimatedPlaceCard> createState() => _AnimatedPlaceCardState();
}

class _AnimatedPlaceCardState extends State<AnimatedPlaceCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      // --- لحظة رفع الإصبع (Up) ---
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
        // تنفيذ الأكشن الفعلي بعد رفع الإصبع
   //     widget.onTap();
      },
      // --- في حال سحب الإصبع للخارج أو إلغاء اللمس ---
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250), // سرعة التحول
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          // تغيير لون الخلفية بالكامل عند الضغط
          color: isPressed ? ColorManager.medicalBg : Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: isPressed ? Colors.transparent : Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: isPressed
                  ? ColorManager.medicalPrimary.withOpacity(0.3)
                  : Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // أيقونة الموقع الجانبية
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                // لون أيقونة الموقع يتغير ليصبح أغمق أو أفتح حسب الخلفية
                color: isPressed
                    ? ColorManager.medicalPrimary
                    : const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.location_on_outlined,
                size: 25.sp,
                color: isPressed ? Colors.white : ColorManager.medicalPrimary,
              ),
            ),
            SizedBox(width: 15.w),
            // نص اسم المنطقة
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: ColorManager.medicalPrimary,
                ),
                child: Text(widget.place.title),
              ),
            ),
            // أيقونة السهم
            AnimatedRotation(
              duration: const Duration(milliseconds: 250),
              turns: isPressed ? -0.02 : 0, // حركة ميلان بسيطة للسهم عند الضغط
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: ColorManager.medicalMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
