import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class InfoRowItem extends StatelessWidget {
  const InfoRowItem({
    super.key,
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ui.smallSpacing / 2,
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          // =================================================
          // Icon
          // =================================================
          Container(
            width: ui.smallIconSize + 14,
            height: ui.smallIconSize + 14,

            alignment: Alignment.center,

            decoration: BoxDecoration(
              color: ColorManager.secondaryColor1.withOpacity(
                0.08,
              ),

              borderRadius: BorderRadius.circular(
                ui.smallRadius,
              ),
            ),

            child: Icon(
              icon,
              size: ui.smallIconSize,
              color: ColorManager.secondaryColor1,
            ),
          ),

          SizedBox(
            width: ui.mediumSpacing,
          ),

          // =================================================
          // Value
          // =================================================
          Expanded(
            child: Text(
              value,

              maxLines: 1,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                fontSize: ui.bodyTextSize,
                color: const Color(
                  0xFF475569,
                ),
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}