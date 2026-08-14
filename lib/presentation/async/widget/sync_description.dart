import 'package:flutter/material.dart';

class SyncDescription extends StatelessWidget {
  final double fontSize;

  const SyncDescription({
    super.key,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'تأكد من اتصالك بالإنترنت واضغط على زر تحميل البيانات لبدء العمل على التطبيق',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF0D47A1),
        height: 1.5,
      ),
    );
  }
}