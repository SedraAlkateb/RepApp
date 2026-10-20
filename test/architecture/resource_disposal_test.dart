import 'package:flutter_test/flutter_test.dart';

import 'architecture_test_utils.dart';

/// يتحقق أنّ كل AnimationController / StreamController / StreamSubscription
/// يُغلَق فعلياً (dispose/close/cancel) بنفس الملف، منعاً لتسريب الموارد.
///
/// الفحص على مستوى الملف (وليس تحليل AST كامل): كافٍ لأن كل ملف بالمشروع
/// يحتوي عادة كلاس State واحد يملك هذه الحقول.
void main() {
  final fieldRe = RegExp(
    r'(?:late\s+)?(?:final\s+)?(AnimationController|StreamController(?:<[^>]*>)?|StreamSubscription(?:<[^>]*>)?)\s+(_?[a-zA-Z]\w*)\s*[;=]',
  );

  test('كل Controller/Stream يُغلَق بنفس الملف', () {
    final violations = <String>[];
    for (final f in libDartFiles()) {
      final src = stripComments(f.readAsStringSync());
      for (final m in fieldRe.allMatches(src)) {
        final type = m.group(1)!;
        final name = m.group(2)!;
        final String closer;
        if (type.startsWith('AnimationController')) {
          closer = 'dispose';
        } else if (type.startsWith('StreamSubscription')) {
          closer = 'cancel';
        } else {
          closer = 'close';
        }
        final closeRe = RegExp('\\b$name\\.$closer\\s*\\(');
        if (!closeRe.hasMatch(src)) {
          violations
              .add('${relativePath(f)}: $name ($type) بدون استدعاء .$closer()');
        }
      }
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}
