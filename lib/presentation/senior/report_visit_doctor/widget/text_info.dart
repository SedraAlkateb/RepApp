import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class TextInfo extends StatelessWidget {
  const TextInfo({
    super.key,
    required this.title,
    required this.supTitle,
    this.showDivider = true,
    this.icon,
  });

  final String title;
  final String? supTitle;
  final bool showDivider;
  final IconData? icon;

  // =======================================================
  // Valid Value
  // نفس السلوك الأصلي
  // =======================================================

  bool get _isValidValue =>
      supTitle != null &&
          supTitle!.trim().isNotEmpty &&
          supTitle!.trim() != ".";

  @override
  Widget build(BuildContext context) {
    if (!_isValidValue) {
      return const SizedBox.shrink();
    }

    final ui = AppUi.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: ui.smallSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // =====================================================
          // Information
          // =====================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // Optional Icon
              // =================================================
              if (icon != null) ...[
                Container(
                  width: ui.smallIconSize + 14,
                  height: ui.smallIconSize + 14,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.primary1.withOpacity(
                      0.07,
                    ),
                    borderRadius: BorderRadius.circular(
                      ui.smallRadius,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: ui.smallIconSize,
                    color: ColorManager.primary1,
                  ),
                ),

                SizedBox(
                  width: ui.mediumSpacing,
                ),
              ],

              // =================================================
              // Title + Value
              // =================================================
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "$title: ",
                        style: TextStyle(
                          fontSize: ui.bodyTextSize,
                          fontWeight: FontWeight.w700,
                          color: const Color(
                            0xFF334155,
                          ),
                          height: 1.45,
                        ),
                      ),
                      TextSpan(
                        text: supTitle!,
                        style: TextStyle(
                          fontSize: ui.bodyTextSize,
                          fontWeight: FontWeight.w500,
                          color: const Color(
                            0xFF64748B,
                          ),
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),

          // =====================================================
          // Divider
          // =====================================================
          if (showDivider) ...[
            SizedBox(
              height: ui.mediumSpacing,
            ),

            const Divider(
              height: 1,
              thickness: 1,
              color: Color(
                0xFFF1F5F9,
              ),
            ),

            SizedBox(
              height: ui.smallSpacing,
            ),
          ],
        ],
      ),
    );
  }
}