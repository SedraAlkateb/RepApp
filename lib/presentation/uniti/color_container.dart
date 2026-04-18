import 'package:flutter/material.dart';

Color chipBg(int i) {
  // نفس فكرة ألوان خفيفة مثل الصورة
  const list = [
    Color(0xFFE8E3F6), // بنفسجي فاتح
    Color(0xFFE0F4E9), // أخضر فاتح
    Color(0xFFFDE7EA), // وردي فاتح
    Color(0xFFE7F3FF), // أزرق فاتح
    Color(0xFFFFF3D9), // أصفر فاتح
  ];
  return list[i % list.length];
}