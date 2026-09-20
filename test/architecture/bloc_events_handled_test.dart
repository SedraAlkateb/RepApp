import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// يمنع تكرار خطأ "add(X) was called without a registered event handler":
/// كل حدث يُرسَل بـ `.add(XEvent(...))` يجب أن يكون له `on<XEvent>` أو
/// أن يرث من حدث أب مسجّل له معالج.
void main() {
  test('كل حدث يُرسَل إلى Bloc له معالج مسجّل', () {
    final files = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) =>
            f.path.endsWith('.dart') &&
            !f.path.endsWith('.g.dart') &&
            !f.path.endsWith('.freezed.dart'))
        .toList();

    final superOf = <String, String>{};
    final handled = <String>{};
    final used = <String, Set<String>>{};

    final classRe = RegExp(r'^\s*(?:abstract\s+)?class\s+(\w+)\s+extends\s+(\w+)',
        multiLine: true);
    final onRe = RegExp(r'\bon<(\w+)>');
    final addRe = RegExp(r'\.add\(\s*(?:const\s+)?(\w+Event)\(');

    for (final f in files) {
      // نتجاهل الكود المعلّق (ميزات معطّلة): كتل /* */ ثم الأسطر //.
      final src = f
          .readAsStringSync()
          .replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '')
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      for (final m in classRe.allMatches(src)) {
        superOf[m.group(1)!] = m.group(2)!;
      }
      handled.addAll(onRe.allMatches(src).map((m) => m.group(1)!));
      for (final m in addRe.allMatches(src)) {
        used.putIfAbsent(m.group(1)!, () => {}).add(f.path);
      }
    }

    bool isHandled(String type) {
      final seen = <String>{};
      String? t = type;
      while (t != null && seen.add(t)) {
        if (handled.contains(t)) return true;
        t = superOf[t];
      }
      return false;
    }

    final missing = {
      for (final e in used.entries)
        if (!isHandled(e.key)) e.key: e.value.toList()..sort()
    };
    expect(missing, isEmpty,
        reason: 'أحداث تُرسَل بدون on<> مسجّل: $missing');
  });
}
