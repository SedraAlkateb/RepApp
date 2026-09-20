import 'package:flutter/material.dart';

Widget buildHospitalSpecialization({
  required dynamic doctorNoteModel,
  required double fontSize,
  required double iconSize,
}) {
  return Row(
    mainAxisSize:
    MainAxisSize.min,
    children: [
      Container(
        width:
        iconSize + 12,
        height:
        iconSize + 12,
        alignment:
        Alignment.center,
        decoration:
        BoxDecoration(
          color:
          const Color(
            0xFFEFF6FF,
          ),
          borderRadius:
          BorderRadius.circular(
            8,
          ),
        ),
        child: Icon(
          Icons
              .local_offer_outlined,
          size:
          iconSize,
          color:
          const Color(
            0xFF3B82F6,
          ),
        ),
      ),

      const SizedBox(
        width: 7,
      ),

      Flexible(
        child: Text(
          doctorNoteModel
              .spTitle,
          maxLines: 1,
          overflow:
          TextOverflow.ellipsis,
          style: TextStyle(
            color:
            const Color(
              0xFF3B82F6,
            ),
            fontWeight:
            FontWeight.w600,
            fontSize:
            fontSize,
          ),
        ),
      ),
    ],
  );
}