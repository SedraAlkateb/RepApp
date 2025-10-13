import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BoxTextField extends StatelessWidget {
  const BoxTextField({super.key,this.minLines,this.maxLines,this.enabled,this.hintStyle,
    required this.inputFormatters, required this.keyboardType, required this.prefixIcon,
    this.suffixIcon, required this.validator, required this.controller, required this.obscureText,this.function});
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final FormFieldValidator<String>? validator;

  final bool obscureText;
  final int ? minLines;
  final int ? maxLines;
  final Function(String) ? function;
  final bool? enabled;
  final TextStyle? hintStyle;
 final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            onChanged:function ,
            inputFormatters: inputFormatters,
            maxLines: maxLines??1,
            minLines:minLines ,
            obscureText:obscureText ,
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            keyboardAppearance: Brightness.dark,
            // textDirection: TextDirection.rtl,
            readOnly: enabled??false,
            decoration: InputDecoration(
              filled: true,
                fillColor:ColorManager.grey,
                focusColor: ColorManager.secondaryColor,
                hoverColor: ColorManager.secondaryColor,
                suffixIcon:suffixIcon ,
                border: const OutlineInputBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(20),right:Radius.circular(20) )),
                focusedBorder:   OutlineInputBorder(borderRadius: const BorderRadius.horizontal(left: Radius.circular(20),right:Radius.circular(20)),borderSide: BorderSide(color: ColorManager.secondaryColor)),
                enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.horizontal(left: Radius.circular(20),right:Radius.circular(20)),borderSide: BorderSide(color: ColorManager.secondaryColor)) ,
                hintStyle:hintStyle??  TextStyle(fontSize: 14.sp)
            ),
          ),
        );
  }}