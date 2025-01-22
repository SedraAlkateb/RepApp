import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/font_manager.dart';
import 'package:domina_app/presentation/resources/style_manage.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';

//presentation
ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: 'Amiri',
    tabBarTheme: TabBarTheme(
        labelColor: ColorManager.white,
        indicatorColor: ColorManager.secondaryColor1,
        unselectedLabelColor: ColorManager.secondaryColor1
    ),
    primaryColor: ColorManager.secondaryColor4,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: ColorManager.primary,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorManager.primaryField,
    ),
    cardTheme: CardTheme(
      shadowColor: ColorManager.shadowCard,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s18),
      ),
    ),
    appBarTheme: AppBarTheme(

      iconTheme: IconThemeData(
        color: ColorManager.secondaryColor1,
      ),
      toolbarHeight: 60,
      backgroundColor: ColorManager.white,
      elevation: 9,
      shadowColor: ColorManager.secondaryColor3,
      titleTextStyle: getBoldStyle(fontSize: FontSize.s20, color: ColorManager.secondaryColor1),
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.secondaryColor,
      splashColor: ColorManager.shadow,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28, vertical: AppPadding.p5),
        textStyle: getMediumStyle(color: ColorManager.white, fontSize: FontSize.s20),
        shadowColor: ColorManager.shadow1,
        backgroundColor: ColorManager.secondaryColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
      ),
    ),
    textTheme: TextTheme(
      displaySmall: getSemiBoldStyle(color: ColorManager.secondaryColor, fontSize: FontSize.s16),
      displayLarge: getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s18),
      headlineLarge: getSemiBoldStyle(color: ColorManager.secondaryColor2, fontSize: FontSize.s16),
      headlineMedium: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
      titleMedium: getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s18),
      bodySmall: getRegularStyle(color: ColorManager.secondaryColor1, fontSize: FontSize.s14),
      bodyLarge: getRegularStyle(color: Colors.black, fontSize: FontSize.s18),
      titleLarge: getBoldStyle(color: ColorManager.secondaryColor1, fontSize: FontSize.s25),
      labelLarge: getBoldStyle(color: ColorManager.secondaryColor1, fontSize: AppSize.s20),
      labelMedium: getBoldStyle(color: ColorManager.secondaryColor1, fontSize: FontSize.s17),
      labelSmall: getBoldStyle(color: ColorManager.secondaryColor2, fontSize: FontSize.s18),
      titleSmall: getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s20),
      bodyMedium: getRegularStyle(color: Colors.black, fontSize: FontSize.s14),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p12),
      hintStyle: getRegularStyle(color: ColorManager.hintGrey, fontSize: FontSize.s20),
      labelStyle: getMediumStyle(color: ColorManager.secondaryColor, fontSize: FontSize.s22),

      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.secondaryColor3, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primaryField, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s0_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primaryField, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      fillColor: ColorManager.grey,
      filled: true
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black, // تعيين لون المؤشر هنا
    ),
  );
}
