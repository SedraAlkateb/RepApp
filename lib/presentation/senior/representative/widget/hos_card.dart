import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/place_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/uniti/animation/pressable_effect.dart';
import 'package:flutter/material.dart';

class HospitalCardWidget extends StatelessWidget {
  final List<HospitalSpModel> hospitalGroup;

  const HospitalCardWidget({
    super.key,
    required this.hospitalGroup,
  });

  @override
  Widget build(BuildContext context) {
    final HospitalSpModel hospital = hospitalGroup.first;

    final deviceType = AppResponsive.deviceType(context);

    double cardBottomSpacing;
    double cardRadius;
    double cardPadding;

    double hospitalIconBoxSize;
    double hospitalIconSize;
    double hospitalIconRadius;
    double hospitalIconSpacing;

    double hospitalNameFontSize;

    double sectionSpacing;
    double infoTileSpacing;

    double infoTileVerticalPadding;
    double infoTileHorizontalPadding;
    double infoTileRadius;
    double infoIconSize;
    double infoFontSize;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:
        cardBottomSpacing = 12;
        cardRadius = 18;
        cardPadding = 16;

        hospitalIconBoxSize = 46;
        hospitalIconSize = 23;
        hospitalIconRadius = 13;
        hospitalIconSpacing = 12;

        hospitalNameFontSize = 16;

        sectionSpacing = 12;
        infoTileSpacing = 8;

        infoTileVerticalPadding = 8;
        infoTileHorizontalPadding = 10;
        infoTileRadius = 12;
        infoIconSize = 15;
        infoFontSize = 11;
        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        cardBottomSpacing = 14;
        cardRadius = 20;
        cardPadding = 20;

        hospitalIconBoxSize = 54;
        hospitalIconSize = 27;
        hospitalIconRadius = 15;
        hospitalIconSpacing = 16;

        hospitalNameFontSize = 19;

        sectionSpacing = 16;
        infoTileSpacing = 12;

        infoTileVerticalPadding = 11;
        infoTileHorizontalPadding = 14;
        infoTileRadius = 14;
        infoIconSize = 18;
        infoFontSize = 13;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        cardBottomSpacing = 12;
        cardRadius = 18;
        cardPadding = 18;

        hospitalIconBoxSize = 50;
        hospitalIconSize = 25;
        hospitalIconRadius = 14;
        hospitalIconSpacing = 14;

        hospitalNameFontSize = 18;

        sectionSpacing = 14;
        infoTileSpacing = 10;

        infoTileVerticalPadding = 9;
        infoTileHorizontalPadding = 12;
        infoTileRadius = 13;
        infoIconSize = 16;
        infoFontSize = 12;
        break;
    }

    return Container(
      margin: EdgeInsets.only(
        bottom: cardBottomSpacing,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(
          cardRadius,
        ),

        border: Border.all(
          color: Colors.black.withOpacity(0.035),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          cardRadius,
        ),

        child: Padding(
          padding: EdgeInsets.all(
            cardPadding,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // Hospital Header
              // =================================================
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // =============================================
                  // Hospital icon
                  // =============================================
                  Container(
                    width: hospitalIconBoxSize,
                    height: hospitalIconBoxSize,

                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2F1),

                      borderRadius: BorderRadius.circular(
                        hospitalIconRadius,
                      ),
                    ),

                    child: Icon(
                      Icons.local_hospital_rounded,
                      color: const Color(0xFF00897B),
                      size: hospitalIconSize,
                    ),
                  ),

                  SizedBox(
                    width: hospitalIconSpacing,
                  ),

                  // =============================================
                  // Hospital name
                  // =============================================
                  Expanded(
                    child: Text(
                      hospital.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: hospitalNameFontSize,
                        fontWeight: FontWeight.w700,
                        color: const Color(
                          0xFF1E293B,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: sectionSpacing,
              ),

              // =================================================
              // Place + Address
              // =================================================
              Row(
                children: [
                  _buildInfoTile(
                    Icons.location_on_outlined,
                    hospital.placeTitle ?? "",
                    verticalPadding:
                    infoTileVerticalPadding,
                    horizontalPadding:
                    infoTileHorizontalPadding,
                    radius: infoTileRadius,
                    iconSize: infoIconSize,
                    fontSize: infoFontSize,
                  ),

                  SizedBox(
                    width: infoTileSpacing,
                  ),

                  _buildInfoTile(
                    Icons.directions_run_rounded,
                    hospital.address ?? "",
                    verticalPadding:
                    infoTileVerticalPadding,
                    horizontalPadding:
                    infoTileHorizontalPadding,
                    radius: infoTileRadius,
                    iconSize: infoIconSize,
                    fontSize: infoFontSize,
                  ),
                ],
              ),

              SizedBox(
                height: sectionSpacing,
              ),

              // =================================================
              // عرض التفاصيل
              // =================================================
              Align(
                alignment: Alignment.centerLeft,
                child: AppInkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.hospitalDetails,
                      arguments: hospitalGroup
                          .map((sp) => sp.toHospitalSpAllModel())
                          .toList(),
                    );
                  },
                  child: buildCardButton(
                    context,
                    'عرض التفاصيل',
                    ColorManager.medicalPrimary,
                    Colors.white,
                    Icons.directions_run,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Info Tile
  // =====================================================

  Widget _buildInfoTile(
      IconData icon,
      String text, {
        Color bgColor = const Color(0xFFF8FAFC),
        Color textColor = const Color(0xFF475569),
        Color iconColor = const Color(0xFF94A3B8),
        required double verticalPadding,
        required double horizontalPadding,
        required double radius,
        required double iconSize,
        required double fontSize,
      }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),

        decoration: BoxDecoration(
          color: bgColor,

          borderRadius: BorderRadius.circular(
            radius,
          ),

          border: Border.all(
            color: const Color(
              0xFFE2E8F0,
            ).withOpacity(0.5),
          ),
        ),

        child: Row(
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),

            const SizedBox(
              width: 6,
            ),

            Expanded(
              child: Text(
                text.isEmpty
                    ? "غير محدد"
                    : text,

                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
