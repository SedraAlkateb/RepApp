import 'package:domina_app/analytics/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService implements AnalyticsService {
  FirebaseAnalyticsService(this._analytics);

  final FirebaseAnalytics _analytics;

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      print('🔥 Analytics Event Sending...');
      print('📌 Event Name: $name');
      print('📦 Parameters: $parameters');

      await _analytics.logEvent(
        name: name,
        parameters: parameters,
      );

      print('✅ Analytics Event Sent Successfully: $name');
    } catch (e, stackTrace) {
      print('❌ Analytics Event Failed: $name');
      print('Error: $e');
      print(stackTrace);
    }
  }

  @override
  Future<void> setUserId(String userId) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (e, stackTrace) {
      print('❌ Failed to set user ID: $e');
      print(stackTrace);
    }
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await _analytics.setUserProperty(
        name: name,
        value: value,
      );
    } catch (e, stackTrace) {
      print('❌ Failed to set user property: $e');
      print(stackTrace);
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await _analytics.setUserId(id: null);
    } catch (e, stackTrace) {
      print('❌ Failed to clear user: $e');
      print(stackTrace);
    }
  }

  Future<void> logUserLogin({
    required String userId,
    required String loginMethod,
  }) async {
    try {
      await _analytics.setUserId(id: userId);

      await _analytics.logLogin(
        loginMethod: loginMethod,
      );
    } catch (e, stackTrace) {
      print('❌ Login analytics failed: $e');
      print(stackTrace);
    }
  }

  Future<void> logSurveySubmitted({
    required String surveyId,
    required String category,
    required int completionTimeSeconds,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'survey_submitted',
        parameters: {
          'survey_id': surveyId,
          'category': category,
          'completion_time_sec': completionTimeSeconds,
        },
      );
    } catch (e, stackTrace) {
      print('❌ Survey analytics failed: $e');
      print(stackTrace);
    }
  }

  @override
  Future<void> logScreenView(String screenName) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: '${screenName}Page',
      );
    } catch (e, stackTrace) {
      print('❌ Screen analytics failed: $e');
      print(stackTrace);
    }
  }

}