import 'package:flutter/material.dart';

class DateHelper {

  // دالة لجلب اسم الشهر من التاريخ
  static String getMonthName(String dateString) {
    // تحويل النص إلى تاريخ
    DateTime date = DateTime.parse(dateString);

    // قائمة بأسماء الأشهر العربية
    List<String> months = [
      "يناير", "فبراير", "مارس", "أبريل", "مايو", "يونيو",
      "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر"
    ];

    // إرجاع الاسم (نطرح 1 لأن القائمة تبدأ من الصفر والشهر يبدأ من 1)
    return months[date.month - 1];
  }

  // دالة لجلب اسم الفصل (صيف، شتاء...) بناءً على الشهر
  static String getSeasonName(String dateString) {
    DateTime date = DateTime.parse(dateString);
    int month = date.month;

    if (month == 12 || month == 1 || month == 2) {
      return "شتاء";
    } else if (month >= 3 && month <= 5) {
      return "ربيع";
    } else if (month >= 6 && month <= 8) {
      return "صيف";
    } else {
      return "خريف";
    }
  }


}
Widget dataPlanWidget(String dateString){
  // مثال للاستخدام داخل الواجهة:
  String monthName = DateHelper.getMonthName(dateString); // سيعطيك "مارس"
  String season = DateHelper.getSeasonName(dateString);    // سيعطيك "ربيع"

// ثم يمكنك عرضها في التكست:
return  Text("خطة شهر $monthName - فصل $season");
}
