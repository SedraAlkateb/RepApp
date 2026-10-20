import 'package:domina_app/presentation/resources/app_palette.dart';
import 'package:domina_app/presentation/resources/them_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('الثيم الداكن يوفّر الباليت الداكنة والفاتح يوفّر الفاتحة',
      (tester) async {
    late AppPalette light;
    late AppPalette dark;
    late Brightness darkBrightness;

    Widget host(ThemeData Function() theme, void Function(AppPalette) read) =>
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, __) => MaterialApp(
            theme: theme(),
            home: Builder(builder: (context) {
              read(context.palette);
              return const SizedBox();
            }),
          ),
        );

    await tester
        .pumpWidget(host(getApplicationTheme, (p) => light = p));
    await tester.pumpWidget(host(() {
      final t = getDarkApplicationTheme();
      darkBrightness = t.brightness;
      return t;
    }, (p) => dark = p));

    await tester.pumpAndSettle();

    expect(light.bg, AppPalette.light.bg);
    expect(dark.bg, AppPalette.dark.bg);
    expect(darkBrightness, Brightness.dark);
  });
}
