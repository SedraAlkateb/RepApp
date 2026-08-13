import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/doctor/doctor_details_card.dart';
import 'package:domina_app/presentation/doctors/widget/doctor/doctor_stats.dart';
import 'package:domina_app/presentation/doctors/widget/header.dart';
import 'package:domina_app/presentation/doctors/widget/note.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class DoctorDetailsContent extends StatelessWidget {
  const DoctorDetailsContent({
    super.key,
    required this.doctor,
    required this.deviceType,
    required this.pageMaxWidth,
    required this.statsMaxWidth,
    required this.horizontalPadding,
    required this.sectionSpacing,
    required this.detailsPadding,
    required this.statsSpacing,
    required this.bottomSafeSpace,
  });

  final DoctorModel doctor;
  final AppDeviceType deviceType;

  final double pageMaxWidth;
  final double statsMaxWidth;
  final double horizontalPadding;
  final double sectionSpacing;
  final double detailsPadding;
  final double statsSpacing;
  final double bottomSafeSpace;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: bottomSafeSpace,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ==========================================
          // Header
          // ==========================================
          buildHeader(
            doctor.title,
          ),

          // ==========================================
          // Statistics
          //
          // buildStatCard نفسها فيها transform -25
          // لذلك لا نضيف Transform هنا
          // ==========================================
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: statsMaxWidth,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: DoctorStats(
                  doctor: doctor,
                  spacing: statsSpacing,
                ),
              ),
            ),
          ),

          // ==========================================
          // Main Content
          // ==========================================
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: pageMaxWidth,
              ),
              child: _buildMainContent(),
            ),
          ),

          SizedBox(
            height: sectionSpacing,
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
      case AppDeviceType.tabletPortrait:
        return _buildPortraitContent();

      case AppDeviceType.tabletLandscape:
        return _buildLandscapeContent();
    }
  }

  // ==========================================
  // Mobile + Tablet Portrait
  // ==========================================
  Widget _buildPortraitContent() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: DoctorDetailsCard(
            doctor: doctor,
            padding: detailsPadding,
          ),
        ),

        SizedBox(
          height: sectionSpacing,
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: buildNotesCard(
            doctor.note,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // Tablet Landscape
  // ==========================================
  Widget _buildLandscapeContent() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: DoctorDetailsCard(
              doctor: doctor,
              padding: detailsPadding,
            ),
          ),

          SizedBox(
            width: sectionSpacing,
          ),

          Expanded(
            flex: 5,
            child: buildNotesCard(
              doctor.note,
            ),
          ),
        ],
      ),
    );
  }
}


