import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SquareInteractiveCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  const SquareInteractiveCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<SquareInteractiveCard> createState() => _SquareInteractiveCardState();
}

class _SquareInteractiveCardState extends State<SquareInteractiveCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false; // متغير لمتابعة حالة الضغط

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) {
          _controller.forward();
          setState(() => _isPressed = true);
        },
        onTapUp: (_) {
          _controller.reverse();
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () {
          _controller.reverse();
          setState(() => _isPressed = false);
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 160.h, // ارتفاع مناسب ليكون واضحاً
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              // تغيير لون البوردر عند اللمس
              border: Border.all(
                color: _isPressed ? widget.iconColor : Colors.black.withOpacity(0.1),
                width: 0.5,
              ),
              // تغيير لون البوردر عند اللمس
              boxShadow: [
                BoxShadow(
                  color: _isPressed ? widget.iconColor.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 8),
                ),
              ],

            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: Stack(
                children: [
                  // الخط الملون العلوي (تفاعل إضافي للكارد المربع)
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    top: _isPressed ? 0 : -5.h,
                    left: 40.w,
                    right: 40.w,
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

                  // المحتوى الداخلي
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // أيقونة تتغير خلفيتها ولونها عند اللمس
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: _isPressed
                                ? widget.iconColor
                                : widget.iconColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),

                          child: Icon(
                              widget.icon,
                              color: _isPressed ? Colors.white : widget.iconColor,
                              size: 32.sp
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: _isPressed ? widget.iconColor : const Color(0xFF2C3E50),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.subtitle,
                          style: TextStyle(fontSize: 11.sp, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}