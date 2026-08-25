
// ============================================================================
// Tab Bar
// ============================================================================

import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

class DocHosTabBar extends StatelessWidget {
  const DocHosTabBar({
    required this.height,
    required this.controller,
  });

  final double height;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final deviceType =
    AppResponsive.deviceType(context);

    double indicatorRadius;
    double tabFontSize;

    switch (deviceType) {
    // =================================================
    // Mobile
    // =================================================
      case AppDeviceType.mobilePortrait:

        indicatorRadius = 11;

        tabFontSize = 13;

        break;

    // =================================================
    // Tablet Portrait
    // =================================================
      case AppDeviceType.tabletPortrait:
        indicatorRadius = 12;

        tabFontSize = 15;
        break;

    // =================================================
    // Tablet Landscape
    // =================================================
      case AppDeviceType.tabletLandscape:
        indicatorRadius = 11;

        tabFontSize = 14;

        break;
    }

    return Container(
      height: height,
      padding: const EdgeInsets.all(
        4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          16,
        ),
        border: Border.all(
          color: const Color(
            0xFFE2E8F0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.025,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: TabBar(
        controller: controller,
        labelPadding:
        EdgeInsets.zero,

        dividerColor:
        Colors.transparent,

        splashBorderRadius:
        BorderRadius
            .circular(
          indicatorRadius,
        ),

        labelColor:
        Colors.white,

        unselectedLabelColor:
        const Color(
          0xFF64748B,
        ),

        labelStyle:
        TextStyle(
          fontWeight:
          FontWeight
              .w700,

          fontSize:
          tabFontSize,

        ),

        unselectedLabelStyle:
        TextStyle(
          fontWeight:
          FontWeight
              .w600,

          fontSize:
          tabFontSize,

        ),

        indicatorSize:
        TabBarIndicatorSize
            .tab,

        indicator:
        BoxDecoration(
          color:
          ColorManager
              .medicalPrimary,

          borderRadius:
          BorderRadius
              .circular(
            indicatorRadius,
          ),
        ),
        tabs:  [
          Tab(
            child: _ArchiveTabItem(
              icon: Icons.groups_outlined,
              title: 'الأطباء',
            ),
          ),
          Tab(
            child: _ArchiveTabItem(
              icon: Icons.local_hospital_outlined,
              title: 'المشافي',
            ),
          ),
        ],
      ),
    );

  }

}
// ============================================================================
// Tab Item
// ============================================================================

class _ArchiveTabItem extends StatelessWidget {
  const _ArchiveTabItem({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final ui = AppUi.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: ui.isMobile ? 20 : 22,
        ),
        SizedBox(
          width: ui.smallSpacing,
        ),
        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

