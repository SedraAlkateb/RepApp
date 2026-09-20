import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class AppLogger {
  /// يربط سجلّات `package:logging` بالـ console. يعمل في وضع التطوير فقط.
  static void init() {
    if (!kDebugMode) return;

    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((record) {
      debugPrint(
        '[${record.level.name}] '
        '${record.time} '
        '${record.loggerName}: '
        '${record.message}',
      );

      if (record.error != null) {
        debugPrint('${record.error}');
      }

      if (record.stackTrace != null) {
        debugPrint('${record.stackTrace}');
      }
    });
  }

  static Logger get(String name) => Logger(name);
}
