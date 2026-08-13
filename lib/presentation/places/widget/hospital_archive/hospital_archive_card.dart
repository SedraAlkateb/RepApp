import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class HospitalArchiveCard extends StatelessWidget {
  const HospitalArchiveCard({
    super.key,
    required this.hospital,
  });

  final HospitalSpAllModel hospital;

  @override
  Widget build(BuildContext context) {
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

          HospitalArchiveInfoRow(
            icon: Icons.folder_special_outlined,
            text: hospital.titleSp ?? '',
            fontSize: infoSize,
            iconSize: iconSize,
          ),

          const SizedBox(height: 14),

          Divider(
            height: 1,
            thickness: 0.6,
            color: Colors.grey.shade200,
          ),

          const SizedBox(height: 14),

          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.hospitalDetails,
                  arguments: hospital,
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