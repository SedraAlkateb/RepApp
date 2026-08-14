import 'package:flutter/material.dart';

enum AppDeviceType {
  mobilePortrait,
  tabletPortrait,
  tabletLandscape,
}

class AppResponsive {
  AppResponsive._();

  static AppDeviceType deviceType(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final orientation = mediaQuery.orientation;

    final isTablet = size.shortestSide >= 600;

    if (!isTablet) {
      return AppDeviceType.mobilePortrait;
    }

    if (orientation == Orientation.landscape) {
      return AppDeviceType.tabletLandscape;
    }

    return AppDeviceType.tabletPortrait;
  }

  static bool isMobile(BuildContext context) {
    return deviceType(context) == AppDeviceType.mobilePortrait;
  }

  static bool isTabletPortrait(BuildContext context) {
    return deviceType(context) == AppDeviceType.tabletPortrait;
  }

  static bool isTabletLandscape(BuildContext context) {
    return deviceType(context) == AppDeviceType.tabletLandscape;
  }
}