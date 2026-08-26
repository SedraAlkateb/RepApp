import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/responsive/app_responsive.dart';
import 'package:domina_app/presentation/resources/style_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBarTheme buildResponsiveAppBarTheme(BuildContext context) {
  final deviceType = AppResponsive.deviceType(context);

  final double titleFontSize;
  final double iconSize;
  final double toolbarHeight;

  switch (deviceType) {
    case AppDeviceType.mobilePortrait:
      titleFontSize = 16.sp;
      iconSize = 22.r;
      toolbarHeight = 56.h;
      break;

    case AppDeviceType.tabletPortrait:
      titleFontSize = 18.sp;
      iconSize = 24.r;
      toolbarHeight = 64.h;
      break;

    case AppDeviceType.tabletLandscape:
      titleFontSize = 14.sp;
      iconSize = 20.r;
      toolbarHeight = 50.h;
      break;
  }

  return AppBarTheme(
    toolbarHeight: toolbarHeight,
    backgroundColor: ColorManager.white,
    elevation: 0,
    shadowColor: ColorManager.secondaryColor3,
    iconTheme: IconThemeData(
      color: ColorManager.secondaryColor1,
      size: iconSize,
    ),
    titleTextStyle: getBoldStyle(
      fontSize: titleFontSize,
      color: ColorManager.secondaryColor1,
    ),
  );
}