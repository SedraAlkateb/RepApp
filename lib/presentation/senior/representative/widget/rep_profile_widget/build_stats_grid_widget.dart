import 'package:domina_app/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//عامودي
Widget buildStatsGrid(BuildContext context, InfoRep rep) {
  // فحص ما إذا كان الجهاز تابلت بناءً على عرض الشاشة (مثلاً 600 dp فأكثر)
  final bool isTablet = MediaQuery.of(context).size.width >= 600;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 10.h, right: 5.w),
        child: Text(
          "نظرة عامة على الإحصائيات",
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF2C3E50)),
        ),
      ),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // 4 أعمدة للتابلت و 2 للموبايل
        crossAxisCount: isTablet ? 4 : 2,
        mainAxisSpacing: 15.h,
        crossAxisSpacing: 15.w,
        // نسبة أبعاد 1.0 للتابلت و 1.25 للموبايل
        childAspectRatio: isTablet ? 1.0 : 1.25,
        children: [
          buildStatCard("إجمالي الزيارات", rep.totalVisit.toString(),
              const Color(0xFF1F4E79)),
          buildStatCard("الوصفات", rep.recipesCount, const Color(0xFF8E44AD)),
          buildStatCard("زيارات الأطباء المحققة", rep.visitDonDoc,
              const Color(0xFF2D947A)),
          buildStatCard("زيارات الأطباء المتبقية", rep.totDocVisit,
              const Color(0xFFE67E22)),
          buildStatCard("زيارات المشافي المحققة", rep.visitDonHos,
              const Color(0xFF2D947A)),
          buildStatCard("زيارات المشافي المتبقية", rep.totHosVisit,
              const Color(0xFFE67E22)),
          buildStatCard("إجمالي المحققة", rep.visitDon.toString(),
              const Color(0xFF1F4E79)),
          buildStatCard("إجمالي المتبقية", rep.visitNoteYet.toString(),
              const Color(0xFFE67E22)),
        ],
      ),
    ],
  );
}

// شبكة إحصائيات 4 أعمدة في التابلت لتقليل الارتفاع واستغلال العرض
Widget buildStatsGridTablet(InfoRep rep) {
  return Container(
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(25.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Text(
            "نظرة عامة على الإحصائيات",
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C3E50)),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4, // 4 أعمدة لاستغلال العرض
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 0.9,
          children: [
            buildStatCard("إجمالي الزيارات", rep.totalVisit.toString(),
                const Color(0xFF1F4E79)),
            buildStatCard(
                "الوصفات", rep.recipesCount, const Color(0xFF8E44AD)),
            buildStatCard("الأطباء المحققة", rep.visitDonDoc,
                const Color(0xFF2D947A)),
            buildStatCard("الأطباء المتبقية", rep.totDocVisit,
                const Color(0xFFE67E22)),
            buildStatCard("المشافي المحققة", rep.visitDonHos,
                const Color(0xFF2D947A)),
            buildStatCard("المشافي المتبقية", rep.totHosVisit,
                const Color(0xFFE67E22)),
            buildStatCard("إجمالي المحققة", rep.visitDon.toString(),
                const Color(0xFF1F4E79)),
            buildStatCard("إجمالي المتبقية", rep.visitNoteYet.toString(),
                const Color(0xFFE67E22)),
          ],
        ),
      ],
    ),
  );
}

Widget buildStatCard(String title, String val, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25.r),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8))
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
              fontSize: 9.sp,
              color: Colors.grey[500],
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.h),
        Text(
          val,
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.w900, color: color),
        ),
      ],
    ),
  );
}
Widget buildIconBtn(BuildContext context, FaIconData icon, String label,
    Color color, VoidCallback tap) {
  return InkWell(
    onTap: tap,
    borderRadius: BorderRadius.circular(20.r),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r)),
          child: FaIcon(icon, color: color, size: 20.sp),
        ),
        SizedBox(height: 8.h),
        Text(label,
            style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4B6584))),
      ],
    ),
  );
}
