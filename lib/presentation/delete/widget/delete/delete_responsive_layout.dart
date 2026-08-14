import 'package:domina_app/presentation/delete/widget/delete/delete_content.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class DeleteResponsiveLayout extends StatelessWidget {
  const DeleteResponsiveLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double pageMaxWidth;
    double horizontalPadding;

    double topSpacing;
    double sectionSpacing;

    double illustrationSize;
    double userIconSize;
    double monitorIconSize;

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
        userIconSize = 70;
        monitorIconSize = 100;

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
        userIconSize = 80;
        monitorIconSize = 115;

        descriptionFontSize = 24;

        buttonHeight = 62;
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
        userIconSize = 80;
        monitorIconSize = 115;

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
        child: DeleteContent(
          deviceType: deviceType,
          horizontalPadding: horizontalPadding,
          topSpacing: topSpacing,
          sectionSpacing: sectionSpacing,
          illustrationSize: illustrationSize,
          userIconSize: userIconSize,
          monitorIconSize: monitorIconSize,
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