import 'package:flutter/services.dart'; // مكتبة الحافظة للنسخ
import 'package:url_launcher/url_launcher.dart'; // مكتبة فتح الروابط الخارجية
import 'package:flutter/material.dart';

/// تابع رسمي ومستقر لمشاركة التقرير الإداري عبر الواتساب وفتح قائمة المجموعات أو المحادثات مباشرة.
Future<void> shareReportToWhatsApp({
  required BuildContext context,
  required String doctorName,           // اسم الطبيب
  required String specialty,            // اختصاص الطبيب
  required String scientificOfficeNote, // ملاحظات المكتب العلمي
  required String visitDate,            // تاريخ الزيارة
  required String phoneNumber,          // رقم جوال الطبيب أو الشخص المعني
  required String repName,              // اسم المندوب
}) async {

  // 1. صياغة النص وتنسيقه بأسلوب تقرير إداري رسمي خالٍ من الرموز التعبيرية
  final String reportText =
      "تقرير زيارة طبيب - تطبيق دومينا\n"
      "===================================\n"
      "اسم الطبيب: $doctorName\n"
      "الاختصاص الطبي: $specialty\n"
      "تاريخ الزيارة: $visitDate\n"
      "اسم المندوب: $repName\n"
      "رقم الهاتف المرجعي: $phoneNumber\n"
      "===================================\n"
      "ملاحظات المكتب العلمي:\n"
      "$scientificOfficeNote\n";

  // 2. خطوة أمان: نسخ التقرير تلقائياً للحافظة (Clipboard) لضمان عدم ضياع البيانات
  await Clipboard.setData(ClipboardData(text: reportText));

  // 3. ترميز النص (Encoding) ليصبح متوافقاً مع روابط الإنترنت وتحويل الفراغات
  final String encodedText = Uri.encodeComponent(reportText);

  // 4. تنظيف رقم الهاتف برمجياً وإزالة الأصفار الدولية أو إشارة (+) لاستخدامه في الرابط البديل
  final String cleanPhone = phoneNumber.replaceAll('+', '').replaceFirst('00', '').trim();

  // 5. رابط المجموعات والمحادثات العام ليفتح قائمة الاختيار والبحث في واتساب
  final Uri whatsappUri = Uri.parse("whatsapp://send?text=$encodedText");

  try {
    // تشغيل الرابط بالوضع الخارجي المباشر لفتح تطبيق واتساب
    await launchUrl(
      whatsappUri,
      mode: LaunchMode.externalApplication,
    );

    // إشعار المستخدم بنجاح العملية وتوجيهه لاختيار الجروب
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("جاري فتح واتساب... يرجى اختيار جهة الإرسال المستهدفة.")),
      );
    }
  } catch (e) {
    // 6. الخطة البديلة (Fallback): إذا فشل الرابط المباشر، يتم توجيهه لرابط الويب الآمن باستخدام الرقم المنظف
    final Uri webWhatsappUri = Uri.parse("https://wa.me/$cleanPhone?text=$encodedText");

    if (await canLaunchUrl(webWhatsappUri)) {
      await launchUrl(webWhatsappUri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تعذر فتح التطبيق، تم نسخ التقرير النصي للحافظة بنجاح.")),
        );
      }
    }
  }
}