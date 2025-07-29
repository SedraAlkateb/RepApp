import 'package:domina_app/app/di.dart';
import 'package:domina_app/main.dart';
import 'package:domina_app/presentation/upload_delete/page/async_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AlarmAndNotifications {
  /// تهيئة الإشعارات
  static Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    final initSettings = InitializationSettings(android: androidInit);

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onNotificationTap(response); // ما عد صار بده context هون
      },
    );

    await AndroidAlarmManager.initialize();
  }

  /// دالة عند النقر على الإشعار
  static void _onNotificationTap(NotificationResponse response) {
    initAsyncInModule();
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => const AsyncPage(),
      ),
    );
  }

  /// جدولة إشعار دوري
  static Future<void> schedulePeriodicNotification({
    Duration duration = const Duration(minutes: 1),
  }) async {
    print("تم استدعاء showNotification من الـ Alarm");
    await AndroidAlarmManager.periodic(
      duration,
      1,
      showNotification,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  static Future<void> scheduleOneShot() async {
    await AndroidAlarmManager.oneShot(
      const Duration(seconds: 10),
      123,
      AlarmAndNotifications.showNotification,
      exact: true,
      wakeup: true,
    );
  }

  /// عرض الإشعار
  @pragma('vm:entry-point')
  static void showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Reminder Notifications',
      channelDescription: 'Channel for daily reminders',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      1,
      '🔔 تذكير - شركة دومِنا',
      'يرجى فتح التطبيق لمزامنة ورفع الزيارات والمعلومات .',
      notificationDetails,
      payload: 'go_to_sync',
    );
  }
}
