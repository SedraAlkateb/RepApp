import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

///////// حذف
class DeleteDataPage extends StatelessWidget {
  const DeleteDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildIllustrationContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LucideIcons.user, size: 70, color: Color(0xFF1A3E62)),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(LucideIcons.monitor, size: 100, color: Color(0xFF1A3E62)),
                      Positioned(
                        top: 15, right: -5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          color: const Color(0xFF1A3E62),
                          child: const Text("Delete", style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "سوف نحذف الداتا لاعادة تنزيلها",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

// 1. ويدجت قاعدة البيانات (السيرفر)
class DatabaseWidget extends StatelessWidget {
  const DatabaseWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70, height: 90,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1A3E62), width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(2, (index) => Container(
          width: 45, height: 22,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF1A3E62), width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(child: Icon(Icons.circle, size: 5, color: Color(0xFF1A3E62))),
        )),
      ),
    );
  }
}

// 2. الحاوية الدائرية الخلفية للرسومات
Widget buildIllustrationContainer({required Widget child}) {
  return Container(
    width: 260, height: 260,
    decoration: const BoxDecoration(color: Color(0xFFF8F9FB), shape: BoxShape.circle),
    child: Center(child: child),
  );
}

// 3. الزر الأزرق الموحد
Widget _buildButton(String text, VoidCallback onPressed) {
  return SizedBox(
    width: double.infinity, height: 60,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0D47A1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
    ),
  );
}


