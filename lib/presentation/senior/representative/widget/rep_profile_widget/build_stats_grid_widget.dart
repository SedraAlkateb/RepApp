import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// =====================================================
// Statistics Grid
// =====================================================

Widget buildStatsGrid(
    BuildContext context,
    InfoRep rep,
    ) {
  final AppDeviceType deviceType =
  AppResponsive.deviceType(context);

  final bool showRecipesOnly =
      rep.repType == 5 || rep.repType == 6;

  late int crossAxisCount;

  late double mainAxisSpacing;
  late double crossAxisSpacing;
  late double childAspectRatio;

  late double titleFontSize;
  late double titleBottomSpacing;
  late double titleRightPadding;

  switch (deviceType) {
  // =================================================
  // Mobile
  // =================================================
    case AppDeviceType.mobilePortrait:
      crossAxisCount = showRecipesOnly ? 1 : 2;

      mainAxisSpacing = 12;
      crossAxisSpacing = 12;

      childAspectRatio =
      showRecipesOnly ? 2.70 : 1.30;

      titleFontSize = 15;
      titleBottomSpacing = 10;
      titleRightPadding = 4;
      break;

  // =================================================
  // Tablet Portrait
  // =================================================
    case AppDeviceType.tabletPortrait:
      crossAxisCount = showRecipesOnly ? 1 : 2;

      mainAxisSpacing = 16;
      crossAxisSpacing = 16;

      childAspectRatio =
      showRecipesOnly ? 4.50 : 1.70;

      titleFontSize = 17;
      titleBottomSpacing = 14;
      titleRightPadding = 6;
      break;

  // =================================================
  // Tablet Landscape
  // =================================================
    case AppDeviceType.tabletLandscape:
      crossAxisCount = showRecipesOnly ? 1 : 4;

      mainAxisSpacing = 14;
      crossAxisSpacing = 14;

      childAspectRatio =
      showRecipesOnly ? 5.50 : 1.20;

      titleFontSize = 17;
      titleBottomSpacing = 14;
      titleRightPadding = 6;
      break;
  }

  final List<Widget> statisticCards;

  if (showRecipesOnly) {
    statisticCards = [
      buildStatCard(
        "الوصفات",
        rep.recipesCount.toString(),
        const Color(0xFF8E44AD),
      ),
    ];
  } else {
    statisticCards = [
      buildStatCard(
        "إجمالي الزيارات",
        rep.totalVisit.toString(),
        const Color(0xFF1F4E79),
      ),

      buildStatCard(
        "الوصفات",
        rep.recipesCount.toString(),
        const Color(0xFF7C3AED),
      ),

      // =================================================
      // Total Visits By Type
      // =================================================
      buildStatCard(
        "إجمالي زيارات الأطباء",
        rep.totDocVisit.toString(),
        const Color(0xFF3F7FBF),
      ),

      buildStatCard(
        "إجمالي زيارات المشافي",
        rep.totHosVisit.toString(),
        const Color(0xFF3F7FBF),
      ),

      // =================================================
      // Completed
      // =================================================
      buildStatCard(
        "زيارات الأطباء المحققة",
        rep.visitDonDoc.toString(),
        const Color(0xFF2D947A),
      ),

      buildStatCard(
        "زيارات المشافي المحققة",
        rep.visitDonHos.toString(),
        const Color(0xFF2D947A),
      ),

      // =================================================
      // Remaining
      // =================================================
      buildStatCard(
        "زيارات الأطباء المتبقية",
        (rep.totDocVisit - rep.visitDonDoc)
            .toString(),
        const Color(0xFFE67E22),
      ),

      buildStatCard(
        "زيارات المشافي المتبقية",
        (rep.totHosVisit - rep.visitDonHos)
            .toString(),
        const Color(0xFFE67E22),
      ),
    ];
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ===============================================
      // Section title
      // ===============================================
      Padding(
        padding: EdgeInsets.only(
          right: titleRightPadding,
          bottom: titleBottomSpacing,
        ),
        child: Text(
          "نظرة عامة على الإحصائيات",
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2C3E50),
          ),
        ),
      ),

      // ===============================================
      // Responsive Statistics Grid
      // ===============================================
      GridView.count(
        shrinkWrap: true,
        physics:
        const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
        children: statisticCards,
      ),
    ],
  );
}
// =====================================================
// Tablet Landscape Statistics Grid
// نفس الـ signature القديم
// =====================================================

