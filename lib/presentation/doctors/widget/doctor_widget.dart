import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

Widget doctorWidget({
  required String spTitle,
  required String title,
  required String placeTitle,
  String? address,
  String? rate,
  required int id,
  required BuildContext context,
  required VoidCallback function,
  required String text,
}) {
  final ui = AppUi.of(context);

  return Padding(
    padding: EdgeInsets.only(
      bottom: ui.cardSpacing,
    ),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ui.cardRadius,
        ),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(
          ui.cardPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // =================================================
            // Header
            // =================================================
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Doctor Icon
                Container(
                  width: ui.iconBoxSize,
                  height: ui.iconBoxSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorManager.medicalPrimary.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(
                      ui.smallRadius + 2,
                    ),
                  ),
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: ColorManager.medicalPrimary,
                    size: ui.iconSize,
                  ),
                ),

                SizedBox(
                  width: ui.sectionSpacing,
                ),

                // Name + specialization
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ui.cardTitleSize,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.medicalPrimary,
                        ),
                      ),

                      SizedBox(
                        height: ui.smallSpacing / 2,
                      ),

                      Text(
                        spTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF64748B),
                          fontSize: ui.smallTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: ui.mediumSpacing,
            ),

            // =================================================
            // Place
            // =================================================
            _buildDoctorInfoRow(
              context: context,
              icon: Icons.location_on_outlined,
              value: placeTitle,
              color: const Color(0xFF64748B),
            ),

            // =================================================
            // Address
            // =================================================
            if (address != null) ...[
              SizedBox(
                height: ui.smallSpacing,
              ),
              _buildDoctorInfoRow(
                context: context,
                icon: Icons.map_outlined,
                value: address,
                color: const Color(0xFF64748B),
              ),
            ],

            // =================================================
            // Rate
            // =================================================
            if (rate != null) ...[
              SizedBox(
                height: ui.smallSpacing,
              ),
              _buildDoctorInfoRow(
                context: context,
                icon: Icons.star_rate_rounded,
                value: rate,
                color: ColorManager.medicalSecondary,
              ),
            ],

            SizedBox(
              height: ui.mediumSpacing,
            ),

            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFF1F5F9),
            ),

            SizedBox(
              height: ui.mediumSpacing,
            ),

            // =================================================
            // Action
            // =================================================
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: function,
                  borderRadius: BorderRadius.circular(
                    ui.smallRadius + 2,
                  ),
                  child: buildCardButton(
                    context,
                    text,
                    ColorManager.medicalPrimary,
                    Colors.white,
                    Icons.directions_run,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// =======================================================
// Doctor Info Row
// =======================================================

Widget _buildDoctorInfoRow({
  required BuildContext context,
  required IconData icon,
  required String value,
  required Color color,
}) {
  final ui = AppUi.of(context);

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: ui.smallIconSize + 1,
        color: color,
      ),

      SizedBox(
        width: ui.smallSpacing,
      ),

      Expanded(
        child: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: color,
            fontSize: ui.bodyTextSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}