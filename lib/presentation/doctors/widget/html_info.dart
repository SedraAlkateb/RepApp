import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

Widget buildHtmlDetailRow(
      BuildContext context, IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 10),
          Text(
            '$title: ',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Expanded(
            child: Center(
              child: Html(
                data: value,
                style: {
        "body": Style(
          fontSize: FontSize(18), // هنا تقوم بتحديد حجم الخط
        ),
      },
                 
              ),
            ),
          ),
        ],
      ),
    );
  }
