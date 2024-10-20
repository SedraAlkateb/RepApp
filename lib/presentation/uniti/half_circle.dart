import 'package:flutter/material.dart';

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height); // البدء من أسفل اليسار
    path.lineTo(0, 0); // إلى أعلى اليسار
    path.arcToPoint(
      Offset(size.width, 0), // قوس إلى اليمين
      radius: Radius.circular(size.width),
      clockwise: false, // عكس عقارب الساعة (نصف دائرة)
    );
    path.lineTo(size.width, size.height); // من أعلى اليمين إلى أسفل اليمين
    path.close(); // إغلاق المسار
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HalfCircleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('نصف دائرة ملونة')),
      body: Center(
        child: ClipPath(
          clipper: HalfCircleClipper(),
          child: Container(
            width: 200, // عرض نصف الدائرة
            height: 100, // ارتفاع نصف الدائرة
            color: Colors.blue, // لون نصف الدائرة
          ),
        ),
      ),
    );
  }
}


