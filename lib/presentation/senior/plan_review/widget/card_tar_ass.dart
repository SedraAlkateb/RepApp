import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/visit_widget.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/senior/plan_review/widget/stat_item.dart';
import 'package:flutter/material.dart';

Widget buildSampleStatisticsTypeSummaryCard(SumBrandAmountModel sumTargetAss,int samplesCount) {
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
                  "إجمالي توزيع العينات بالخطة",
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
                Expanded(
                  child: buildStatItem(
                    title: "هدف",
                    count: sumTargetAss.targetAmount,
                    icon: Icons.local_hospital_outlined,
                    color: const Color(0xFF0D9488),
                    bgColor: const Color(0xFFF0FDFA),
                    labelSize: labelFontSize,
                    countSize: countFontSize,
                    iconSize: iconSize,
                  ),
                ),
                buildDivider(),
                Expanded(
                  child: buildStatItem(
                    title: "مساعد",
                    count: sumTargetAss.assistantAmount,
                    icon: Icons.person_outline_rounded,
                    color: const Color(0xFF2563EB),
                    bgColor: const Color(0xFFEFF6FF),
                    labelSize: labelFontSize,
                    countSize: countFontSize,
                    iconSize: iconSize,
                  ),
                ),
                buildDivider(),
                Expanded(
                  child: Tooltip(
                    padding: const EdgeInsets.all(
                      8,
                    ),
                    triggerMode: TooltipTriggerMode.tap,
                    message: "${sumTargetAss.totalAmount * samplesCount}",
                    waitDuration: const Duration(
                      milliseconds: 100,
                    ),
                    showDuration: const Duration(
                      seconds: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(
                        18,
                      ),

                      child: buildStatItem(
                        title: "الكلي",
                        count: sumTargetAss.totalAmount,
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
