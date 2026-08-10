import 'package:flutter/material.dart';

Widget buildDetailRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
    ) {
  final bool isTablet =
      MediaQuery.sizeOf(context).shortestSide >= 600;

  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: isTablet ? 10 : 8,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: isTablet ? 24 : 20,
        ),

        SizedBox(
          width: isTablet ? 14 : 10,
        ),

        Text(
          '$title: ',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 17 : 15,
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: isTablet ? 17 : 15,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}