import 'package:flutter/material.dart';

class DeleteLogoutDescription extends StatelessWidget {
  const DeleteLogoutDescription({
    super.key,
    required this.fontSize,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      'سوف نحذف الداتا لإعادة تنزيلها',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF0D47A1),
        height: 1.4,
      ),
    );
  }
}