import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/upload_delete/widget/async_logout/async_logout_content.dart';
import 'package:flutter/material.dart';

class AsyncLogoutResponsiveLayout extends StatelessWidget {
  const AsyncLogoutResponsiveLayout({
    super.key,
    required this.rotateController,
    required this.bounceController,
  });

  final AnimationController rotateController;
  final AnimationController bounceController;

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;
    double horizontalPadding;

    double topSpacing;
    double sectionSpacing;

    double illustrationSize;
    double userIconSize;
    double syncIconSize;
    double bounceDistance;

    double descriptionFontSize;

    double buttonHeight;
    double buttonFontSize;

    double sideBarWidth;
    double sideBarTop;
    double sideBarBottom;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        pageMaxWidth = 520;
        horizontalPadding = 32;

        topSpacing = 70;
        sectionSpacing = 40;

        illustrationSize = 260;
        userIconSize = 80;
        syncIconSize = 28;
        bounceDistance = 12;

        descriptionFontSize = 22;

        buttonHeight = 60;
        buttonFontSize = 20;

        sideBarWidth = 8;
        sideBarTop = 100;
        sideBarBottom = 100;
        break;

      case AppDeviceType.tabletPortrait:
        pageMaxWidth = 650;
        horizontalPadding = 40;

        topSpacing = 80;
        sectionSpacing = 45;

        illustrationSize = 300;
        userIconSize = 90;
        syncIconSize = 32;
        bounceDistance = 14;

        descriptionFontSize = 24;

        buttonHeight = 64;
        buttonFontSize = 21;

        sideBarWidth = 9;
        sideBarTop = 110;
        sideBarBottom = 110;
        break;

      case AppDeviceType.tabletLandscape:
        pageMaxWidth = 1050;
        horizontalPadding = 48;

        topSpacing = 40;
        sectionSpacing = 50;

        illustrationSize = 300;
        userIconSize = 90;
        syncIconSize = 32;
        bounceDistance = 14;

        descriptionFontSize = 25;

        buttonHeight = 64;
        buttonFontSize = 21;

        sideBarWidth = 9;
        sideBarTop = 70;
        sideBarBottom = 70;
        break;
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: pageMaxWidth,
        ),
        child: AsyncLogoutContent(
          deviceType: deviceType,
          rotateController: rotateController,
          bounceController: bounceController,
          horizontalPadding: horizontalPadding,
          topSpacing: topSpacing,
          sectionSpacing: sectionSpacing,
          illustrationSize: illustrationSize,
          userIconSize: userIconSize,
          syncIconSize: syncIconSize,
          bounceDistance: bounceDistance,
          descriptionFontSize: descriptionFontSize,
          buttonHeight: buttonHeight,
          buttonFontSize: buttonFontSize,
          sideBarWidth: sideBarWidth,
          sideBarTop: sideBarTop,
          sideBarBottom: sideBarBottom,
        ),
      ),
    );
  }
}