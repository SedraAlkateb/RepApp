import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;

  final List<Color> cardGradientColors;
  final List<Color> linerGradientColors;
  final double borderWidth;
  final Color textColor;
  final bool startAnimation;
  final int index;
  final double screenWidth;

  const CustomCard({
    super.key,
    required this.text,
    required this.cardGradientColors,
    required this.linerGradientColors,
    required this.borderWidth,
    required this.textColor,
    required this.startAnimation,
    required this.index,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: ColorManager.secondaryColor1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
