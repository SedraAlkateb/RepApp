import 'dart:io';

class DataStorageCapability {
  /// هل SQLite مدعوم على المنصة الحالية؟
  bool get isSupported {
    // sqflite مش بيدعم الويب مثلاً
    return Platform.isAndroid || Platform.isIOS || Platform.isMacOS;
  }
}
