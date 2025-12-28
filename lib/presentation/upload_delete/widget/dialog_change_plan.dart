// ignore_for_file: deprecated_member_use

import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/routes_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

Widget dialogChangePlan(BuildContext context,bool isOut){
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
        padding: EdgeInsets.all(8),
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
            children: [Text("تم وضع خطتك من قبل المشرف"),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.pushReplacementNamed(
                  context,
                  isOut?  Routes.deleteLogout:Routes.delete,
                );
              },
                  child: Text("موافق")),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    ),
  );

}