
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDivider() {
  return Divider(height: 1, thickness: 0.5, indent: 20.w, endIndent: 20.w, color: Colors.grey.shade200);
}
Widget buildDetailRow(IconData icon, String label, String? value) {
  return
    (value==null)?SizedBox():
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                style: TextStyle(fontSize: 14.sp, height: 1.4),
                children: [
                  TextSpan(
                    text: label,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF263238)),
                  ),
                  const TextSpan(text: " "),
                  TextSpan(
                    text: value,
                    style: TextStyle(color:Colors.blueGrey ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
}
Widget buildStatBox(String label, String value, Color valColor) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
          SizedBox(height: 4.h),
          Text(value, style: TextStyle(color: valColor, fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}
Widget buildDetailHtmlRow(IconData icon, String label, String? value) {
  return
    (value==null)?SizedBox():
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: RichText(
              textAlign: TextAlign.right, // للمحاذاة العربية
              text: TextSpan(
                style: TextStyle(fontSize: 14.sp, height: 1.4, fontFamily: 'Cairo'), // تأكد من الخط العربي
                children: [
                  // الجزء الخاص بالعنوان (Label)
                  TextSpan(
                    text: "$label: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF263238),
                      fontSize: 14.sp,
                    ),
                  ),

                  // الجزء الخاص بمحتوى الـ Html
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle, // لضمان استقامة النص مع الأيقونات
                    child: Html(
                      data: value,
                      shrinkWrap: true,
                      style: {
                        "body": Style(
                          fontSize: FontSize(14.sp), // يفضل توحيد القياس مع الـ Label
                          textAlign: TextAlign.right,
                          margin: Margins.zero, // إزالة الهوامش التلقائية للـ Html
                          padding: HtmlPaddings.zero,
                          color: Colors.black87,
                        ),
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
}
