// ignore_for_file: must_be_immutable

import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  CustomButton({Key? key, required this.text, required this.onPressed,this.color,this.width}) : super(key: key);
  final String text;
  var onPressed;
  final Color ? color;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool tablet=MediaQuery.of(context).size.width>800;

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:size.width*0.2),
      child: Material(
        elevation: 5.0,
        color: color??ColorManager.secondaryColor1,
        borderRadius: BorderRadius.circular(15.0),
        child: MaterialButton(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          // splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
          onPressed: onPressed,
          minWidth: MediaQuery.of(context).size.width,
          child: Text(
            text,
            style:  TextStyle(color: ColorManager.secondaryColor2,  fontSize: tablet?17:14,),
          ),
        ),
      ),
    );}}