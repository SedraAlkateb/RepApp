import 'package:domina_app/presentation/async/widget/sync_content.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class SyncResponsiveLayout extends StatelessWidget {
  const SyncResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = AppResponsive.deviceType(context);

        switch (deviceType) {
          case AppDeviceType.mobilePortrait:
            return const SyncContent(
              maxWidth: 520,
              illustrationSize: 220,
              horizontalPadding: 24,
              topPadding: 10,
              sectionSpacing: 28,
              buttonHeight: 56,
              textFontSize: 18,
            );

          case AppDeviceType.tabletPortrait:
            return const SyncContent(
              maxWidth: 620,
              illustrationSize: 280,
              horizontalPadding: 40,
              topPadding: 24,
              sectionSpacing: 38,
              buttonHeight: 60,
              textFontSize: 22,
            );

          case AppDeviceType.tabletLandscape:
            return const SyncContent(
              maxWidth: 680,
              illustrationSize: 240,
              horizontalPadding: 48,
              topPadding: 10,
              sectionSpacing: 24,
              buttonHeight: 58,
              textFontSize: 20,
            );
        }
      },
    );
  }
}