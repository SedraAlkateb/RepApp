import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildNotesCard(String? note) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("ملاحظات إضافية",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0D47A1))),
            SizedBox(width: 10.w),
            Icon(Icons.note_alt_outlined, color: Colors.blue),
          ],
        ),
        SizedBox(height: 15.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(15.r)),
          child:
          Html(
            shrinkWrap: true,

            data: note??"لا يوجد ملاحظة",
            style: {
              "body": Style(
                  color: Colors.blueGrey,
                  textAlign: TextAlign.right
              ),
            },

          ),

        ),
      ],
    ),
  );
}