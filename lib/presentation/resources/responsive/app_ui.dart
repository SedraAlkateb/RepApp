import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class AppUi {
  AppUi._({
    required this.deviceType,
  });

  final AppDeviceType deviceType;

  factory AppUi.of(BuildContext context) {
    return AppUi._(
      deviceType: AppResponsive.deviceType(context),
    );
  }

  // =====================================================
  // Device
  // =====================================================

  bool get isMobile =>
      deviceType == AppDeviceType.mobilePortrait;

  bool get isTabletPortrait =>
      deviceType == AppDeviceType.tabletPortrait;

  bool get isTabletLandscape =>
      deviceType == AppDeviceType.tabletLandscape;

  // =====================================================
  // Page Width
  // =====================================================

  /// العرض الافتراضي لصفحات القوائم
  double get pageMaxWidth {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 600;

      case AppDeviceType.tabletPortrait:
        return 800;

      case AppDeviceType.tabletLandscape:
        return 900;
    }
  }

  /// للصفحات الأوسع مثل التفاصيل والتقارير
  double get widePageMaxWidth {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 600;

      case AppDeviceType.tabletPortrait:
        return 800;

      case AppDeviceType.tabletLandscape:
        return 1100;
    }
  }
  // =====================================================
  // Small Radius
  // =====================================================

  double get smallRadius {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 10;

      case AppDeviceType.tabletPortrait:
        return 12;

      case AppDeviceType.tabletLandscape:
        return 11;
    }
  }
  // =====================================================
  // Page Padding
  // =====================================================

  double get pagePadding {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 16;

      case AppDeviceType.tabletPortrait:
        return 28;

      case AppDeviceType.tabletLandscape:
        return 32;
    }
  }

  double get pageTopPadding {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 16;

      case AppDeviceType.tabletPortrait:
        return 22;

      case AppDeviceType.tabletLandscape:
        return 18;
    }
  }

  double get pageBottomPadding {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 24;

      case AppDeviceType.tabletPortrait:
        return 30;

      case AppDeviceType.tabletLandscape:
        return 28;
    }
  }

  // =====================================================
  // Header
  // =====================================================

  double get headerTopPadding {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 20;

      case AppDeviceType.tabletPortrait:
        return 26;

      case AppDeviceType.tabletLandscape:
        return 20;
    }
  }

  double get headerBottomPadding {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 14;

      case AppDeviceType.tabletPortrait:
        return 18;

      case AppDeviceType.tabletLandscape:
        return 16;
    }
  }

  // =====================================================
  // Search
  // =====================================================

  double get searchTopPadding {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 14;

      case AppDeviceType.tabletPortrait:
        return 18;

      case AppDeviceType.tabletLandscape:
        return 14;
    }
  }

  double get searchBottomPadding {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 10;

      case AppDeviceType.tabletPortrait:
        return 14;

      case AppDeviceType.tabletLandscape:
        return 10;
    }
  }

  // =====================================================
  // List
  // =====================================================

  double get listTopPadding {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 6;

      case AppDeviceType.tabletPortrait:
        return 8;

      case AppDeviceType.tabletLandscape:
        return 6;
    }
  }

  double get listBottomPadding {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 28;

      case AppDeviceType.tabletPortrait:
        return 34;

      case AppDeviceType.tabletLandscape:
        return 30;
    }
  }

  // =====================================================
  // Cards
  // =====================================================

  double get cardRadius {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 18;

      case AppDeviceType.tabletPortrait:
        return 20;

      case AppDeviceType.tabletLandscape:
        return 18;
    }
  }

  double get cardPadding {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 15;

      case AppDeviceType.tabletPortrait:
        return 20;

      case AppDeviceType.tabletLandscape:
        return 17;
    }
  }

  double get cardSpacing {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 12;

      case AppDeviceType.tabletPortrait:
        return 14;

      case AppDeviceType.tabletLandscape:
        return 12;
    }
  }

  // =====================================================
  // Spacing
  // =====================================================

  double get sectionSpacing {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 12;

      case AppDeviceType.tabletPortrait:
        return 15;

      case AppDeviceType.tabletLandscape:
        return 13;
    }
  }
  double get sectionSpacingMobileZero {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 0;

      case AppDeviceType.tabletPortrait:
        return 15;

      case AppDeviceType.tabletLandscape:
        return 13;
    }
  }

  double get smallSpacing => 6;

  double get mediumSpacing => 10;

  double get largeSpacing => 16;

  // =====================================================
  // Typography
  // =====================================================

  double get pageTitleSize {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 21;

      case AppDeviceType.tabletPortrait:
        return 25;

      case AppDeviceType.tabletLandscape:
        return 23;
    }
  }

  double get pageSubtitleSize {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 12.5;

      case AppDeviceType.tabletPortrait:
        return 14;

      case AppDeviceType.tabletLandscape:
        return 13;
    }
  }

  double get cardTitleSize {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 16;

      case AppDeviceType.tabletPortrait:
        return 19;

      case AppDeviceType.tabletLandscape:
        return 18;
    }
  }

  double get bodyTextSize {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 12;

      case AppDeviceType.tabletPortrait:
        return 14;

      case AppDeviceType.tabletLandscape:
        return 13;
    }
  }

  double get smallTextSize {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 10.5;

      case AppDeviceType.tabletPortrait:
        return 12;

      case AppDeviceType.tabletLandscape:
        return 11.5;
    }
  }

  // =====================================================
  // Icons
  // =====================================================

  double get iconBoxSize {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 44;

      case AppDeviceType.tabletPortrait:
        return 52;

      case AppDeviceType.tabletLandscape:
        return 48;
    }
  }

  double get iconSize {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 22;

      case AppDeviceType.tabletPortrait:
        return 26;

      case AppDeviceType.tabletLandscape:
        return 24;
    }
  }

  double get smallIconSize {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 15;

      case AppDeviceType.tabletPortrait:
        return 17;

      case AppDeviceType.tabletLandscape:
        return 16;
    }
  }

  // =====================================================
  // Grid
  // =====================================================

  double get gridSpacing {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 10;

      case AppDeviceType.tabletPortrait:
        return 14;

      case AppDeviceType.tabletLandscape:
        return 14;
    }
  }

  int get gridColumns {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        return 2;

      case AppDeviceType.tabletPortrait:
        return 3;

      case AppDeviceType.tabletLandscape:
        return 4;
    }
  }
}