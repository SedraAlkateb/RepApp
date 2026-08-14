import 'package:flutter/material.dart';

class AsyncLogoutDescription extends StatelessWidget {
  const AsyncLogoutDescription({
    super.key,
    required this.fontSize,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      'تأكد من اتصالك بالانترنت واضغط على زر رفع البيانات',
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