import 'package:domina_app/presentation/resources/app_palette.dart';
import 'package:domina_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:domina_app/presentation/resources/font_manager.dart';
import 'package:domina_app/presentation/resources/style_manage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// presentation
ThemeData getApplicationTheme() {
  return ThemeData(
    extensions: const <ThemeExtension<dynamic>>[AppPalette.light],
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


/// الثيم الداكن: يبني فوق الثيم الفاتح (نفس الخطوط والأزرار والأحجام) ويبدّل
/// الألوان فقط من [AppPalette.dark].
ThemeData getDarkApplicationTheme() {
  const p = AppPalette.dark;
  final base = getApplicationTheme();

  // ألوان النص الداكنة (كحلي/أسود) تنقلب لنص فاتح؛ الباقي (أبيض، برتقالي..) يبقى.
  Color? remap(Color? c) {
    if (c == null) return null;
    if (c == ColorManager.secondaryColor1 || c == ColorManager.secondaryColor) {
      return p.title;
    }
    if (c == Colors.black || c == ColorManager.black) return p.text;
    return c;
  }

  TextStyle? style(TextStyle? s) => s?.copyWith(color: remap(s.color));

  final t = base.textTheme;
  final textTheme = t.copyWith(
    displaySmall: style(t.displaySmall),
    displayLarge: style(t.displayLarge),
    headlineLarge: style(t.headlineLarge),
    headlineMedium: style(t.headlineMedium),
    titleMedium: style(t.titleMedium),
    bodySmall: style(t.bodySmall),
    bodyLarge: style(t.bodyLarge),
    titleLarge: style(t.titleLarge),
    labelLarge: style(t.labelLarge),
    labelMedium: style(t.labelMedium),
    labelSmall: style(t.labelSmall),
    titleSmall: style(t.titleSmall),
    bodyMedium: style(t.bodyMedium),
  );

  OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: width),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
      );

  return base.copyWith(
    extensions: const <ThemeExtension<dynamic>>[AppPalette.dark],
    scaffoldBackgroundColor: p.bg,
    canvasColor: p.bg,
    cardColor: p.surface,
    dividerColor: p.border,
    primaryColor: p.bg,
    colorScheme: ColorScheme.dark(
      primary: p.primary,
      surface: p.surface,
      onSurface: p.text,
      error: ColorManager.error,
    ),
    textTheme: textTheme,
    iconTheme: IconThemeData(color: p.text),
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: p.bg,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: p.text, size: 15.h),
      titleTextStyle: getBoldStyle(fontSize: 20.h, color: p.title),
    ),
    cardTheme: base.cardTheme.copyWith(color: p.surface),
    dialogTheme: DialogThemeData(
      backgroundColor: p.surface,
      surfaceTintColor: Colors.transparent,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: p.bg,
      surfaceTintColor: Colors.transparent,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: p.surface,
      surfaceTintColor: Colors.transparent,
    ),
    popupMenuTheme: PopupMenuThemeData(color: p.surface),
    tabBarTheme: base.tabBarTheme.copyWith(
      unselectedLabelColor: p.muted,
      labelColor: ColorManager.white,
    ),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      fillColor: p.surface,
      hintStyle: getRegularStyle(color: p.muted, fontSize: FontSize.s20),
      labelStyle: getMediumStyle(color: p.muted, fontSize: FontSize.s22),
      enabledBorder: border(p.border, AppSize.s1_5),
      focusedBorder: border(p.primary, 2),
    ),
  );
}
