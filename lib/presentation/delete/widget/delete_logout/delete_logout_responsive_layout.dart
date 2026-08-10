import 'package:domina_app/presentation/delete/widget/delete_logout/delete_logout_content.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class DeleteLogoutResponsiveLayout extends StatelessWidget {
  const DeleteLogoutResponsiveLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = AppResponsive.deviceType(context);

    double maxWidth;
    double horizontalPadding;
    double topSpacing;
    double sectionSpacing;

    double illustrationSize;
    double userIconSize;
    double monitorIconSize;

    double titleFontSize;

    double buttonHeight;
    double buttonFontSize;

    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
        maxWidth = 520;
        horizontalPadding = 32;

        topSpacing = 60;
        sectionSpacing = 40;

        illustrationSize = 260;
        userIconSize = 70;
        monitorIconSize = 100;

        titleFontSize = 22;

        buttonHeight = 60;
        buttonFontSize = 20;
        break;

      case AppDeviceType.tabletPortrait:
        maxWidth = 650;
        horizontalPadding = 40;

        topSpacing = 80;
        sectionSpacing = 45;

        illustrationSize = 300;
        userIconSize = 80;
        monitorIconSize = 115;

        titleFontSize = 25;

        buttonHeight = 64;
        buttonFontSize = 21;
        break;

      case AppDeviceType.tabletLandscape:
        maxWidth = 1050;
        horizontalPadding = 48;

        topSpacing = 40;
        sectionSpacing = 50;

        illustrationSize = 300;
        userIconSize = 80;
        monitorIconSize = 115;

        titleFontSize = 26;

        buttonHeight = 64;
        buttonFontSize = 21;
        break;
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: DeleteLogoutContent(
          deviceType: deviceType,
          horizontalPadding: horizontalPadding,
          topSpacing: topSpacing,
          sectionSpacing: sectionSpacing,
          illustrationSize: illustrationSize,
          userIconSize: userIconSize,
          monitorIconSize: monitorIconSize,
          titleFontSize: titleFontSize,
          buttonHeight: buttonHeight,
          buttonFontSize: buttonFontSize,
        ),
      ),
    );
  }
}