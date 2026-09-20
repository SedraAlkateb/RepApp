import 'package:domina_app/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ألوان العرض الخاصة بأنواع الـ domain.
///
/// اللون قرار عرض (presentation) لا يخص طبقة الـ domain، لذلك يعيش هنا.
/// المفتاح هو الاسم لأن `type` و`brandType` يستعملان نفس الأرقام بألوان مختلفة.
extension TypeStyle on Type {
  Color get color => switch (name) {
        "دفاتر" => Colors.cyan,
        "عينات" => Colors.lime,
        "لا شيء" => Colors.teal,
        "هدف" => Colors.blue,
        "مساعد" => Colors.orange,
        _ => Colors.grey,
      };
}

extension RepTypeStyle on RepType {
  Color get color => switch (i) {
        4 => const Color(0xFF3A5A75), // primary
        5 => const Color(0xFF3F7FBF), // splash2
        6 => const Color(0xFF4A7FA7), // splash1
        7 => const Color(0xFFD4AF37), // secondary (الذهبي)
        _ => const Color(0xFF94A3B8), // رمادي ناعم
      };
}

/// شارة صغيرة تعرض نوع البراند (هدف / مساعد / ...).
class TypeBadge extends StatelessWidget {
  const TypeBadge(this.brandType, {super.key});

  final Type brandType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: brandType.color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(brandType.name,
          style: TextStyle(
              color: brandType.color,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold)),
    );
  }
}
