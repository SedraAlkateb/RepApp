import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'crashlytics_service.dart';


class FirebaseCrashlyticsService implements CrashlyticsService {


  final FirebaseCrashlytics _crashlytics;


  FirebaseCrashlyticsService(
      this._crashlytics,
      );



  @override
  Future<void> recordError({
    required Object error,
    StackTrace? stackTrace,
    String? reason,
    bool fatal = false,
  }) async {


    await _crashlytics.recordError(
      error,
      stackTrace,
      reason: reason,
      fatal: fatal,
    );

  }



  @override
  Future<void> log(
      String message,
      ) async {

    await _crashlytics.log(message);

  }



  @override
  Future<void> setUserId(
      String userId,
      ) async {

    await _crashlytics.setUserIdentifier(userId);

  }



  Future<void> clearUser() async {

    await _crashlytics.setUserIdentifier("");

  }


}