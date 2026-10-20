import 'package:flutter_test/flutter_test.dart';

import 'architecture_test_utils.dart';

/// يمنع استخدام print() المباشر بكود الإنتاج — يجب استخدام AppLogger بدلاً
/// منه (lib/app/logger) حتى لا تظهر سجلات تشخيصية بنسخة الإنتاج (release).
void main() {
  final printRe = RegExp(r'(?<![\w.])print\s*\(');

  test('لا يوجد استخدام مباشر لـ print()', () {
    final violations = <String>[];
    for (final f in libDartFiles()) {
      final path = relativePath(f);
      final src = stripComments(f.readAsStringSync());
      for (final m in printRe.allMatches(src)) {
        final line = src.substring(0, m.start).split('\n').length;
        violations.add('$path:$line');
      }
    }
    expect(violations, isEmpty,
        reason: 'استخدم AppLogger بدل print(): $violations');
  });
}
