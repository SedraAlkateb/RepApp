abstract class CrashlyticsService {


  Future<void> recordError({
    required Object error,
    StackTrace? stackTrace,
    String? reason,
    bool fatal,
  });



  Future<void> log(
      String message,
      );



  Future<void> setUserId(
      String userId,
      );


}