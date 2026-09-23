import 'package:domina_app/presentation/uniti/animation/pressable_effect.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/place_visit/visit_widget.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/plan_review/bloc/future_rep_bloc.dart';
import 'package:domina_app/presentation/senior/plan_review/widget/dialog_doc_hos.dart';
import 'package:domina_app/presentation/senior/plan_review/widget/stat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildSampleStatisticsSummaryCard(
    BrandAmountModel planBrandSp,
    int samplesCount,
    {required int repPlanId, required int spId}
    ) {
  return Builder(
    builder: (context) {
      final deviceType = AppResponsive.deviceType(context);

      double cardPadding;
      double cardRadius;
      double titleFontSize;
      double labelFontSize;
      double countFontSize;
      double iconSize;
      double spacing;

      switch (deviceType) {
        case AppDeviceType.mobilePortrait:
          cardPadding = 16;
          cardRadius = 20;
          titleFontSize = 14;
          labelFontSize = 11;
          countFontSize = 18;
          iconSize = 18;
          spacing = 8;
          break;

        case AppDeviceType.tabletPortrait:
          cardPadding = 20;
          cardRadius = 24;
          titleFontSize = 16;
          labelFontSize = 13;
          countFontSize = 22;
          iconSize = 22;
          spacing = 12;
          break;

        case AppDeviceType.tabletLandscape:
          cardPadding = 18;
          cardRadius = 22;
          titleFontSize = 15;
          labelFontSize = 12;
          countFontSize = 20;
          iconSize = 20;
          spacing = 10;
          break;
      }

      int totalVisits = planBrandSp.numDepartment + planBrandSp.numDoctor + planBrandSp.numHospital;

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cardRadius),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F4E79).withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // العنوان الرئيسي للبطاقة
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.analytics_outlined,
                    size: 18,
                    color: Color(0xFF1F4E79),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "إجمالي عدد الزيارات",
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F4E79),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing * 1.5),

            // قسم الأرقام والإحصائيات مقسمة بانتظام
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 1. زر المشافي والشعب
                Expanded(
                  child: AppInkWell(

                    borderRadius: BorderRadius.circular(50),

                    onTap: () {
                      showHosDocSearchDialog(
                        context: context,
                        title: "قائمة المشافي والشعب",
                        isHospital: true,
                      );

                      BlocProvider.of<FutureRepBloc>(context).add(
                        HosSpSearchEvent(repPlanId, spId),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: buildStatItem(
                        title: "المشافي والشعب",
                        count: planBrandSp.numHospital + planBrandSp.numDepartment,
                        icon: Icons.local_hospital_outlined,
                        color: const Color(0xFF0D9488),
                        bgColor:  Colors.transparent,
                        labelSize: labelFontSize,
                        countSize: countFontSize,
                        iconSize: iconSize,
                      ),
                    ),
                  ),
                ),

                buildDivider(),

                // 2. زر الأطباء
                Expanded(
                  child: AppInkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showHosDocSearchDialog(
                        context: context,
                        title: "قائمة الأطباء",
                        isHospital: false,
                      );

                      BlocProvider.of<FutureRepBloc>(context).add(
                        DocSpSearchEvent(repPlanId, spId),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: buildStatItem(
                        title: "الأطباء",
                        count: planBrandSp.numDoctor,
                        icon: Icons.person_outline_rounded,
                        color: const Color(0xFF2563EB),
                        bgColor: const Color(0xFFEFF6FF),
                        labelSize: labelFontSize,
                        countSize: countFontSize,
                        iconSize: iconSize,
                      ),
                    ),
                  ),
                ),

                buildDivider(),

                // 3. الكلي (مع تصميم محسّن للـ Tooltip وارتفاعه لمنع تغطية الكلمات مباشرة)
                Expanded(
                  child: Tooltip(
                    // جعل اللوجيك يظهر للأعلى بشكل مريح ويبتعد عن العناصر الأساسية
                    preferBelow: false,

                    verticalOffset: 50, // المسافة الفاصلة بين العنصر والـ Tooltip
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    triggerMode: TooltipTriggerMode.tap,
                    message: "العدد الكلي: ${totalVisits * samplesCount}",
                    waitDuration: const Duration(milliseconds: 100),
                    showDuration: const Duration(seconds: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B), // لون داكن فخم ونظيف
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: buildStatItem(
                        title: "الكلي",
                        count: totalVisits,
                        icon: Icons.medication_outlined,
                        color: const Color(0xFFD97706),
                        bgColor: const Color(0xFFFFFBEB),
                        labelSize: labelFontSize,
                        countSize: countFontSize,
                        iconSize: iconSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}