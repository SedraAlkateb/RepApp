import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/bottom.dart';
import 'package:domina_app/presentation/doctors/widget/doctor/doctor_details_content.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class DoctorDetailsResponsiveLayout extends StatelessWidget {
  const DoctorDetailsResponsiveLayout({
    super.key,
    required this.doctor,
  });

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;
    double statsMaxWidth;
    double horizontalPadding;
    double sectionSpacing;
    double detailsPadding;
    double bottomSafeSpace;
    double statsSpacing;
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;
        statsMaxWidth = 500;
        horizontalPadding = 16;
        sectionSpacing = 15;
        detailsPadding = 20;
        statsSpacing = 8;
        bottomSafeSpace = 150;
        break;

      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;
        statsMaxWidth = 580;
        horizontalPadding = 24;
        sectionSpacing = 20;
        detailsPadding = 22;
        statsSpacing = 14;
        bottomSafeSpace = 160;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 1100;
        statsMaxWidth = 650;
        horizontalPadding = 32;
        sectionSpacing = 24;
        detailsPadding = 24;
        statsSpacing = 18;
        bottomSafeSpace = 160;
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text(
          'معلومات الطبيب',
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
            child: DoctorDetailsContent(
              doctor: doctor,
              deviceType: deviceType,
              pageMaxWidth: pageMaxWidth,
              statsMaxWidth: statsMaxWidth,
              horizontalPadding: horizontalPadding,
              sectionSpacing: sectionSpacing,
              detailsPadding: detailsPadding,
              bottomSafeSpace: bottomSafeSpace,
              statsSpacing:statsSpacing,
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
                  child: buildBottomButtonsDoctor(
                    doctor.id,
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