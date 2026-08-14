import 'package:domina_app/presentation/brand/widget/brand_content.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class BrandResponsiveLayout extends StatelessWidget {
  const BrandResponsiveLayout({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;
    double horizontalPadding;
    double topSpacing;
    double sectionSpacing;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 600;
        horizontalPadding = 8;
        topSpacing = 12;
        sectionSpacing = 12;
        break;

      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 760;
        horizontalPadding = 24;
        topSpacing = 18;
        sectionSpacing = 18;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 1000;
        horizontalPadding = 32;
        topSpacing = 20;
        sectionSpacing = 20;
        break;
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: pageMaxWidth,
        ),
        child: BrandContent(
          searchController: searchController,
          horizontalPadding: horizontalPadding,
          topSpacing: topSpacing,
          sectionSpacing: sectionSpacing,
        ),
      ),
    );
  }
}