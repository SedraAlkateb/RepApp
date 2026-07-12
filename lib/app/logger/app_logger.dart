import 'package:logging/logging.dart';

class AppLogger {
  static void init() {
    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((record) {
      print(
        '[${record.level.name}] '
            '${record.time} '
            '${record.loggerName}: '
            '${record.message}',
      );

      if (record.error != null) {
        print(record.error);
      }

      if (record.stackTrace != null) {
        print(record.stackTrace);
      }
    });
  }

  static Logger get(String name) => Logger(name);
}