import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
class TextWidget extends StatelessWidget {
    const TextWidget({
     super.key,required this.hint,this.controller,
     this.icon
      ,this.enabled=false
   });
   final    String hint;
    final Widget ? icon;
    final  bool? enabled;
   final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: TextFormField(
        keyboardType: TextInputType.none,
        controller: controller,
        readOnly: true,
        obscureText: false,
        autofocus: true,
        enabled: enabled,

        onTap: () {
        },
        decoration: InputDecoration(
          suffixIcon:icon,
          focusColor:  ColorManager.primary,
          hoverColor: ColorManager.primary,
          fillColor:  ColorManager.primary,
          disabledBorder: const UnderlineInputBorder(),
          hintText: hint,
          prefixIcon: null,

        ),
      ),
    );
  }
}
