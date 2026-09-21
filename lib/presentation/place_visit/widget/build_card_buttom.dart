import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

Widget buildCardButton(
    BuildContext context,
    String label,
    Color bg,
    Color text,
    IconData icon,
    ) {
  final ui = AppUi.of(context);

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: ui.isMobile ? 20 : 24,
      vertical: ui.isMobile ? 8 : 10,
    ),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(
        ui.smallRadius,
      ),
    ),
    child: Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: text,
        fontSize: ui.isMobile ? 13 : 15,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget buildCardActionText(
    BuildContext context,
    String label,
    IconData icon,
    ) {
  final ui = AppUi.of(context);

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: ColorManager.medicalPrimary,
            fontSize: ui.isMobile ? 13 : 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      SizedBox(
        width: ui.smallSpacing,
      ),
      Icon(
        icon,
        color: ColorManager.medicalPrimary,
        size: ui.smallIconSize + 2,
      ),
    ],
  );
}