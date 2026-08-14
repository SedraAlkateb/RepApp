import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class HospitalCardWidget extends StatelessWidget {
  final HospitalSpModel hospital;

  const HospitalCardWidget({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double cardBottomSpacing;
    double cardRadius;
    double cardPadding;

    double hospitalIconBoxSize;
    double hospitalIconSize;
    double hospitalIconRadius;
    double hospitalIconSpacing;

    double hospitalNameFontSize;
    double rateFontSize;

    double sectionSpacing;
    double infoTileSpacing;

    double infoTileVerticalPadding;
    double infoTileHorizontalPadding;
    double infoTileRadius;
    double infoIconSize;
    double infoFontSize;

    double badgeHorizontalPadding;
    double badgeVerticalPadding;
    double badgeRadius;
    double badgeFontSize;

    double notePadding;
    double noteRadius;
    double noteTitleFontSize;
    double noteTextFontSize;
    double noteIconSize;

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
        rateFontSize = 12;

        sectionSpacing = 12;
        infoTileSpacing = 8;

        infoTileVerticalPadding = 8;
        infoTileHorizontalPadding = 10;
        infoTileRadius = 12;
        infoIconSize = 15;
        infoFontSize = 11;

        badgeHorizontalPadding = 8;
        badgeVerticalPadding = 4;
        badgeRadius = 8;
        badgeFontSize = 10;

        notePadding = 12;
        noteRadius = 14;
        noteTitleFontSize = 11;
        noteTextFontSize = 12;
        noteIconSize = 18;
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
        rateFontSize = 13;

        sectionSpacing = 16;
        infoTileSpacing = 12;

        infoTileVerticalPadding = 11;
        infoTileHorizontalPadding = 14;
        infoTileRadius = 14;
        infoIconSize = 18;
        infoFontSize = 13;

        badgeHorizontalPadding = 10;
        badgeVerticalPadding = 5;
        badgeRadius = 10;
        badgeFontSize = 11;

        notePadding = 14;
        noteRadius = 16;
        noteTitleFontSize = 13;
        noteTextFontSize = 13;
        noteIconSize = 20;
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
        rateFontSize = 12.5;

        sectionSpacing = 14;
        infoTileSpacing = 10;

        infoTileVerticalPadding = 9;
        infoTileHorizontalPadding = 12;
        infoTileRadius = 13;
        infoIconSize = 16;
        infoFontSize = 12;

        badgeHorizontalPadding = 9;
        badgeVerticalPadding = 4;
        badgeRadius = 9;
        badgeFontSize = 10.5;

        notePadding = 13;
        noteRadius = 15;
        noteTitleFontSize = 12;
        noteTextFontSize = 12.5;
        noteIconSize = 19;
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
                  // Hospital data
                  // =============================================
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // ===================================
                            // Hospital name
                            // ===================================
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

                            const SizedBox(
                              width: 8,
                            ),

                            // ===================================
                            // Specialization Badge
                            // نفس الشرط الأصلي
                            // ===================================
                            if (hospital.rate != null &&
                                hospital.rate!.isNotEmpty)
                              _buildBadge(
                                text: hospital.SpName ?? "عام",
                                bgColor: const Color(
                                  0xFFFEF3C7,
                                ),
                                textColor: const Color(
                                  0xFFD97706,
                                ),
                                horizontalPadding:
                                badgeHorizontalPadding,
                                verticalPadding:
                                badgeVerticalPadding,
                                radius: badgeRadius,
                                fontSize: badgeFontSize,
                              ),
                          ],
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        // =======================================
                        // Rate
                        // =======================================
                        Text(
                          "تصنيف ${hospital.rate}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: rateFontSize,
                            color: const Color(
                              0xFF7C3AED,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
                height: infoTileSpacing,
              ),

              // =================================================
              // Visits
              // =================================================
              _buildFullAddressTile(
                Icons.map_outlined,
                "الزيارات: ${hospital.visit}",
                bgColor: const Color(
                  0xFFF0FDF4,
                ),
                textColor: const Color(
                  0xFF16A34A,
                ),
                iconColor: const Color(
                  0xFF16A34A,
                ),
                verticalPadding:
                infoTileVerticalPadding,
                horizontalPadding:
                infoTileHorizontalPadding,
                radius: infoTileRadius,
                iconSize: infoIconSize,
                fontSize: infoFontSize,
              ),

              // =================================================
              // Notes
              // نفس الشرط الأصلي
              // =================================================
              if (hospital.note != null &&
                  hospital.note!.isNotEmpty) ...[
                SizedBox(
                  height: sectionSpacing,
                ),

                Container(
                  width: double.infinity,

                  padding: EdgeInsets.all(
                    notePadding,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFFFFBEB,
                    ),

                    borderRadius: BorderRadius.circular(
                      noteRadius,
                    ),

                    border: Border.all(
                      color: const Color(
                        0xFFFEF3C7,
                      ),
                    ),
                  ),

                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: noteIconSize,
                        color: const Color(
                          0xFFD97706,
                        ),
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "توجيهات وملاحظات",
                              style: TextStyle(
                                fontSize:
                                noteTitleFontSize,
                                fontWeight:
                                FontWeight.bold,
                                color: const Color(
                                  0xFFB45309,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 3,
                            ),

                            Text(
                              hospital.note!,
                              style: TextStyle(
                                fontSize:
                                noteTextFontSize,
                                color: const Color(
                                  0xFF451A03,
                                ),
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Badge
  // =====================================================

  Widget _buildBadge({
    required String text,
    required Color bgColor,
    required Color textColor,
    required double horizontalPadding,
    required double verticalPadding,
    required double radius,
    required double fontSize,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),

      decoration: BoxDecoration(
        color: bgColor,

        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),

      child: Text(
        text,

        maxLines: 1,
        overflow: TextOverflow.ellipsis,

        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: textColor,
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

  // =====================================================
  // Full Width Info Tile
  // =====================================================

  Widget _buildFullAddressTile(
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
    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),

      decoration: BoxDecoration(
        color: bgColor,

        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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

              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}