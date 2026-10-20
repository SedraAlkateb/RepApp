import 'package:domina_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

/// ألوان سيمانتيك تتبدل بين الوضع الفاتح والداكن.
///
/// القيم الفاتحة هي نفسها ثوابت [ColorManager] الحالية، فلا يتغير شكل الوضع
/// الفاتح. الاستخدام: `context.palette.surface` بدل `Colors.white`.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  /// خلفية الصفحة (Scaffold).
  final Color bg;

  /// خلفية البطاقات والحقول والحوارات.
  final Color surface;

  /// سطح ثانوي داخل البطاقة (أزرار صغيرة، شارات).
  final Color surfaceAlt;

  /// الحدود والفواصل.
  final Color border;

  /// النص الأساسي.
  final Color text;

  /// النص الثانوي والأيقونات الخافتة.
  final Color muted;

  /// لون العلامة (أيقونات/عناوين زرقاء) — يفتح في الداكن لتبقى مقروءة.
  final Color primary;

  /// عناوين الصفحات (كانت secondaryColor1 الكحلي).
  final Color title;

  /// خلفية الشارات الزرقاء (إجمالي الزيارات..).
  final Color infoBg;
  final Color infoBorder;
  final Color infoText;

  const AppPalette({
    required this.bg,
    required this.surface,
    required this.surfaceAlt,
    required this.border,
    required this.text,
    required this.muted,
    required this.primary,
    required this.title,
    required this.infoBg,
    required this.infoBorder,
    required this.infoText,
  });

  static const AppPalette light = AppPalette(
    bg: ColorManager.medicalBg,
    surface: Color(0xFFFFFFFF),
    surfaceAlt: Color(0xFFF8FAFC),
    border: ColorManager.medicalBorder,
    text: ColorManager.medicalText,
    muted: ColorManager.medicalMuted,
    primary: ColorManager.medicalPrimary,
    title: Color(0xff18355d),
    infoBg: Color(0xFFEFF6FF),
    infoBorder: Color(0xFFDBEAFE),
    infoText: Color(0xFF2563EB),
  );

  static const AppPalette dark = AppPalette(
    bg: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    surfaceAlt: Color(0xFF273449),
    border: Color(0xFF334155),
    text: Color(0xFFE2E8F0),
    muted: Color(0xFF94A3B8),
    primary: Color(0xFF60A5FA),
    title: Color(0xFFE2E8F0),
    infoBg: Color(0xFF1E3A5F),
    infoBorder: Color(0xFF2B4C7E),
    infoText: Color(0xFF93C5FD),
  );

  @override
  AppPalette copyWith({
    Color? bg,
    Color? surface,
    Color? surfaceAlt,
    Color? border,
    Color? text,
    Color? muted,
    Color? primary,
    Color? title,
    Color? infoBg,
    Color? infoBorder,
    Color? infoText,
  }) {
    return AppPalette(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      border: border ?? this.border,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      primary: primary ?? this.primary,
      title: title ?? this.title,
      infoBg: infoBg ?? this.infoBg,
      infoBorder: infoBorder ?? this.infoBorder,
      infoText: infoText ?? this.infoText,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      border: Color.lerp(border, other.border, t)!,
      text: Color.lerp(text, other.text, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      title: Color.lerp(title, other.title, t)!,
      infoBg: Color.lerp(infoBg, other.infoBg, t)!,
      infoBorder: Color.lerp(infoBorder, other.infoBorder, t)!,
      infoText: Color.lerp(infoText, other.infoText, t)!,
    );
  }
}

extension AppPaletteContext on BuildContext {
  /// يرجع الباليت الحالية؛ إن لم تُسجَّل بالثيم يرجع الفاتحة.
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}
