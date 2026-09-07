import 'package:flutter/material.dart';

Widget buildStatItem({
  required String title,
  required int count,
  required IconData icon,
  required Color color,
  required Color bgColor,
  required double labelSize,
  required double countSize,
  required double iconSize,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: color,
        ),
      ),
      const SizedBox(height: 6),
      Text(
        "$count",
        style: TextStyle(
          fontSize: countSize,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF1E293B),
        ),
      ),
      const SizedBox(height: 2),
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: labelSize,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
        ),
      ),
    ],
  );
}