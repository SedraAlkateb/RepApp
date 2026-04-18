import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InteractiveAdminCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  const InteractiveAdminCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<InteractiveAdminCard> createState() => _InteractiveAdminCardState();
}

class _InteractiveAdminCardState extends State<InteractiveAdminCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.all(22.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          // تغيير لون البوردر عند اللمس
          border: Border.all(
            color: _isPressed ? widget.iconColor : Colors.black.withOpacity(0.05),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isPressed ? widget.iconColor.withOpacity(0.12) : Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. الخط الملون العلوي (جديد)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                top: _isPressed ? -22.h : -30.h, // ينزلق للحافة العلوية عند الضغط
                left: 60.w,
                right: 60.w,
                child: Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: widget.iconColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                  ),
                ),
              ),

              // 2. الخط الجانبي الملون (من جهة اليمين)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                right: _isPressed ? -22.w : -30.w, // حركة للداخل عند الضغط
                top: 5.h,
                bottom: 5.h,
                child: Container(
                  width: 5.w,
                  decoration: BoxDecoration(
                    color: widget.iconColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),

              // محتوى الكارد الأساسي
              Row(
                children: [
                  // الأيقونة (تغيير ذكي للألوان)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: _isPressed ? widget.iconColor : widget.iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Icon(
                      widget.icon,
                      color: _isPressed ? Colors.white : widget.iconColor,
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primaryText,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.subtitle,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  // سهم التنقل
                  AnimatedPadding(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.only(left: _isPressed ? 5.w : 0),
                    child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: _isPressed ? widget.iconColor : Colors.grey[300],
                        size: 16.sp
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}