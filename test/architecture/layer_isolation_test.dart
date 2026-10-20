import 'package:flutter_test/flutter_test.dart';

import 'architecture_test_utils.dart';

/// يمنع تسرّب طبقات Clean Architecture داخل بعضها:
/// - domain لا يستورد من data ولا من Flutter مباشرة.
/// - data لا يستورد من presentation.
/// - presentation لا يستورد من data مباشرة (يجب المرور عبر domain + DI).
///
/// قوائم الاستثناء أدناه هي دَين معماري موجود قبل هذا الاختبار (موثَّق في
/// ذاكرة المشروع repapp-remaining-cleanup). أي ملف جديد يخالف القاعدة يجب
/// أن يُصلَح لا أن يُضاف لقائمة الاستثناء.
void main() {
  final importRe = RegExp(r'''^\s*import\s+['"]([^'"]+)['"]''', multiLine: true);

  Map<String, List<String>> findViolations({
    required String layerDir,
    required List<String> forbiddenPrefixes,
    required Set<String> allowlist,
  }) {
    final violations = <String, List<String>>{};
    for (final f in libDartFiles()) {
      final path = relativePath(f);
      if (!path.startsWith('$layerDir/')) continue;
      if (allowlist.contains(path)) continue;

      final src = stripComments(f.readAsStringSync());
      final imports = importRe
          .allMatches(src)
          .map((m) => m.group(1)!)
          .where((imp) => forbiddenPrefixes.any(imp.startsWith))
          .toList();
      if (imports.isNotEmpty) {
        violations[path] = imports;
      }
    }
    return violations;
  }

  test('domain لا يستورد من data ', () {
    const allowlist = <String>{};
    final violations = findViolations(
      layerDir: 'lib/domain',
      forbiddenPrefixes: const ['package:domina_app/data/'],
      allowlist: allowlist,
    );
    expect(violations, isEmpty,
        reason: 'ملفات جديدة بـ domain تستورد من data: $violations');
  });

  test('domain لا يستورد من app (الجلسة عبر SessionContext)', () {
    final violations = findViolations(
      layerDir: 'lib/domain',
      forbiddenPrefixes: const ['package:domina_app/app/'],
      allowlist: const <String>{},
    );
    expect(violations, isEmpty,
        reason: 'domain يجب ألا يعتمد على طبقة app: $violations');
  });

  test('domain لا يستورد Flutter مباشرة', () {
    final violations = findViolations(
      layerDir: 'lib/domain',
      forbiddenPrefixes: const ['package:flutter/'],
      allowlist: const {},
    );
    expect(violations, isEmpty,
        reason: 'domain يجب أن يبقى مستقلاً عن Flutter: $violations');
  });

  test('data لا يستورد من presentation', () {
    final violations = findViolations(
      layerDir: 'lib/data',
      forbiddenPrefixes: const ['package:domina_app/presentation/'],
      allowlist: const {},
    );
    expect(violations, isEmpty,
        reason: 'data لا يجب أن يعرف شيئاً عن واجهة المستخدم: $violations');
  });

  test('presentation لا يستورد data مباشرة (باستثناء دَين معماري موثّق سابقاً)',
      () {
    const allowlist = {
      'lib/presentation/place_visit/widget/hospital_visit.dart',
      'lib/presentation/doctors/bloc/doctors_bloc.dart',
    };
    final violations = findViolations(
      layerDir: 'lib/presentation',
      forbiddenPrefixes: const ['package:domina_app/data/'],
      allowlist: allowlist,
    );
    expect(violations, isEmpty,
        reason: 'ملفات جديدة بـ presentation تستورد data مباشرة: $violations');
  });
}
