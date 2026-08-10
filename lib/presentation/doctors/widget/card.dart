import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildInfoRow(
    IconData icon,
    String label,
    String value,
    ) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp.clamp(12.0, 14.0),
              ),
            ),

            const SizedBox(
              height: 3,
            ),

            Text(
              value,
              style: TextStyle(
                color: const Color(0xFF0D47A1),
                fontWeight: FontWeight.bold,
                fontSize: 15.sp.clamp(15.0, 18.0),
              ),
            ),
          ],
        ),
      ),

      SizedBox(
        width: 15.w.clamp(15.0, 20.0),
      ),

      Container(
        padding: EdgeInsets.all(
          8.w.clamp(8.0, 11.0),
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(
            10.r.clamp(10.0, 14.0),
          ),
        ),
        child: Icon(
          icon,
          color: Colors.blue,
          size: 20.sp.clamp(20.0, 25.0),
        ),
      ),
    ],
  );
}