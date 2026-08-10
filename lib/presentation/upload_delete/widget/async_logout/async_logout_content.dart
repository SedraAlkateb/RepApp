import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/upload_delete/widget/async_logout/async_logout_action_button.dart';
import 'package:domina_app/presentation/upload_delete/widget/async_logout/async_logout_description.dart';
import 'package:domina_app/presentation/upload_delete/widget/async_logout/async_logout_illustration.dart';
import 'package:flutter/material.dart';

class AsyncLogoutContent extends StatelessWidget {
  const AsyncLogoutContent({
    super.key,
    required this.deviceType,
    required this.rotateController,
    required this.bounceController,
    required this.horizontalPadding,
    required this.topSpacing,
    required this.sectionSpacing,
    required this.illustrationSize,
    required this.userIconSize,
    required this.syncIconSize,
    required this.bounceDistance,
    required this.descriptionFontSize,
    required this.buttonHeight,
    required this.buttonFontSize,
    required this.sideBarWidth,
    required this.sideBarTop,
    required this.sideBarBottom,
  });

  final AppDeviceType deviceType;

  final AnimationController rotateController;
  final AnimationController bounceController;

  final double horizontalPadding;
  final double topSpacing;
  final double sectionSpacing;

  final double illustrationSize;
  final double userIconSize;
  final double syncIconSize;
  final double bounceDistance;

  final double descriptionFontSize;

  final double buttonHeight;
  final double buttonFontSize;

  final double sideBarWidth;
  final double sideBarTop;
  final double sideBarBottom;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          top: sideBarTop,
          bottom: sideBarBottom,
          child: Container(
            width: sideBarWidth,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
            ),
          ),
        ),

        Positioned.fill(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: _buildLayout(),
          ),
        ),
      ],
    );
  }

  Widget _buildLayout() {
    switch (deviceType) {
      case AppDeviceType.mobilePortrait:
      case AppDeviceType.tabletPortrait:
        return _buildPortrait();

      case AppDeviceType.tabletLandscape:
        return _buildLandscape();
    }
  }

  Widget _buildPortrait() {
    return Column(
      children: [
        SizedBox(
          height: topSpacing,
        ),

        AsyncLogoutIllustration(
          size: illustrationSize,
          userIconSize: userIconSize,
          syncIconSize: syncIconSize,
          bounceDistance: bounceDistance,
          rotateController: rotateController,
          bounceController: bounceController,
        ),

        SizedBox(
          height: sectionSpacing,
        ),

        AsyncLogoutDescription(
          fontSize: descriptionFontSize,
        ),

        SizedBox(
          height: sectionSpacing,
        ),

        AsyncLogoutActionButton(
          height: buttonHeight,
          fontSize: buttonFontSize,
        ),

        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  Widget _buildLandscape() {
    return Padding(
      padding: EdgeInsets.only(
        top: topSpacing,
        bottom: 40,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: AsyncLogoutIllustration(
                size: illustrationSize,
                userIconSize: userIconSize,
                syncIconSize: syncIconSize,
                bounceDistance: bounceDistance,
                rotateController: rotateController,
                bounceController: bounceController,
              ),
            ),
          ),

          SizedBox(
            width: sectionSpacing,
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AsyncLogoutDescription(
                  fontSize: descriptionFontSize,
                ),

                SizedBox(
                  height: sectionSpacing,
                ),

                AsyncLogoutActionButton(
                  height: buttonHeight,
                  fontSize: buttonFontSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}