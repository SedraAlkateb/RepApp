import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/font_manager.dart';
import 'package:domina_app/presentation/resources/style_manage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// presentation
ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.background,
    fontFamily: FontConstants.fontFamily1,
    tabBarTheme: TabBarThemeData(
      labelColor: ColorManager.white,
      indicatorColor: ColorManager.secondaryColor1,
      unselectedLabelColor: ColorManager.secondaryColor1,
    ),
    primaryColor: ColorManager.background,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: ColorManager.background,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorManager.primaryField,
    ),
    cardTheme: CardThemeData(
      shadowColor: ColorManager.shadowCard,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s18),
      ),
    ),
    appBarTheme: AppBarTheme(
      toolbarHeight: 50.h,
      backgroundColor: ColorManager.white,
      shadowColor: ColorManager.secondaryColor3,
      iconTheme: IconThemeData(
        color: ColorManager.secondaryColor1,
        size: 15.h,
      ),
      titleTextStyle: getBoldStyle(
        fontSize: 20.h,
        color: ColorManager.secondaryColor1,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.secondaryColor,
      splashColor: ColorManager.shadow,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddingW.p20,
          vertical: AppPaddingH.p5,
        ),
        textStyle: getMediumStyle(
          color: ColorManager.white,
          fontSize: FontSize.s20,
        ),
        shadowColor: ColorManager.shadow1,
        backgroundColor: ColorManager.secondaryColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
      ).copyWith(
        animationDuration: const Duration(milliseconds: 180),
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return 1;
          if (states.contains(WidgetState.hovered)) return 8;
          return 2;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.white.withValues(alpha: 0.22);
          }
          if (states.contains(WidgetState.hovered)) {
            return Colors.white.withValues(alpha: 0.12);
          }
          return null;
        }),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        animationDuration: const Duration(milliseconds: 180),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return ColorManager.secondaryColor1.withValues(alpha: 0.16);
          }
          if (states.contains(WidgetState.hovered)) {
            return ColorManager.secondaryColor1.withValues(alpha: 0.08);
          }
          return null;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        animationDuration: const Duration(milliseconds: 180),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return ColorManager.secondaryColor1.withValues(alpha: 0.16);
          }
          if (states.contains(WidgetState.hovered)) {
            return ColorManager.secondaryColor1.withValues(alpha: 0.08);
          }
          return null;
        }),
      ),
    ),
    textTheme: TextTheme(
      displaySmall: getSemiBoldStyle(
        color: ColorManager.secondaryColor,
        fontSize: FontSize.s16,
      ),
      displayLarge: getSemiBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s18,
      ),
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.secondaryColor2,
        fontSize: FontSize.s16,
      ),
      headlineMedium: getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s16,
      ),
      titleMedium: getSemiBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s20,
      ),
      bodySmall: getSemiBoldStyle(
        color: ColorManager.secondaryColor1,
        fontSize: FontSize.s16,
      ),
      bodyLarge: getRegularStyle(
        color: Colors.black,
        fontSize: FontSize.s18,
      ),
      titleLarge: getBoldStyle(
        color: ColorManager.secondaryColor1,
        fontSize: FontSize.s25,
      ),
      labelLarge: getBoldStyle(
        color: ColorManager.secondaryColor1,
        fontSize: AppSize.s18,
      ),
      labelMedium: getBoldStyle(
        color: ColorManager.secondaryColor1,
        fontSize: FontSize.s17,
      ),
      labelSmall: getSemiBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s14,
      ),
      titleSmall: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s20,
      ),
      bodyMedium: getRegularStyle(
        color: Colors.black,
        fontSize: 12.sp,
      ),
    ),

    // =========================================================
    // تعديلات الإبراز (Input Highlight) لجميع حقول النصوص
    // =========================================================
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppPaddingH.p12),
      hintStyle: getRegularStyle(
        color: ColorManager.hintGrey,
        fontSize: FontSize.s20,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.secondaryColor,
        fontSize: FontSize.s22,
      ),
      errorStyle: getRegularStyle(color: ColorManager.error),
      filled: true,

      // لون خلفية الحقل الافتراضية
      fillColor: ColorManager.medicalBorder.withOpacity(0.15),

      // الإطار في الحالة العادية
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.medicalBorder,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
      ),

      // الإطار عند التركيز (Focus Highlight)
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.medicalSecondary, // لون الإبراز الأساسي
          width: 2.0, // تعريض الإطار قليلاً للتمييز
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
      ),

      // الإطار عند وجود خطأ
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s0_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
      ),

      // الإطار عند التركيز على حقل فيه خطأ
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
    ),

    // تحديد لون مؤشر الكتابة وتظلل النص المكتوب
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorManager.medicalSecondary,
      selectionColor: ColorManager.medicalSecondary.withOpacity(0.3),
      selectionHandleColor: ColorManager.medicalSecondary,
    ),
  );
}
