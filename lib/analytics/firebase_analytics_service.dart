import 'package:domina_app/analytics/analytics_service.dart';
import 'package:domina_app/app/logger/app_logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final _log = AppLogger.get('Analytics');

class FirebaseAnalyticsService implements AnalyticsService {
  FirebaseAnalyticsService(this._analytics);

  final FirebaseAnalytics _analytics;

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      _log.fine('logEvent: $name $parameters');

      await _analytics.logEvent(
        name: name,
        parameters: parameters,
      );
    } catch (e, stackTrace) {
      _log.warning('logEvent failed: $name', e, stackTrace);
    }
  }

  @override
  Future<void> setUserId(String userId) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (e, stackTrace) {
      _log.warning('setUserId failed', e, stackTrace);
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
      _log.warning('setUserProperty failed', e, stackTrace);
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await _analytics.setUserId(id: null);
    } catch (e, stackTrace) {
      _log.warning('clearUser failed', e, stackTrace);
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
      _log.warning('logUserLogin failed', e, stackTrace);
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
      _log.warning('logSurveySubmitted failed', e, stackTrace);
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
      _log.warning('logScreenView failed', e, stackTrace);
    }
  }

}