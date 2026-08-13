import 'package:domina_app/presentation/plase_visit/widget/build_card_buttom.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget hospitalWidget({
  required String spTitle,
  required String title,
  required String placeTitle,
  String? address,
  String? rate,
  required int id,
  required BuildContext context,
  required VoidCallback function,
  required String text,
}) {
  return Container(
    margin: EdgeInsets.only(
      bottom: 16.h.clamp(14.0, 20.0),
      right: 8.w.clamp(8.0, 14.0),
      left: 8.w.clamp(8.0, 14.0),
    ),
    padding: EdgeInsets.all(
      16.w.clamp(14.0, 22.0),
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
        15.r.clamp(14.0, 20.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 15,
          spreadRadius: 0,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w.clamp(10.0, 16.0),
                vertical: 4.h.clamp(4.0, 7.0),
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(
                  8.r.clamp(8.0, 12.0),
                ),
              ),
              child: Text(
                spTitle,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12.sp.clamp(11.0, 15.0),
                ),
              ),
            ),

            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 18.sp.clamp(17.0, 22.0),
                  fontWeight: FontWeight.bold,
                  color: ColorManager.medicalPrimary,
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: 10.h.clamp(8.0, 14.0),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 22.sp.clamp(20.0, 26.0),
              color: Colors.grey,
            ),
            SizedBox(
              width: 8.w.clamp(8.0, 12.0),
            ),
            Expanded(
              child: Text(
                placeTitle,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.sp.clamp(14.0, 18.0),
                ),
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 22.sp.clamp(20.0, 26.0),
              color: Colors.grey,
            ),
            SizedBox(
              width: 8.w.clamp(8.0, 12.0),
            ),
            Expanded(
              child: Text(
                address ?? "",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.sp.clamp(14.0, 18.0),
                ),
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.star_rate_outlined,
              size: 22.sp.clamp(20.0, 26.0),
              color: ColorManager.medicalSecondary,
            ),
            SizedBox(
              width: 8.w.clamp(8.0, 12.0),
            ),
            Expanded(
              child: Text(
                rate ?? "",
                style: TextStyle(
                  color: ColorManager.medicalSecondary,
                  fontSize: 15.sp.clamp(14.0, 18.0),
                ),
              ),
            ),
          ],
        ),

        SizedBox(
          height: 16.h.clamp(14.0, 20.0),
        ),

        const Divider(
          color: Colors.grey,
          thickness: 0.1,
        ),

        SizedBox(
          height: 8.h.clamp(6.0, 12.0),
        ),

        Row(
          children: [
            const Spacer(),
            InkWell(
              onTap: function,
              child: buildCardButton(context,
                text,
                ColorManager.medicalPrimary,
                Colors.white,
                Icons.directions_run,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}