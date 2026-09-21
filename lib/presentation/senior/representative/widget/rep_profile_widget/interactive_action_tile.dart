import 'package:domina_app/presentation/uniti/animation/pressable_effect.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// =======================================================
// Interactive Action Tile
//
// مستخدم بالملف الكامل والخطة المنتهية
// =======================================================

class InteractiveActionTile
    extends StatefulWidget {
  const InteractiveActionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final dynamic icon;
  final Color color;
  final VoidCallback onTap;

  @override
  State<InteractiveActionTile>
  createState() =>
      _InteractiveActionTileState();
}

class _InteractiveActionTileState
    extends State<InteractiveActionTile> {
  bool isPressed =
  false;

  @override
  Widget build(BuildContext context) {
    final ui =
    AppUi.of(context);

    final double minHeight =
    ui.isMobile
        ? 68
        : ui.isTabletPortrait
        ? 78
        : 70;

    final double tileHorizontalPadding =
    ui.isMobile
        ? 14
        : ui.isTabletPortrait
        ? 18
        : 15;

    final double tileVerticalPadding =
    ui.isTabletPortrait
        ? 15
        : 12;

    final double tileRadius =
        ui.cardRadius - 2;

    final double iconBoxSize =
    ui.isTabletPortrait
        ? 50
        : 44;

    final double actionIconSize =
    ui.isTabletPortrait
        ? 21
        : 18;

    final double arrowBoxSize =
    ui.isTabletPortrait
        ? 36
        : 32;

    final double arrowSize =
    ui.isTabletPortrait
        ? 14
        : 13;

    return PressableEffect(pressedScale: 1.0, child: GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed =
          true;
        });
      },

      onTapUp: (_) {
        setState(() {
          isPressed =
          false;
        });
      },

      onTapCancel: () {
        setState(() {
          isPressed =
          false;
        });
      },

      onTap:
      widget.onTap,

      child:
      AnimatedScale(
        duration:
        const Duration(
          milliseconds: 120,
        ),

        scale:
        isPressed
            ? 0.985
            : 1,

        child:
        AnimatedContainer(
          duration:
          const Duration(
            milliseconds:
            160,
          ),

          constraints:
          BoxConstraints(
            minHeight:
            minHeight,
          ),

          // =================================================
          // بالـLandscape الصفوف نفسها مسؤولة عن المسافة
          // =================================================
          margin:
          EdgeInsets.only(
            bottom: ui
                .isTabletLandscape
                ? 0
                : ui.cardSpacing,
          ),

          padding:
          EdgeInsets.symmetric(
            horizontal:
            tileHorizontalPadding,

            vertical:
            tileVerticalPadding,
          ),

          decoration:
          BoxDecoration(
            color:
            isPressed
                ? widget
                .color
                .withOpacity(
              0.025,
            )
                : Colors
                .white,

            borderRadius:
            BorderRadius.circular(
              tileRadius,
            ),

            border:
            Border.all(
              color:
              isPressed
                  ? widget
                  .color
                  .withOpacity(
                0.22,
              )
                  : const Color(
                0xFFE2E8F0,
              ),
            ),

            boxShadow: [
              BoxShadow(
                color: isPressed
                    ? widget.color
                    .withOpacity(
                  0.055,
                )
                    : Colors.black
                    .withOpacity(
                  0.025,
                ),

                blurRadius:
                isPressed
                    ? 8
                    : 12,

                offset:
                const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),

          child: Row(
            children: [
              // =============================================
              // Icon
              // =============================================
              AnimatedContainer(
                duration:
                const Duration(
                  milliseconds:
                  160,
                ),

                width:
                iconBoxSize,

                height:
                iconBoxSize,

                alignment:
                Alignment.center,

                decoration:
                BoxDecoration(
                  color:
                  isPressed
                      ? widget
                      .color
                      : widget
                      .color
                      .withOpacity(
                    0.08,
                  ),

                  borderRadius:
                  BorderRadius
                      .circular(
                    ui.smallRadius +
                        2,
                  ),
                ),

                child: widget.icon
                is IconData
                    ? Icon(
                  widget.icon,

                  size:
                  actionIconSize,

                  color:
                  isPressed
                      ? Colors
                      .white
                      : widget
                      .color,
                )
                    : FaIcon(
                  widget.icon
                  as FaIconData,

                  size:
                  actionIconSize -
                      1,

                  color:
                  isPressed
                      ? Colors
                      .white
                      : widget
                      .color,
                ),
              ),

              SizedBox(
                width:
                ui.sectionSpacing,
              ),

              // =============================================
              // Title
              // =============================================
              Expanded(
                child: Text(
                  widget.title,

                  maxLines:
                  2,

                  overflow:
                  TextOverflow
                      .ellipsis,

                  style:
                  TextStyle(
                    fontSize:
                    ui.bodyTextSize +
                        1,

                    height:
                    1.3,

                    fontWeight:
                    FontWeight
                        .w600,

                    color:
                    const Color(
                      0xFF34495E,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width:
                ui.mediumSpacing,
              ),

              // =============================================
              // Arrow
              // =============================================
              AnimatedContainer(
                duration:
                const Duration(
                  milliseconds:
                  160,
                ),

                width:
                arrowBoxSize,

                height:
                arrowBoxSize,

                alignment:
                Alignment.center,

                decoration:
                BoxDecoration(
                  color:
                  isPressed
                      ? widget
                      .color
                      .withOpacity(
                    0.08,
                  )
                      : const Color(
                    0xFFF8FAFC,
                  ),

                  borderRadius:
                  BorderRadius
                      .circular(
                    ui.smallRadius,
                  ),
                ),

                child: Icon(
                  Icons
                      .arrow_forward_ios_rounded,

                  size:
                  arrowSize,

                  color:
                  isPressed
                      ? widget
                      .color
                      : const Color(
                    0xFFCBD5E1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
