// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/decoration.dart';

class CustomTime extends StatelessWidget {
   CustomTime({Key? key,required this.timeInput,required this.width,required this.onTap,this.hint='HH/MM'}) : super(key: key);
TextEditingController timeInput ;
final double width;
var onTap;
String? hint;
  @override
  Widget build(BuildContext context) {
    return       SizedBox(
      width: width,
      // height: 35,
      child: TextFormField(
         controller: timeInput,
        style:  TextStyle(
            color: ColorManager.secondaryColor, fontSize: 14),
        cursorColor:ColorManager.secondaryColor,
        keyboardType: TextInputType.none,
        textAlign: TextAlign.start,
        validator: (value) {
          if (value!.isEmpty) {
            return "Required_Field";
          }
          return null;
        },
        onTap: onTap,
        onChanged: (value) {},
        decoration: KTextField1Decoration.copyWith(
          filled: true,
          fillColor: ColorManager.filedColor,
          hintText: hint,
          prefixIcon:  Icon(
            Icons.access_time,
            color: ColorManager.secondaryColor,
            size: 17,
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFFD2D1D1),
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
