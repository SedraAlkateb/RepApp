import 'package:domina_app/presentation/uniti/animation/pressable_effect.dart';
// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/resources/app_palette.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class AnimatedPlaceCard extends StatefulWidget {
  const AnimatedPlaceCard({
    super.key,
    required this.place,
    required this.onTap,
    required this.isRep
  });

  final dynamic place;
  final bool isRep;
  final VoidCallback onTap;

  @override
  State<AnimatedPlaceCard> createState() => _AnimatedPlaceCardState();
}

class _AnimatedPlaceCardState extends State<AnimatedPlaceCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);
    final p = context.palette;
    final String totalVisits = widget.place.totalVisit?.toString() ?? '0';

    return PressableEffect(pressedScale: 1.0, child: GestureDetector(
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
          color: isPressed ? p.bg : p.surface,

          borderRadius: BorderRadius.circular(
            ui.cardRadius,
          ),

          border: Border.all(
            color: isPressed ? Colors.transparent : p.border,
          ),

          boxShadow: [
            BoxShadow(
              color: isPressed
                  ? p.primary.withOpacity(0.12)
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
                    : p.primary.withOpacity(0.08),

                borderRadius: BorderRadius.circular(
                  ui.smallRadius + 4,
                ),
              ),

              child: Icon(
                Icons.location_on_rounded,

                size: ui.iconSize,

                color: isPressed ? Colors.white : p.primary,
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
                      color: p.muted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(
                    height: ui.smallSpacing / 3,
                  ),

                  // Place Title
                  // ملاحظة: بدون AnimatedDefaultTextStyle لأنه يستبدل
                  // DefaultTextStyle بدل ما يدمجه مع الثيم، فيضيع الخط
                  // (Almarai) الموروث. Text العادي بيدمج ستايله مع الثيم.
                  Text(
                    widget.place.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: ui.cardTitleSize,
                      color: p.primary,
                      height: 1.2,
                    ),
                  ),

                  SizedBox(
                    height: ui.smallSpacing,
                  ),

                  // =========================================
                  // Total Visits Badge (إجمالي زيارات المنطقة)
                  // =========================================

                widget.isRep?
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(
                      horizontal: ui.mediumSpacing,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isPressed
                          ? p.surface
                          : p.infoBg, // أزرق هادئ
                      borderRadius: BorderRadius.circular(
                        ui.smallRadius,
                      ),
                      border: Border.all(
                        color: isPressed
                            ? Colors.transparent
                            : p.infoBorder,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.analytics_outlined,
                          size: ui.smallIconSize,
                          color: p.infoText,
                        ),
                        SizedBox(
                          width: ui.smallSpacing / 2,
                        ),
                        Text(
                          'إجمالي زيارات المنطقة: ',
                          style: TextStyle(
                            fontSize: ui.smallTextSize,
                            fontWeight: FontWeight.w500,
                            color: p.infoText,
                          ),
                        ),
                        Text(
                          totalVisits,
                          style: TextStyle(
                            fontSize: ui.smallTextSize + 1,
                            fontWeight: FontWeight.w800,
                            color: p.infoText,
                          ),
                        ),
                      ],
                    ),
                  ):SizedBox(),
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
                      ? p.surface
                      : p.surfaceAlt,

                  borderRadius: BorderRadius.circular(
                    ui.smallRadius,
                  ),
                  border: Border.all(
                    color: p.border,
                  ),
                ),

                child: Icon(
                  Icons.arrow_forward_ios_rounded,

                  size: ui.smallIconSize - 2,

                  color: p.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}