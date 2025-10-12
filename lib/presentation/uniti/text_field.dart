import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
class TextFieldWidget extends StatelessWidget {
   const TextFieldWidget
       ({super.key, required this.hint,this.controller , this.textInputType,this.validator,this.onTap,this.onChange,this.obscureText,this.enable});
  final String hint;
   final   TextInputType ? textInputType;
   final TextEditingController? controller;
   final FormFieldValidator<String>? validator;
   final Function(String)? onTap;
   final Function()? onChange;
   final bool? obscureText;
   final bool? enable;
   @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  EdgeInsets.only(top: AppPaddingH.p12,right: AppPaddingW.p8,left: AppPaddingW.p8),
      child: TextFormField(

     onChanged:onTap ,
        onTap:onChange ,
        obscureText: obscureText??false,
        keyboardType: textInputType,
        controller: controller,
        validator: validator,
        enabled:enable ,
        decoration: InputDecoration(
          hintText: hint,
       //   labelText: hint
      ),
    )
    );
  }
}
