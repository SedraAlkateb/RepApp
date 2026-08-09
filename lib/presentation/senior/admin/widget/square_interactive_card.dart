import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SquareInteractiveCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;
  final bool isLandscape;

  const SquareInteractiveCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
    required this.isLandscape,
  });

  @override
  State<SquareInteractiveCard> createState() => _SquareInteractiveCardState();
}

class _SquareInteractiveCardState extends State<SquareInteractiveCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

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
    final bool isLandscape = widget.isLandscape;

    // أبعاد متناسبة لكل وضعية
    final double cardHeight = isLandscape ? 160.h : 160.h;
    final double iconSize = isLandscape ? 24.sp : 32.sp;
    final double iconPadding = isLandscape ? 10.w : 12.w;
    final double titleFontSize = isLandscape ? 14.sp : 16.sp;
    final double subtitleFontSize = isLandscape ? 10.sp : 11.sp;

    return GestureDetector(
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
          width: double.infinity,
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isLandscape ? 18.r : 25.r),
            border: Border.all(
              color: _isPressed
                  ? widget.iconColor
                  : Colors.black.withOpacity(0.1),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isPressed
                    ? widget.iconColor.withOpacity(0.1)
                    : Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isLandscape ? 18.r : 25.r),
            child: Stack(
              children: [
                // الخط الملون العلوي التفاعلي
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  top: _isPressed ? 0 : -5.h,
                  left: isLandscape ? 50.w : 40.w,
                  right: isLandscape ? 50.w : 40.w,
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

                // المحتوى الداخلي: تبديل التنسيق حسب الوضعية
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLandscape ? 14.w : 12.w,
                    vertical: isLandscape ? 12.h : 10.h,
                  ),
                  child: isLandscape
                      ? _buildLandscapeRowLayout(
                    iconPadding,
                    iconSize,
                    titleFontSize,
                    subtitleFontSize,
                  )
                      : _buildPortraitColumnLayout(
                    iconPadding,
                    iconSize,
                    titleFontSize,
                    subtitleFontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // التنسيق للوضع الأفقي (Row)
  Widget _buildLandscapeRowLayout(
      double iconPadding,
      double iconSize,
      double titleFontSize,
      double subtitleFontSize,
      ) {
    return Row(
      children: [
        // الأيقونة
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(iconPadding),
          decoration: BoxDecoration(
            color: _isPressed
                ? widget.iconColor
                : widget.iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.icon,
            color: _isPressed ? Colors.white : widget.iconColor,
            size: iconSize,
          ),
        ),
        SizedBox(width: 12.w),
        // النصوص مرتبة عمودياً بجانب الأيقونة
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: _isPressed
                      ? widget.iconColor
                      : const Color(0xFF2C3E50),
                  height: 1.2,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: Colors.grey[500],
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        // سهم إرشادي صغير
        AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(left: _isPressed ? 4.w : 0),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: _isPressed ? widget.iconColor : Colors.grey[300],
            size: 14.sp,
          ),
        ),
      ],
    );
  }

  // التنسيق للوضع الطولي (Column) - نَفْس شكل كودك الأصلي تماماً
  Widget _buildPortraitColumnLayout(
      double iconPadding,
      double iconSize,
      double titleFontSize,
      double subtitleFontSize,
      ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(iconPadding),
            decoration: BoxDecoration(
              color: _isPressed
                  ? widget.iconColor
                  : widget.iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.icon,
              color: _isPressed ? Colors.white : widget.iconColor,
              size: iconSize,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: _isPressed
                  ? widget.iconColor
                  : const Color(0xFF2C3E50),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.subtitle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: subtitleFontSize,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}