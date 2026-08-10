import 'package:domina_app/presentation/delete/widget/delete_logout/delete_logout_action_button.dart';
import 'package:domina_app/presentation/delete/widget/delete_logout/delete_logout_description.dart';
import 'package:domina_app/presentation/delete/widget/delete_logout/delete_logout_illustration.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class DeleteLogoutContent extends StatelessWidget {
  const DeleteLogoutContent({
    super.key,
    required this.deviceType,
    required this.horizontalPadding,
    required this.topSpacing,
    required this.sectionSpacing,
    required this.illustrationSize,
    required this.userIconSize,
    required this.monitorIconSize,
    required this.titleFontSize,
    required this.buttonHeight,
    required this.buttonFontSize,
  });

  final AppDeviceType deviceType;

  final double horizontalPadding;
  final double topSpacing;
  final double sectionSpacing;

  final double illustrationSize;
  final double userIconSize;
  final double monitorIconSize;

  final double titleFontSize;

  final double buttonHeight;
  final double buttonFontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الخط الجانبي الرمادي
        Positioned(
          right: 0,
          top: 60,
          bottom: 60,
          child: Container(
            width: 8,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
            ),
          ),
        ),

        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
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

        DeleteLogoutIllustration(
          size: illustrationSize,
          userIconSize: userIconSize,
          monitorIconSize: monitorIconSize,
        ),

        SizedBox(
          height: sectionSpacing,
        ),

        DeleteLogoutDescription(
          fontSize: titleFontSize,
        ),

        SizedBox(
          height: sectionSpacing,
        ),

        DeleteLogoutActionButton(
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
              child: DeleteLogoutIllustration(
                size: illustrationSize,
                userIconSize: userIconSize,
                monitorIconSize: monitorIconSize,
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
                DeleteLogoutDescription(
                  fontSize: titleFontSize,
                ),

                SizedBox(
                  height: sectionSpacing,
                ),

                DeleteLogoutActionButton(
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