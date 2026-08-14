// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/ss.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AsyncLogoutIllustration extends StatelessWidget {
  const AsyncLogoutIllustration({
    super.key,
    required this.size,
    required this.userIconSize,
    required this.syncIconSize,
    required this.bounceDistance,
    required this.rotateController,
    required this.bounceController,
  });

  final double size;
  final double userIconSize;
  final double syncIconSize;
  final double bounceDistance;

  final AnimationController rotateController;
  final AnimationController bounceController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FB),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedBuilder(
                  animation: bounceController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        -bounceDistance * bounceController.value,
                      ),
                      child: child,
                    );
                  },
                  child: Icon(
                    LucideIcons.user,
                    size: userIconSize,
                    color: const Color(0xFF1A3E62),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                const DatabaseWidget(),
              ],
            ),

            Positioned(
              top: size * 0.25,
              left: size * 0.42,
              child: RotationTransition(
                turns: rotateController,
                child: Icon(
                  LucideIcons.refreshCw,
                  size: syncIconSize,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}