// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:domina_app/presentation/ss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main()async {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Ss(s: "jujhhhhhhhhhhhhhhhhhhhhhhhhhhh",)
      ),
    );
    final Finder iconFinder = find.byIcon(Icons.add);
  //  expect(iconFinder, findsOneWidget);

    // // ✅ اضغط على الأيقونة
    // await tester.tap(iconFinder);
    // await tester.pump();
  });

}
