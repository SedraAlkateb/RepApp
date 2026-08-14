import 'package:domina_app/presentation/delete/widget/delete/delete_action_button.dart';
import 'package:domina_app/presentation/delete/widget/delete/delete_description.dart';
import 'package:domina_app/presentation/delete/widget/delete/delete_illustration.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:flutter/material.dart';

class DeleteContent extends StatelessWidget {
  const DeleteContent({
    super.key,
    required this.deviceType,
    required this.horizontalPadding,
    required this.topSpacing,
    required this.sectionSpacing,
    required this.illustrationSize,
    required this.userIconSize,
    required this.monitorIconSize,
    required this.descriptionFontSize,
    required this.buttonHeight,
    required this.buttonFontSize,
    required this.sideBarWidth,
    required this.sideBarTop,
    required this.sideBarBottom,
  });

  final AppDeviceType deviceType;

  final double horizontalPadding;
  final double topSpacing;
  final double sectionSpacing;

  final double illustrationSize;
  final double userIconSize;
  final double monitorIconSize;

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
        // ==========================================
        // الشريط الجانبي الرمادي
        // ==========================================
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

        // ==========================================
        // المحتوى
        // ==========================================
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

  // =====================================================
  // Mobile + Tablet Portrait
  // =====================================================

  Widget _buildPortrait() {
    return Column(
      children: [
        SizedBox(
          height: topSpacing,
        ),

        DeleteIllustration(
          size: illustrationSize,
          userIconSize: userIconSize,
          monitorIconSize: monitorIconSize,
        ),

        SizedBox(
          height: sectionSpacing,
        ),

        DeleteDescription(
          fontSize: descriptionFontSize,
        ),

        SizedBox(
          height: sectionSpacing,
        ),

        DeleteActionButton(
          height: buttonHeight,
          fontSize: buttonFontSize,
        ),

        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  // =====================================================
  // Tablet Landscape
  // =====================================================

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
              child: DeleteIllustration(
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
                DeleteDescription(
                  fontSize: descriptionFontSize,
                ),

                SizedBox(
                  height: sectionSpacing,
                ),

                DeleteActionButton(
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