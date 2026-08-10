import 'package:domina_app/presentation/async/widget/sync_action_button.dart';
import 'package:domina_app/presentation/async/widget/sync_description.dart';
import 'package:domina_app/presentation/async/widget/sync_illustration.dart';
import 'package:domina_app/presentation/async/widget/sync_loading_indicator.dart';
import 'package:flutter/material.dart';

class SyncContent extends StatelessWidget {
  final double maxWidth;
  final double illustrationSize;
  final double horizontalPadding;
  final double topPadding;
  final double sectionSpacing;
  final double buttonHeight;
  final double textFontSize;

  const SyncContent({
    super.key,
    required this.maxWidth,
    required this.illustrationSize,
    required this.horizontalPadding,
    required this.topPadding,
    required this.sectionSpacing,
    required this.buttonHeight,
    required this.textFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _SideDecoration(),

        Positioned.fill(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              topPadding,
              horizontalPadding,
              24,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SyncLoadingIndicator(),

                    SizedBox(height: sectionSpacing * 0.5),

                    SyncIllustration(
                      size: illustrationSize,
                    ),

                    SizedBox(height: sectionSpacing),

                    SyncDescription(
                      fontSize: textFontSize,
                    ),

                    SizedBox(height: sectionSpacing),

                    SyncActionButton(
                      height: buttonHeight,
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SideDecoration extends StatelessWidget {
  const _SideDecoration();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 80,
      bottom: 80,
      child: Container(
        width: 7,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(10),
          ),
        ),
      ),
    );
  }
}