import 'package:domina_app/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RepresentativeCard extends StatefulWidget {
  final AllRepresentative allRepresentative;
  final VoidCallback onTap; // أضفنا هذا السطر

  const RepresentativeCard({
    super.key,
    required this.allRepresentative,
    required this.onTap, // أضفنا هذا السطر
  });
  @override
  State<RepresentativeCard> createState() => _RepresentativeCardState();
}

class _RepresentativeCardState extends State<RepresentativeCard> {
  bool _isPressed = false;

  String _getInitial(String name) {
    if (name.isEmpty) return "";
    return name.trim().substring(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap(); // تنفيذ الانتقال هنا عند رفع الإصبع
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white, // خلفية بيضاء ثابتة مثل التصميم
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            // تغيير لون الإطار الخارجي فقط عند الضغط
            color: _isPressed
                ? const Color(0xFF1F4E79).withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                // يتغير من رمادي فاتح إلى كحلي عند الضغط
                color: _isPressed
                    ? const Color(0xFF1F4E79)
                    : const Color(0xFFF7F9FC),
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: Text(
                _getInitial(widget.allRepresentative.name),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: _isPressed ? Colors.white : const Color(0xFF1F4E79),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // 2. معلومات المندوب
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //    mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  textAlign: TextAlign.start,
                  widget.allRepresentative.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F4E79),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${widget.allRepresentative.number} زيارة اليوم',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),

            const Spacer(),

            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9FC), // مربع رمادي فاتح للسهم
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded, // السهم المعتمد في الصور
                color: _isPressed ? const Color(0xFF1F4E79) : Colors.grey[300],
                size: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
