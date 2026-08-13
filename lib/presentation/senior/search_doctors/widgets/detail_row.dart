import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

Widget buildDetailRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
    ) {
  final ui = AppUi.of(context);

  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: ui.smallSpacing,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =================================================
        // Icon
        // =================================================
        Container(
          width: ui.smallIconSize + 14,
          height: ui.smallIconSize + 14,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorManager.medicalPrimary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(
              ui.smallRadius,
            ),
          ),
          child: Icon(
            icon,
            color: ColorManager.medicalPrimary,
            size: ui.smallIconSize,
          ),
        ),

        SizedBox(
          width: ui.mediumSpacing,
        ),

        // =================================================
        // Text
        // =================================================
        Expanded(
          child: RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: TextStyle(
                fontSize: ui.bodyTextSize,
                color: const Color(0xFF475569),
                height: 1.45,
              ),
              children: [
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF334155),
                  ),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}