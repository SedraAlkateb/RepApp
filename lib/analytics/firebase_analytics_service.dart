import 'package:domina_app/analytics/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService
    implements AnalyticsService {


  final FirebaseAnalytics _analytics;


  FirebaseAnalyticsService(
      this._analytics,
      );



  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {

    try {
      /*
        final Map<String, Object> parameters = {
          "step_name": stepName,
          "loading_number": loadingNumber.toString(),
          "duration_ms": durationMs,
        };
       */
      print("🔥 Analytics Event Sending...");
      print("📌 Event Name: $name");
      print("📦 Parameters: $parameters");


      await _analytics.logEvent(
        name: name,
        parameters: parameters,
      );


      print("✅ Analytics Event Sent Successfully: $name");


    } catch (e, stackTrace) {

      print("❌ Analytics Event Failed: $name");
      print("Error: $e");
      print(stackTrace);

    }

  }



  @override
  Future<void> setUserId(
      String userId,
      ) async {

    await _analytics.setUserId(
      id:userId,
    );

  }



  @override
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {

    await _analytics. setUserProperty(
      name:name,
      value:value,
    );

  }



  @override
  Future<void> clearUser() async {

    await _analytics.setUserId(
      id:null,
    );

  }
  // 1. حدث تسجيل دخول مستخدم
  Future<void> logUserLogin({required String userId, required String loginMethod}) async {
    await _analytics.logLogin(
      loginMethod: loginMethod,
    );
    // ضبط المعرف المخصص للمستخدم في Firebase
    await _analytics.setUserId(id: userId);
  }

  // 2. حدث مخصص (Custom Event): عند إرسال استبيان أو مهمة
  Future<void> logSurveySubmitted({
    required String surveyId,
    required String category,
    required int completionTimeSeconds,
  }) async {
    await _analytics.logEvent(
      name: 'survey_submitted', // اسم الحدث باللغة الإنجليزية بدون مساحات
      parameters: {
        'survey_id': surveyId,
        'category': category,
        'completion_time_sec': completionTimeSeconds,
        'submitted_at': DateTime.now().toIso8601String(),
      },
    );
  }

  // 3. تتبع الشاشات التي يزورها المستخدم (Screen Tracking)
  Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenName,
    );
  }
}