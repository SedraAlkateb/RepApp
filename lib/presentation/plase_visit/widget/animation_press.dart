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
  State<AnimatedPlaceCard> createState() =>
      _AnimatedPlaceCardState();
}

class _AnimatedPlaceCardState
    extends State<AnimatedPlaceCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return GestureDetector(
      // =====================================================
      // نفس سلوك الضغط الأصلي
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
          color: isPressed
              ? ColorManager.medicalBg
              : Colors.white,

          borderRadius: BorderRadius.circular(
            ui.cardRadius,
          ),

          border: Border.all(
            color: isPressed
                ? Colors.transparent
                : const Color(
              0xFFE2E8F0,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color: isPressed
                  ? ColorManager.medicalPrimary
                  .withOpacity(
                0.12,
              )
                  : Colors.black.withOpacity(
                0.03,
              ),

              blurRadius: 12,

              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),

        child: Row(
          children: [
            // =================================================
            // Location Icon
            // =================================================
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 250,
              ),

              width: ui.iconBoxSize,
              height: ui.iconBoxSize,

              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: isPressed
                    ? ColorManager.medicalPrimary
                    : ColorManager.medicalPrimary
                    .withOpacity(
                  0.07,
                ),

                borderRadius:
                BorderRadius.circular(
                  ui.smallRadius + 2,
                ),
              ),

              child: Icon(
                Icons.location_on_outlined,

                size: ui.iconSize,

                color: isPressed
                    ? Colors.white
                    : ColorManager
                    .medicalPrimary,
              ),
            ),

            SizedBox(
              width: ui.mediumSpacing,
            ),

            // =================================================
            // Place Name
            // =================================================
            Expanded(
              child:
              AnimatedDefaultTextStyle(
                duration: const Duration(
                  milliseconds: 250,
                ),

                style: TextStyle(
                  fontWeight:
                  FontWeight.w700,

                  fontSize:
                  ui.cardTitleSize,

                  color: ColorManager
                      .medicalPrimary,

                  height: 1.3,
                ),

                child: Text(
                  widget.place.title,

                  maxLines: 2,

                  overflow:
                  TextOverflow.ellipsis,
                ),
              ),
            ),

            SizedBox(
              width: ui.smallSpacing,
            ),

            // =================================================
            // Arrow
            // =================================================
            AnimatedRotation(
              duration: const Duration(
                milliseconds: 250,
              ),

              turns:
              isPressed ? -0.02 : 0,

              child: Container(
                width: ui.isMobile
                    ? 30
                    : 34,

                height: ui.isMobile
                    ? 30
                    : 34,

                alignment:
                Alignment.center,

                decoration: BoxDecoration(
                  color: const Color(
                    0xFFF8FAFC,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    ui.smallRadius,
                  ),
                ),

                child: Icon(
                  Icons
                      .arrow_forward_ios_rounded,

                  size:
                  ui.smallIconSize,

                  color:
                  ColorManager
                      .medicalMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}