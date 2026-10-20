import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// منفذ للتشخيص (Crashlytics) يستخدمه الـ SyncBloc، ليمكن استبداله في الاختبارات.
abstract class SyncDiagnostics {
  Future<void> setUserIdentifier(String identifier);
  Future<void> setCustomKey(String key, Object value);
  Future<void> recordError(Object error, StackTrace? stackTrace,
      {String? reason, bool fatal = false});
  void log(String message);
}

/// التنفيذ الفعلي: يمرّر مباشرة إلى [FirebaseCrashlytics.instance].
class FirebaseSyncDiagnostics implements SyncDiagnostics {
  const FirebaseSyncDiagnostics();

  @override
  Future<void> setUserIdentifier(String identifier) =>
      FirebaseCrashlytics.instance.setUserIdentifier(identifier);

  @override
  Future<void> setCustomKey(String key, Object value) =>
      FirebaseCrashlytics.instance.setCustomKey(key, value);

  @override
  Future<void> recordError(Object error, StackTrace? stackTrace,
          {String? reason, bool fatal = false}) =>
      FirebaseCrashlytics.instance
          .recordError(error, stackTrace, reason: reason, fatal: fatal);

  @override
  void log(String message) => FirebaseCrashlytics.instance.log(message);
}
