import 'package:flutter_test/flutter_test.dart';

import 'architecture_test_utils.dart';

/// يتحقق من اصطلاحات التسمية المتبعة فعلياً بالمشروع:
/// - Bloc/Event/State: اسم الميزة + Bloc يقابله نفس الاسم + Event و + State.
/// - UseCase: كل كلاس داخل lib/domain/usecase ينتهي اسمه بـ Usecase.
void main() {
  final blocRe =
      RegExp(r'class\s+(\w+)\s+extends\s+Bloc<\s*(\w+)\s*,\s*(\w+)\s*>');

  test('تسمية Bloc/Event/State متطابقة مع اسم الميزة', () {
    final mismatches = <String>[];
    for (final f in libDartFiles()) {
      final src = stripComments(f.readAsStringSync());
      for (final m in blocRe.allMatches(src)) {
        final blocName = m.group(1)!;
        final eventName = m.group(2)!;
        final stateName = m.group(3)!;
        final path = relativePath(f);

        if (!blocName.endsWith('Bloc')) {
          mismatches.add('$path: $blocName لا ينتهي بـ Bloc');
          continue;
        }
        final feature = blocName.substring(0, blocName.length - 'Bloc'.length);
        final expectedEvent = '${feature}Event';
        final expectedState = '${feature}State';
        if (eventName != expectedEvent) {
          mismatches.add(
              '$path: $blocName يُتوقَّع حدث $expectedEvent لكن الموجود $eventName');
        }
        if (stateName != expectedState) {
          mismatches.add(
              '$path: $blocName يُتوقَّع حالة $expectedState لكن الموجود $stateName');
        }
      }
    }
    expect(mismatches, isEmpty, reason: mismatches.join('\n'));
  });

  test('كلاسات UseCase تنتهي أسماؤها بـ Usecase (باستثناء دَين موثّق سابقاً)',
      () {
    // دَين تسمية موجود قبل هذا الاختبار: كلاسات UseCase قديمة بدون اللاحقة
    // الموحّدة. لا تُضف أسماء جديدة هنا — أصلحها بدل استثنائها.
    const allowlist = {
      'ChangeRepPlanStatus',
      'DocDoctorsUseCase',
      'GetDocHosBySpPlace',
      'UpdateRepPlanBrandAmount',
      'VisitReadStatus',
    };
    final classRe = RegExp(r'^class\s+(\w+)', multiLine: true);
    final violations = <String>[];
    for (final f in libDartFiles()) {
      final path = relativePath(f);
      if (!path.startsWith('lib/domain/usecase/')) continue;
      final src = stripComments(f.readAsStringSync());
      for (final m in classRe.allMatches(src)) {
        final name = m.group(1)!;
        if (allowlist.contains(name)) continue;
        if (!name.endsWith('Usecase')) {
          violations.add('$path: $name');
        }
      }
    }
    expect(violations, isEmpty,
        reason: 'كلاسات UseCase جديدة بدون لاحقة Usecase: $violations');
  });
}
