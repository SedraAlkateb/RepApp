abstract class AnalyticsService {


  Future<void> logEvent({
    required String name,
    Map<String,Object>? parameters,
  });



  Future<void> setUserId(
      String userId,
      );



  Future<void> setUserProperty({
    required String name,
    required String value,
  });



  Future<void> clearUser();
  Future<void> logUserLogin({required String userId, required String loginMethod});
  Future<void> logSurveySubmitted({
    required String surveyId,
    required String category,
    required int completionTimeSeconds,
  });
  Future<void> logScreenView(String screenName) ;

}

