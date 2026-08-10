// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DeleteIllustration extends StatelessWidget {
  const DeleteIllustration({
    super.key,
    required this.size,
    required this.userIconSize,
    required this.monitorIconSize,
  });

  final double size;
  final double userIconSize;
  final double monitorIconSize;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.user,
              size: userIconSize,
              color: const Color(0xFF1A3E62),
            ),

            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  LucideIcons.monitor,
                  size: monitorIconSize,
                  color: const Color(0xFF1A3E62),
                ),

                Positioned(
                  top: 15,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    color: const Color(0xFF1A3E62),
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}