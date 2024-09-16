// ignore_for_file: must_be_immutable

import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class BoxTextField extends StatelessWidget {
  BoxTextField({Key? key,this.minLines,this.maxLines,this.enabled,this.hintStyle,required this.inputFormatters, required this.keyboardType, required this.prefixIcon,    this.suffixIcon, required this.validator, required this.controller, required this.obscureText}) : super(key: key);
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  FormFieldValidator<String>? validator;

  final bool obscureText;
  final int ? minLines;
  final int ? maxLines;

  final bool? enabled;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
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
              fillColor:ColorManager.secondaryColor3,
              focusColor: ColorManager.hintGrey,
              hoverColor: ColorManager.hintGrey,
              suffixIcon:suffixIcon ,
              border: const OutlineInputBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(20),right:Radius.circular(20) )),
              focusedBorder:   OutlineInputBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(20),right:Radius.circular(20)),borderSide: BorderSide(color: ColorManager.hintGrey)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(20),right:Radius.circular(20)),borderSide: BorderSide(color: ColorManager.hintGrey)) ,
              hintStyle:hintStyle?? const TextStyle(fontSize: 14)
          ),
        ),
      );
  }}