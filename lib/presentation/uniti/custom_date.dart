
import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/uniti/decoration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomDate extends StatelessWidget {
   CustomDate({Key? key,required this.dateInput,required this.width,required this.onChanged, this.validator,this.hint='YY-MM-DD'}) : super(key: key);
  final TextEditingController dateInput;
  final double width;
 final  onChanged;
   final FormFieldValidator<dynamic>? validator;
   final  String ? hint;
   @override
  Widget build(BuildContext context) {
    return    SizedBox(
      width: width,
      // height: 35,
      child: TextFormField(
        keyboardType: TextInputType.none,
        controller: dateInput,
        style:  TextStyle(
            color: ColorManager.secondaryColor,

            fontSize: 18.sp),
        cursorColor: ColorManager.secondaryColor,
        textAlign: TextAlign.start,
        validator:validator==null ? (value) {
          if (value!.isEmpty) {
            return "Required_Field";
          }
          return null;
        }: validator ,
        onTap: onChanged,
        onChanged: (value){
          print(dateInput.toString());
        },
        decoration: KTextField1Decoration.copyWith(
          filled: true,
          fillColor: ColorManager.grey,
          hintText:hint ,
          prefixIcon:  Icon(
            Icons.calendar_today,
            color: ColorManager.secondaryColor,
            size: 17.r,
          ),
          hintStyle:  TextStyle(
            fontSize: 15.sp,
            color: Color(0xFFD2D1D1),
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }


}
