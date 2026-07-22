import 'package:domina_app/crashlytics/crashlytics_service.dart';

class ErrorReporter {

  final CrashlyticsService crashlytics;


  ErrorReporter(this.crashlytics);



  Future<void> report(
      Object error,
      StackTrace stackTrace,
      {
        String? reason,
      }
      ) async {

    await crashlytics.recordError(
      error: error,
      stackTrace: stackTrace,
      reason: reason,
    );

  }

}