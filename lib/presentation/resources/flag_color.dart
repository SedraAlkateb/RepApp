import 'package:flutter/material.dart';

/// لون حالة الخطة حسب رقم الـ flag.
Color getColor(int flag) {
  switch (flag) {
    case 0:
      // بانتظار موافقة المندوب: أزرق سماوي هادئ وعميق
      return const Color(0xFF0288D1);

    case 1:
      // بانتظار موافقة Supervisor: أحمر مرجاني أنيق (وليس فاقعاً) يعبر عن أهمية الإجراء
      return const Color(0xFFE53935);

    case 2:
      // مكتمل / تمت الموافقة: أخضر عشبي مريح للعين يعكس النجاح
      return const Color(0xFF43A047);

    case 3:
      // ملغي أو مرفوض: رمادي داكن يميل للفحمي يعبر عن حالة الإغلاق
      return const Color(0xFF37474F);

    case 4:
      // بانتظار موافقة المستودع: لون فيروزي (Teal) عميق واحترافي بدلاً من الـ Accent الفسفوري
      return const Color(0xFF00897B);

    case 5:
      // بانتظار TeamLeader: برتقالي خريفي دافئ يعبر عن الانتظار والتحذير الخفيف
      return const Color(0xFFFB8C00);

    case 6:
      // بانتظار موافقة Senior: بنفسجي ملكي هادئ يعكس الرتبة الأعلى
      return const Color(0xFF5E35B1);

    default:
      // الحالة الافتراضية: الكحلي الأساسي للتطبيق
      return const Color(0xFF0D47A1);
  }
}
