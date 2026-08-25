// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class AnimatedPlaceCard extends StatefulWidget {
  const AnimatedPlaceCard({
    super.key,
    required this.place,
    required this.onTap,
  });

  final dynamic place;
  final VoidCallback onTap;

  @override
  State<AnimatedPlaceCard> createState() => _AnimatedPlaceCardState();
}

class _AnimatedPlaceCardState extends State<AnimatedPlaceCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);
    final String totalVisits = widget.place.totalVisit?.toString() ?? '0';

    return GestureDetector(
      // =====================================================
      // سلوك الضغط والتفاعل
      // =====================================================
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },

      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },

      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },

      onTap: widget.onTap,

      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 250,
        ),

        width: double.infinity,

        margin: EdgeInsets.only(
          bottom: ui.cardSpacing,
        ),

        padding: EdgeInsets.all(
          ui.cardPadding,
        ),

        decoration: BoxDecoration(
          color: isPressed ? ColorManager.medicalBg : Colors.white,

          borderRadius: BorderRadius.circular(
            ui.cardRadius,
          ),

          border: Border.all(
            color: isPressed ? Colors.transparent : const Color(0xFFE2E8F0),
          ),

          boxShadow: [
            BoxShadow(
              color: isPressed
                  ? ColorManager.medicalPrimary.withOpacity(0.12)
                  : Colors.black.withOpacity(0.03),

              blurRadius: 12,

              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // =================================================
            // Location Icon
            // =================================================
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 250,
              ),

              width: ui.iconBoxSize + 4,
              height: ui.iconBoxSize + 4,

              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: isPressed
                    ? ColorManager.medicalPrimary
                    : ColorManager.medicalPrimary.withOpacity(0.08),

                borderRadius: BorderRadius.circular(
                  ui.smallRadius + 4,
                ),
              ),

              child: Icon(
                Icons.location_on_rounded,

                size: ui.iconSize,

                color: isPressed ? Colors.white : ColorManager.medicalPrimary,
              ),
            ),

            SizedBox(
              width: ui.mediumSpacing,
            ),

            // =================================================
            // Place Content (Title & Visits)
            // =================================================
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label: اسم المنطقة
                  Text(
                    'اسم المنطقة',
                    style: TextStyle(
                      fontSize: ui.smallTextSize,
                      color: const Color(0xFF94A3B8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(
                    height: ui.smallSpacing / 3,
                  ),

                  // Place Title
                  AnimatedDefaultTextStyle(
                    duration: const Duration(
                      milliseconds: 250,
                    ),

                    style: TextStyle(
                      fontWeight: FontWeight.w700,

                      fontSize: ui.cardTitleSize,

                      color: ColorManager.medicalPrimary,

                      height: 1.2,
                    ),

                    child: Text(
                      widget.place.title,

                      maxLines: 1,

                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(
                    height: ui.smallSpacing,
                  ),

                  // =========================================
                  // Total Visits Badge (إجمالي زيارات المنطقة)
                  // =========================================
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(
                      horizontal: ui.mediumSpacing,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isPressed
                          ? Colors.white
                          : const Color(0xFFEFF6FF), // أزرق هادئ
                      borderRadius: BorderRadius.circular(
                        ui.smallRadius,
                      ),
                      border: Border.all(
                        color: isPressed
                            ? Colors.transparent
                            : const Color(0xFFDBEAFE),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.analytics_outlined,
                          size: ui.smallIconSize,
                          color: const Color(0xFF2563EB),
                        ),
                        SizedBox(
                          width: ui.smallSpacing / 2,
                        ),
                        Text(
                          'إجمالي زيارات المنطقة: ',
                          style: TextStyle(
                            fontSize: ui.smallTextSize,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF3B82F6),
                          ),
                        ),
                        Text(
                          totalVisits,
                          style: TextStyle(
                            fontSize: ui.smallTextSize + 1,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1D4ED8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: ui.smallSpacing,
            ),

            // =================================================
            // Arrow Action
            // =================================================
            AnimatedRotation(
              duration: const Duration(
                milliseconds: 250,
              ),

              turns: isPressed ? -0.02 : 0,

              child: Container(
                width: ui.isMobile ? 32 : 36,

                height: ui.isMobile ? 32 : 36,

                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color: isPressed
                      ? Colors.white
                      : const Color(0xFFF8FAFC),

                  borderRadius: BorderRadius.circular(
                    ui.smallRadius,
                  ),
                  border: Border.all(
                    color: const Color(0xFFF1F5F9),
                  ),
                ),

                child: Icon(
                  Icons.arrow_forward_ios_rounded,

                  size: ui.smallIconSize - 2,

                  color: ColorManager.medicalMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}