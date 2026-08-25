
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_ui.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget header(BuildContext context,AppUi ui){
  return
    AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      leading: IconButton(
        tooltip: 'رجوع',
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          size: ui.isMobile ? 24 : 27,
          color: ColorManager.medicalPrimary,
        ),
      ),
      title: Text(
        'أرشيف الأطباء والمشافي',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ui.isMobile ? 18 : 21,
          fontWeight: FontWeight.w700,
          color: ColorManager.medicalPrimary,
        ),
      ),
    );
}