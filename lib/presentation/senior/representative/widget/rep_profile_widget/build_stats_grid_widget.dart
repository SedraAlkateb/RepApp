import 'package:domina_app/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// =====================================================
// Statistics Grid
// =====================================================

Widget buildStatsGrid(BuildContext context, InfoRep rep) {
  final size = MediaQuery.sizeOf(context);
  final bool isTablet = size.shortestSide >= 600;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(
          bottom: isTablet ? 14 : 10,
          right: isTablet ? 8 : 5,
        ),
        child: Text(
          "نظرة عامة على الإحصائيات",
          style: TextStyle(
            fontSize: isTablet ? 17 : 15,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF2C3E50),
          ),
        ),
      ),

      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        // Mobile = 2
        // Tablet = 4
        crossAxisCount: isTablet ? 4 : 2,

        mainAxisSpacing: isTablet ? 16 : 15,
        crossAxisSpacing: isTablet ? 16 : 15,

        // حتى لا تصبح الكروت طويلة جدًا على التابلت
        childAspectRatio: isTablet ? 1.15 : 1.25,

        children: [
          buildStatCard(
            "إجمالي الزيارات",
            rep.totalVisit.toString(),
            const Color(0xFF1F4E79),
          ),
          buildStatCard(
            "الوصفات",
            rep.recipesCount,
            const Color(0xFF8E44AD),
          ),
          buildStatCard(
            "زيارات الأطباء المحققة",
            rep.visitDonDoc,
            const Color(0xFF2D947A),
          ),
          buildStatCard(
            "زيارات الأطباء المتبقية",
            rep.totDocVisit,
            const Color(0xFFE67E22),
          ),
          buildStatCard(
            "زيارات المشافي المحققة",
            rep.visitDonHos,
            const Color(0xFF2D947A),
          ),
          buildStatCard(
            "زيارات المشافي المتبقية",
            rep.totHosVisit,
            const Color(0xFFE67E22),
          ),
          buildStatCard(
            "إجمالي المحققة",
            rep.visitDon.toString(),
            const Color(0xFF1F4E79),
          ),
          buildStatCard(
            "إجمالي المتبقية",
            rep.visitNoteYet.toString(),
            const Color(0xFFE67E22),
          ),
        ],
      ),
    ],
  );
}

// =====================================================
// Tablet Statistics Grid
// =====================================================

Widget buildStatsGridTablet(InfoRep rep) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(25),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
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

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          crossAxisCount: 4,

          mainAxisSpacing: 14,
          crossAxisSpacing: 14,

          childAspectRatio: 1.15,

          children: [
            buildStatCard(
              "إجمالي الزيارات",
              rep.totalVisit.toString(),
              const Color(0xFF1F4E79),
            ),
            buildStatCard(
              "الوصفات",
              rep.recipesCount,
              const Color(0xFF8E44AD),
            ),
            buildStatCard(
              "الأطباء المحققة",
              rep.visitDonDoc,
              const Color(0xFF2D947A),
            ),
            buildStatCard(
              "الأطباء المتبقية",
              rep.totDocVisit,
              const Color(0xFFE67E22),
            ),
            buildStatCard(
              "المشافي المحققة",
              rep.visitDonHos,
              const Color(0xFF2D947A),
            ),
            buildStatCard(
              "المشافي المتبقية",
              rep.totHosVisit,
              const Color(0xFFE67E22),
            ),
            buildStatCard(
              "إجمالي المحققة",
              rep.visitDon.toString(),
              const Color(0xFF1F4E79),
            ),
            buildStatCard(
              "إجمالي المتبقية",
              rep.visitNoteYet.toString(),
              const Color(0xFFE67E22),
            ),
          ],
        ),
      ],
    ),
  );
}

// =====================================================
// Stat Card
// نفس الـ signature تماماً
// =====================================================

Widget buildStatCard(
    String title,
    String val,
    Color color,
    ) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 14,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[500],
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 6,
        ),

        Text(
          val,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// =====================================================
// Icon Button
// =====================================================

Widget buildIconBtn(
    BuildContext context,
    FaIconData icon,
    String label,
    Color color,
    VoidCallback tap,
    ) {
  final bool isTablet =
      MediaQuery.sizeOf(context).shortestSide >= 600;

  return InkWell(
    onTap: tap,
    borderRadius: BorderRadius.circular(
      isTablet ? 22 : 20,
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(
            isTablet ? 16 : 14,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              isTablet ? 22 : 20,
            ),
          ),
          child: FaIcon(
            icon,
            color: color,
            size: isTablet ? 23 : 20,
          ),
        ),

        SizedBox(
          height: isTablet ? 10 : 8,
        ),

        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isTablet ? 13 : 11,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4B6584),
          ),
        ),
      ],
    ),
  );
}