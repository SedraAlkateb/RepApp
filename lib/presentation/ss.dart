import 'package:flutter/material.dart';


// 1. ويدجت قاعدة البيانات (السيرفر)
class DatabaseWidget extends StatelessWidget {
  const DatabaseWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 90,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1A3E62), width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            2,
            (index) => Container(
                  width: 45,
                  height: 22,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFF1A3E62), width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                      child: Icon(Icons.circle,
                          size: 5, color: Color(0xFF1A3E62))),
                )),
      ),
    );
  }
}

// 2. الحاوية الدائرية الخلفية للرسومات
Widget buildIllustrationContainer({required Widget child}) {
  return Container(
    width: 260,
    height: 260,
    decoration:
        const BoxDecoration(color: Color(0xFFF8F9FB), shape: BoxShape.circle),
    child: Center(child: child),
  );
}

