import 'package:flutter_test/flutter_test.dart';

import 'architecture_test_utils.dart';

/// يتحقق أنّ كل كلاس يرث Equatable (مباشرة أو عبر سلسلة وراثة) حقوله كلها
/// final أو const — لأن هذه الكلاسات (Event/State/UseCase/Models) يُفترض أن
/// تبقى غير قابلة للتعديل بعد الإنشاء.
///
/// القائمة المستثناة أدناه دَين معماري موجود قبل هذا الاختبار: 3 كلاسات
/// UseCase تحمل أصلاً `// ignore_for_file: must_be_immutable` (حقل
/// Repository غير final). لا تُضف أسماء جديدة هنا — أصلحها بدل استثنائها.
void main() {
  const allowlist = {
    'AllPlaceUsecase',
    'AllSpeUsecase',
    'GetPanRepsUsecase',
  };

  final classRe = RegExp(
    r'(?:abstract\s+|sealed\s+|final\s+|base\s+|interface\s+)*class\s+(\w+)(?:\s+extends\s+(\w+))?[^{;]*\{',
  );

  // سطر حقل بدون final/const: "Type name;" أو "Type name = value;".
  final mutableFieldRe = RegExp(
    r'^[A-Za-z_][\w<>,?\.\s]*\s[_a-zA-Z]\w*\s*(;|=[^;]*;)$',
  );

  test('كلاسات Equatable حقولها كلها final/const', () {
    final files = libDartFiles();
    final superOf = <String, String>{};

    for (final f in files) {
      final src = stripComments(f.readAsStringSync());
      for (final m in classRe.allMatches(src)) {
        final parent = m.group(2);
        if (parent != null) superOf[m.group(1)!] = parent;
      }
    }

    bool extendsEquatable(String name) {
      var t = superOf[name];
      final seen = <String>{name};
      while (t != null && seen.add(t)) {
        if (t == 'Equatable') return true;
        t = superOf[t];
      }
      return false;
    }

    final violations = <String>[];
    for (final f in files) {
      final src = stripComments(f.readAsStringSync());
      for (final m in classRe.allMatches(src)) {
        final name = m.group(1)!;
        if (!extendsEquatable(name)) continue;
        if (allowlist.contains(name)) continue;

        // عزل جسم الكلاس عبر عدّ الأقواس.
        final bodyStart = m.end - 1;
        var depth = 0;
        var end = bodyStart;
        for (var i = bodyStart; i < src.length; i++) {
          if (src[i] == '{') depth++;
          if (src[i] == '}') {
            depth--;
            if (depth == 0) {
              end = i;
              break;
            }
          }
        }
        final body = src.substring(bodyStart + 1, end);

        for (final rawLine in body.split('\n')) {
          final line = rawLine.trim();
          if (line.isEmpty) continue;
          if (line.startsWith('@') || line.startsWith('static ')) continue;
          if (line.startsWith('get ') || line.startsWith('set ')) continue;
          if (line.startsWith('final ') || line.startsWith('const ')) continue;
          if (line.contains('=>') || line.contains('(')) continue;
          if (mutableFieldRe.hasMatch(line)) {
            violations.add('${relativePath(f)}: $name -> $line');
          }
        }
      }
    }

    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}