Widget buildStatsGridTablet(
    InfoRep rep,
    ) {
  final bool showRecipesOnly =
      rep.repType == 5 || rep.repType == 6;

  final List<Widget> statisticCards;

  if (showRecipesOnly) {
    statisticCards = [
      buildStatCard(
        "الوصفات",
        rep.recipesCount.toString(),
        const Color(0xFF7C3AED),
      ),
    ];
  } else {
    statisticCards = [
      // =================================================
      // Overview
      // =================================================
      buildStatCard(
        "إجمالي الزيارات",
        rep.totalVisit.toString(),
        const Color(0xFF1F4E79),
      ),

      buildStatCard(
        "الوصفات",
        rep.recipesCount.toString(),
        const Color(0xFF7C3AED),
      ),

      // =================================================
      // Total Visits By Type
      // =================================================
      buildStatCard(
        "إجمالي زيارات الأطباء",
        rep.totDocVisit.toString(),
        const Color(0xFF3F7FBF),
      ),

      buildStatCard(
        "إجمالي زيارات المشافي",
        rep.totHosVisit.toString(),
        const Color(0xFF3F7FBF),
      ),

      // =================================================
      // Completed
      // =================================================
      buildStatCard(
        "زيارات الأطباء المحققة",
        rep.visitDonDoc.toString(),
        const Color(0xFF2D947A),
      ),

      buildStatCard(
        "زيارات المشافي المحققة",
        rep.visitDonHos.toString(),
        const Color(0xFF2D947A),
      ),

      // =================================================
      // Remaining
      // =================================================
      buildStatCard(
        "زيارات الأطباء المتبقية",
        (rep.totDocVisit - rep.visitDonDoc)
            .toString(),
        const Color(0xFFE67E22),
      ),

      buildStatCard(
        "زيارات المشافي المتبقية",
        (rep.totHosVisit - rep.visitDonHos)
            .toString(),
        const Color(0xFFE67E22),
      ),
    ];
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.black.withValues(
          alpha: 0.025,
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =============================================
        // Section title
        // =============================================
        const Padding(
          padding: EdgeInsets.only(
            right: 4,
            bottom: 14,
          ),
          child: Text(
            "نظرة عامة على الإحصائيات",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
            ),
          ),
        ),

        // =============================================
        // Statistics
        // =============================================
        GridView.count(
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          crossAxisCount:
          showRecipesOnly ? 1 : 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio:
          showRecipesOnly ? 5.50 : 1.20,
          children: statisticCards,
        ),
      ],
    ),
  );
}
// =====================================================
// Stat Card
// لا نغيّر الـ signature
// =====================================================

Widget buildStatCard(
  String title,
  String val,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 12,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
        18,
      ),
      border: Border.all(
        color: Colors.black.withOpacity(
          0.025,
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(
            0.025,
          ),
          blurRadius: 12,
          offset: const Offset(
            0,
            5,
          ),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // =============================================
        // Value
        // الرقم أولاً لأنه أهم معلومة
        // =============================================
        Text(
          val,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            height: 1,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),

        const SizedBox(
          height: 7,
        ),

        // =============================================
        // Title
        // =============================================
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            height: 1.25,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// =====================================================
// Icon Button
// نفس الـ signature
// =====================================================

Widget buildIconBtn(
  BuildContext context,
  FaIconData icon,
  String label,
  Color color,
  VoidCallback tap,
) {
  final deviceType = AppResponsive.deviceType(context);

  double boxSize;
  double iconSize;
  double radius;

  double labelFontSize;
  double labelWidth;

  double spacing;

  switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
    case AppDeviceType.mobilePortrait:
      boxSize = 50;
      iconSize = 20;
      radius = 14;

      labelFontSize = 11;
      labelWidth = 68;

      spacing = 7;
      break;

    // =================================================
    // Tablet Portrait
    // =================================================
    case AppDeviceType.tabletPortrait:
      boxSize = 56;
      iconSize = 22;
      radius = 16;

      labelFontSize = 12.5;
      labelWidth = 82;

      spacing = 8;
      break;

    // =================================================
    // Tablet Landscape
    // =================================================
    case AppDeviceType.tabletLandscape:
      boxSize = 52;
      iconSize = 20;
      radius = 14;

      labelFontSize = 12;
      labelWidth = 76;

      spacing = 7;
      break;
  }

  return InkWell(
    // =================================================
    // نفس السلوك
    // =================================================
    onTap: tap,

    borderRadius: BorderRadius.circular(
      radius,
    ),

    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // =============================================
          // Icon
          // =============================================
          Container(
            width: boxSize,
            height: boxSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(
                0.09,
              ),
              borderRadius: BorderRadius.circular(
                radius,
              ),
            ),
            child: FaIcon(
              icon,
              color: color,
              size: iconSize,
            ),
          ),

          SizedBox(
            height: spacing,
          ),

          // =============================================
          // Label
          // =============================================
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w600,
                color: const Color(
                  0xFF4B6584,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
