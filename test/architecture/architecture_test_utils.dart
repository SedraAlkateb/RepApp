import 'dart:io';

/// أدوات مشتركة لاختبارات المعمارية تحت test/architecture:
/// تعداد ملفات lib/ (باستثناء الملفات المولَّدة) وتنظيف التعليقات
/// قبل تطبيق الـ regex، لتفادي نتائج خاطئة من كود معلّق أو موثّق.

List<File> libDartFiles({String root = 'lib'}) {
  return Directory(root)
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) =>
          f.path.endsWith('.dart') &&
          !f.path.endsWith('.g.dart') &&
          !f.path.endsWith('.freezed.dart'))
      .toList();
}

/// مسار الملف بفواصل '/' الموحّدة (مهم لمقارنة قوائم الاستثناء عبر الأنظمة).
String relativePath(File f) => f.path.replaceAll('\\', '/');

/// يزيل تعليقات /* */ وأسطر // قبل تطبيق أي regex على المحتوى.
String stripComments(String src) {
  return src
      .replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '')
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');
}
