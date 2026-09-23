import 'package:domina_app/presentation/uniti/animation/pressable_effect.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/place_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class HospitalArchiveCard extends StatelessWidget {
  const HospitalArchiveCard({
    super.key,
    required this.hospitalGroup,
  });

  /// كل عناصر هذه القائمة تخص نفس المشفى (نفس hospitalId)
  /// وتختلف فقط بالاختصاص/الشعبة (titleSp).
  final List<HospitalSpAllModel> hospitalGroup;

  @override
  Widget build(BuildContext context) {
    final HospitalSpAllModel hospital = hospitalGroup.first;

    final deviceType = AppResponsive.deviceType(context);

    double padding;
    double titleSize;
    double infoSize;
    double iconSize;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        padding = 16;
        titleSize = 18;
        infoSize = 14;
        iconSize = 20;
        break;

      case AppDeviceType.tabletPortrait:
        padding = 20;
        titleSize = 20;
        infoSize = 15;
        iconSize = 22;
        break;

      case AppDeviceType.tabletLandscape:
        padding = 20;
        titleSize = 20;
        infoSize = 15;
        iconSize = 22;
        break;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.055),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // اسم المشفى
          Text(
            hospital.title ?? '',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: ColorManager.medicalPrimary,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 14),

          HospitalArchiveInfoRow(
            icon: Icons.location_on_outlined,
            text: hospital.placeTitle ?? '',
            fontSize: infoSize,
            iconSize: iconSize,
          ),

          HospitalArchiveInfoRow(
            icon: Icons.map_outlined,
            text: hospital.address ?? '',
            fontSize: infoSize,
            iconSize: iconSize,
          ),

          const SizedBox(height: 14),

          // الشعب/الاختصاصات التابعة لهذا المشفى
          ...hospitalGroup.map(
            (sp) => HospitalArchiveDepartmentRow(
              hospitalSp: sp,
              fontSize: infoSize,
              iconSize: iconSize,
            ),
          ),

          const SizedBox(height: 4),

          Divider(
            height: 1,
            thickness: 0.6,
            color: Colors.grey.shade200,
          ),

          const SizedBox(height: 14),

          Align(
            alignment: Alignment.centerLeft,
            child: AppInkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.hospitalDetails,
                  arguments: hospitalGroup,
                );
              },
              child: buildCardButton(context,
                'عرض التفاصيل',
                ColorManager.medicalPrimary,
                Colors.white,
                Icons.directions_run,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HospitalArchiveDepartmentRow extends StatelessWidget {
  const HospitalArchiveDepartmentRow({
    super.key,
    required this.hospitalSp,
    required this.fontSize,
    required this.iconSize,
  });

  final HospitalSpAllModel hospitalSp;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final String titleSp = hospitalSp.titleSp?.trim() ?? '';

    if (titleSp.isEmpty) {
      return const SizedBox.shrink();
    }

    final int visited = hospitalSp.visited ?? 0;
    final int remaining = (hospitalSp.visit - visited).clamp(0, hospitalSp.visit);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorManager.medicalPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_special_outlined,
            size: iconSize,
            color: ColorManager.medicalPrimary,
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Text(
              titleSp,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: ColorManager.medicalText,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: ColorManager.medicalPrimary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'متبقي $remaining',
              style: TextStyle(
                color: ColorManager.medicalPrimary,
                fontSize: fontSize - 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HospitalArchiveInfoRow extends StatelessWidget {
  const HospitalArchiveInfoRow({
    super.key,
    required this.icon,
    required this.text,
    required this.fontSize,
    required this.iconSize,
    this.color = Colors.grey,
  });

  final IconData icon;
  final String text;

  final double fontSize;
  final double iconSize;

  final Color color;

  @override
  Widget build(BuildContext context) {
    if (text.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: color,
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: color,
                fontSize: fontSize,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}