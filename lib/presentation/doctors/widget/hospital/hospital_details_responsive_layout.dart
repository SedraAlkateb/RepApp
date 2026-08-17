import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/bottom.dart';
import 'package:domina_app/presentation/doctors/widget/hospital/hospital_details_content.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class HospitalDetailsResponsiveLayout extends StatelessWidget {
  const HospitalDetailsResponsiveLayout({
    super.key,
    required this.hospital,
  });

  final HospitalSpAllModel hospital;

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;
    double horizontalPadding;
    double sectionSpacing;
    double detailsPadding;
    double statsMaxWidth;
    double statsSpacing;
    double bottomSafeSpace;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;
        horizontalPadding = 16;
        sectionSpacing = 15;
        detailsPadding = 20;
        statsMaxWidth = 500;
        statsSpacing = 8;
        bottomSafeSpace = 150;
        break;

      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;
        horizontalPadding = 24;
        sectionSpacing = 20;
        detailsPadding = 22;
        statsMaxWidth = 560;
        statsSpacing = 14;
        bottomSafeSpace = 160;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 1100;
        horizontalPadding = 32;
        sectionSpacing = 24;
        detailsPadding = 24;
        statsMaxWidth = 620;
        statsSpacing = 18;
        bottomSafeSpace = 160;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text(
          'معلومات المشفى',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: HospitalDetailsContent(
              hospital: hospital,
              deviceType: deviceType,
              pageMaxWidth: pageMaxWidth,
              horizontalPadding: horizontalPadding,
              sectionSpacing: sectionSpacing,
              detailsPadding: detailsPadding,
              statsMaxWidth: statsMaxWidth,
              stateSpacing: statsSpacing,
              bottomSafeSpace: bottomSafeSpace,
            ),
          ),

          // ==========================================
          // Bottom Buttons
          // ==========================================
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: pageMaxWidth,
                  ),
                  child: buildBottomButtons(
                    hospital.id??hospital.hospitalId,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}