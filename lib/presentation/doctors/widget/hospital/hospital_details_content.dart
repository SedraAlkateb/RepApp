import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/doctors/widget/header.dart';
import 'package:domina_app/presentation/doctors/widget/hospital/hospital_details_card.dart';
import 'package:domina_app/presentation/doctors/widget/hospital/hospital_state.dart';
import 'package:domina_app/presentation/doctors/widget/note.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class HospitalDetailsContent extends StatelessWidget {
  const HospitalDetailsContent({
    super.key,
    required this.hospital,
    required this.deviceType,
    required this.pageMaxWidth,
    required this.horizontalPadding,
    required this.sectionSpacing,
    required this.detailsPadding,
    required this.statsMaxWidth,
    required this.bottomSafeSpace,
    required this.stateSpacing
  });

  final HospitalSpAllModel hospital;
  final AppDeviceType deviceType;

  final double pageMaxWidth;
  final double horizontalPadding;
  final double sectionSpacing;
  final double detailsPadding;
  final double statsMaxWidth;
  final double bottomSafeSpace;
  final double stateSpacing;

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
          // يبقى بعرض الشاشة كاملاً
          // ==========================================
          buildHeader(
            hospital.title,
          ),

          // ==========================================
          // Statistics
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
                child: HospitalStats(
                  hospital: hospital,
                  spacing: stateSpacing,
                ),
              ),
            ),
          ),

          SizedBox(
            height: sectionSpacing,
          ),

          // ==========================================
          // Main content
          // ==========================================
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: pageMaxWidth,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: _buildMainContent(),
              ),
            ),
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
  // Mobile + Tablet portrait
  // ==========================================
  Widget _buildPortraitContent() {
    return Column(
      children: [
        HospitalDetailsCard(
          hospital: hospital,
          padding: detailsPadding,
        ),

        SizedBox(
          height: sectionSpacing,
        ),

        buildNotesCard(
          hospital.note,
        ),
      ],
    );
  }

  // ==========================================
  // Tablet Landscape
  // ==========================================
  Widget _buildLandscapeContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: HospitalDetailsCard(
            hospital: hospital,
            padding: detailsPadding,
          ),
        ),

        SizedBox(
          width: sectionSpacing,
        ),

        Expanded(
          flex: 5,
          child: buildNotesCard(
            hospital.note,
          ),
        ),
      ],
    );
  }
}