import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/assets_manager.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';

PreferredSizeWidget appBarShow(String title,BuildContext context){

  return AppBar(
    backgroundColor: ColorManager.primary,
    title: Text(title,style: Theme.of(context).textTheme.titleLarge,),
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(
            size: AppSize.s30,
            Icons.arrow_back,
            color: ColorManager.secondaryColor, // هنا يمكنك تحديد لون الأيقونة
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        );
      },
    ),
    actions: [
      Image.asset(ImageAssets.login),
    ],
  );
}