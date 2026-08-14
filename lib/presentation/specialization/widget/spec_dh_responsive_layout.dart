import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/specialization/widget/spec_dh_content.dart';
import 'package:flutter/material.dart';

class SpecDHResponsiveLayout extends StatelessWidget {
  const SpecDHResponsiveLayout({
    super.key,
    required this.spId,
  });

  final int spId;

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;

    double horizontalPadding;
    double verticalPadding;

    double tabBarHeight;
    double tabRadius;
    double indicatorRadius;

    double titleFontSize;
    double tabFontSize;
    double tabIconSize;
    double tabIconSpacing;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;

        horizontalPadding = 16;
        verticalPadding = 12;

        tabBarHeight = 55;
        tabRadius = 15;
        indicatorRadius = 12;

        titleFontSize = 18;
        tabFontSize = 14;
        tabIconSize = 22;
        tabIconSpacing = 8;
        break;

      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;

        horizontalPadding = 24;
        verticalPadding = 16;

        tabBarHeight = 60;
        tabRadius = 17;
        indicatorRadius = 14;

        titleFontSize = 21;
        tabFontSize = 16;
        tabIconSize = 24;
        tabIconSpacing = 10;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 900;

        horizontalPadding = 32;
        verticalPadding = 18;

        tabBarHeight = 62;
        tabRadius = 18;
        indicatorRadius = 15;

        titleFontSize = 22;
        tabFontSize = 16;
        tabIconSize = 25;
        tabIconSpacing = 10;
        break;
    }

    return SpecDHContent(
      spId: spId,
      pageMaxWidth: pageMaxWidth,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      tabBarHeight: tabBarHeight,
      tabRadius: tabRadius,
      indicatorRadius: indicatorRadius,
      titleFontSize: titleFontSize,
      tabFontSize: tabFontSize,
      tabIconSize: tabIconSize,
      tabIconSpacing: tabIconSpacing,
    );
  }
}