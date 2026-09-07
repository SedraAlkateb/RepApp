extension StringNumberConverter on String {
  /// تحويل الأرقام العربية إلى إنجليزية مباشرة من أي String
  String toEnglishNumbers() {
    if (isEmpty) return this;

    const map = {
      '٠': '0', '١': '1', '٢': '2', '٣': '3', '٤': '4',
      '٥': '5', '٦': '6', '٧': '7', '٨': '8', '٩': '9',
    };

    final buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      final char = this[i];
      buffer.write(map[char] ?? char);
    }
    return buffer.toString();
  }
}