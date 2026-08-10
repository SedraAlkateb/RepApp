import 'package:flutter/material.dart';

class DatabaseWidget extends StatelessWidget {
  final double width;
  final double height;

  const DatabaseWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF1A3E62),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          2,
              (index) {
            return Container(
              width: width * 0.65,
              height: height * 0.24,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF1A3E62),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Icon(
                  Icons.circle,
                  size: width * 0.08,
                  color: const Color(0xFF1A3E62),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}