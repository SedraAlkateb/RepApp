import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                          child:  Text("Delete", style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
             Text(
              "سوف نحذف الداتا لاعادة تنزيلها",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
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


/*
 ║ [h3=":443"; ma=2592000, h3-29=":443"; ma=2592000, h3-Q050=":443"; ma=2592000, h3-Q046=":44
I/flutter (32649): ║ 3"; ma=2592000, h3-Q043=":443"; ma=2592000, quic=":443"; ma=2592000; v="43,46"]
I/flutter (32649): ╟ keep-alive: [timeout=5, max=100]
I/flutter (32649): ╟ date: [Wed, 10 Jun 2026 10:38:16 GMT]
I/flutter (32649): ╟ content-encoding: [gzip]
I/flutter (32649): ╟ vary: [Accept-Encoding]
I/flutter (32649): ╟ content-length: [300]
I/flutter (32649): ╟ content-type: [application/json]
I/flutter (32649): ╟ server: [LiteSpeed]
I/flutter (32649): ╚══════════════════════════════════════════════════════════════════════════════════════════╝
I/flutter (32649): ╔ Body
I/flutter (32649): ║
I/flutter (32649): ║    {
I/flutter (32649): ║         "message": "success",
I/flutter (32649): ║         "status": "200",
I/flutter (32649): ║         "data": {
I/flutter (32649): ║             "repId": "258",
I/flutter (32649): ║             "percentage": 5120000,
I/flutter (32649): ║             "name": "زينب العبد",
I/flutter (32649): ║             "samplesCount": "2",
I/flutter (32649): ║             "recipesCount": "600",
I/flutter (32649): ║             "token": "3c773fa816f126aff05aaa2e9f65c61c4c79fd61",
I/flutter (32649): ║             "repType": "7",
I/flutter (32649): ║             "cityId": "1",
I/flutter (32649): ║             "cityTitle": "دمشق وريفها",
I/flutter (32649): ║             "otherPlanId": "1341",
I/flutter (32649): ║             "otherPlanStatus": "0",
I/flutter (32649): ║             "otherStartDate": "2026-07-21",
I/flutter (32649): ║             "otherEndDate": "2026-09-20",
I/flutter (32649): ║             "activePlanId": "1289",
I/flutter (32649): ║             "startDate": "2026-05-21",
I/flutter (32649): ║             "endDate": "2026-06-20"
 */