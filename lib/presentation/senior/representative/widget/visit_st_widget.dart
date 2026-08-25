import 'package:flutter/material.dart';

Widget buildRateBadge(
    String rate, {
      required double horizontalPadding,
      required double verticalPadding,
      required double radius,
      required double fontSize,
    }) {
  return Container(
    padding:
    EdgeInsets.symmetric(
      horizontal:
      horizontalPadding,

      vertical:
      verticalPadding,
    ),

    decoration:
    BoxDecoration(
      color: const Color(
        0xFFFFF7ED,
      ),

      borderRadius:
      BorderRadius.circular(
        radius,
      ),

      border: Border.all(
        color: const Color(
          0xFFFED7AA,
        ),
      ),
    ),

    child: Text(
      rate,

      maxLines: 1,

      style: TextStyle(
        fontSize:
        fontSize,

        color: const Color(
          0xFFEA580C,
        ),

        fontWeight:
        FontWeight.w700,
      ),
    ),
  );
}
Widget buildProgressBar(
    int done,
    int total,
    Color color,
    {
      required double height,
    }) {
  final double percent =
  total == 0
      ? 0
      : (done / total)
      .clamp(
    0.0,
    1.0,
  );

  return Column(
    crossAxisAlignment:
    CrossAxisAlignment.start,

    children: [
      Row(
        children: [
          Text(
            "نسبة الإنجاز",

            style: TextStyle(
              fontSize: 11,
              color:
              Colors.grey.shade600,
              fontWeight:
              FontWeight.w500,
            ),
          ),

          const Spacer(),

          Container(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 3,
            ),

            decoration: BoxDecoration(
              color: const Color(
                0xFFF0FDF4,
              ),

              borderRadius:
              BorderRadius.circular(
                7,
              ),
            ),

            child: Text(
              "${(percent * 100).round()}%",

              style:
              TextStyle(
                fontSize: 11,
                color: color,
                fontWeight:
                FontWeight.w700,
              ),
            ),
          ),
        ],
      ),

      const SizedBox(
        height: 7,
      ),

      ClipRRect(
        borderRadius:
        BorderRadius.circular(
          10,
        ),

        child:
        LinearProgressIndicator(
          value: percent,

          minHeight: height,

          backgroundColor:
          const Color(
            0xFFE8F5E9,
          ),

          valueColor:
          AlwaysStoppedAnimation<
              Color>(
            color,
          ),
        ),
      ),
    ],
  );
}