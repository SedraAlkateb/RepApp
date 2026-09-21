import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/presentation/brand_plan/pages/brand_plan_active_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

SpPlan sp(int id, int amount, String title) =>
    SpPlan(id, amount, title, Type.fromInt(1), id, 0, 0, 0, 0);

BrandSpPlanModel model(List<SpPlan> plans) => BrandSpPlanModel(
      BrandModel(1, 'Brand A', 'Tablet 500mg', 0, 0, '', '', ''),
      plans,
    );

Future<void> pumpCard(WidgetTester tester, BrandSpPlanModel m) {
  return tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: ActiveBrandPlanCard(model: m)),
        ),
      ),
    ),
  );
}

void main() {
  group('BrandSpPlanModel.totalAmount', () {
    test('يجمع amount لكل الاختصاصات', () {
      final m = model([sp(1, 10, 'Cardio'), sp(2, 25, 'Neuro'), sp(3, 5, 'x')]);

      expect(m.totalAmount, 40);
    });

    test('بدون اختصاصات = 0', () {
      expect(model([]).totalAmount, 0);
    });
  });

  group('ActiveBrandPlanCard', () {
    testWidgets('المجموع شارة تحت عنوان "توزيع الصنف حسب الاختصاص" وفوق القائمة',
        (tester) async {
      await pumpCard(
        tester,
        model([sp(1, 10, 'Cardio'), sp(2, 25, 'Neuro'), sp(3, 5, 'Derma')]),
      );

      // يظهر مرة واحدة فقط
      expect(find.text('المجموع: 40'), findsOneWidget);

      final section = tester.getTopLeft(find.text('توزيع الصنف حسب الاختصاص')).dy;
      final total = tester.getTopLeft(find.text('المجموع: 40')).dy;
      final firstSpec = tester.getTopLeft(find.text('Cardio')).dy;

      expect(total, greaterThan(section), reason: 'تحت عنوان القسم');
      expect(total, lessThan(firstSpec), reason: 'فوق قائمة الاختصاصات');
    });

    testWidgets('كميات الاختصاصات الفردية تبقى ظاهرة', (tester) async {
      await pumpCard(tester, model([sp(1, 10, 'Cardio'), sp(2, 25, 'Neuro')]));

      expect(find.text('10'), findsOneWidget);
      expect(find.text('25'), findsOneWidget);
      expect(find.text('المجموع: 35'), findsOneWidget);
    });
  });
}
