
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

Widget bottumSure(BuildContext context,
    String text,{required VoidCallback fun}){
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text(text),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text("إلغاء")),
                  const SizedBox(width: 8,),
                  ElevatedButton(
                      onPressed: fun

                      , child: const Text("تأكيد"))
                ],),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    ),
  );

}