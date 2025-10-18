import 'dart:io';
import 'package:domina_app/app/di.dart';
import 'package:domina_app/main.dart';
import 'package:domina_app/presentation/upload_delete/page/async_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point') // 👈 مهم جدًا للوصول من native code
class AlarmAndNotifications {
  /// تهيئة الإشعارات
  static Future<void> initialize() async {
    // طلب الإذن أولاً على iOS
    if (Platform.isIOS) {
      final iosPlugin = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      await iosPlugin?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      print("✅ صلاحيات الإشعارات منحت على iOS");
    }

    // إعدادات Android
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    // إعدادات iOS
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false, // false لأننا طلبنا الإذن قبل
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    // إعدادات مشتركة بين النظامين
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    // تهيئة البلجن
    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onNotificationTap(response);
      },
    );

    // تهيئة AlarmManager فقط على Android
    if (Platform.isAndroid) {
      await AndroidAlarmManager.initialize();
      print("✅ AlarmManager initialized on Android");
    } else {
      print("⚠️ AlarmManager skipped on iOS Simulator / unsupported device");
    }

    print("✅ AlarmAndNotifications initialized successfully");
  }

  /// عند الضغط على الإشعار
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
    if (Platform.isAndroid) {
      print("تم استدعاء schedulePeriodicNotification على Android");
      await AndroidAlarmManager.periodic(
        duration,
        1,
        showNotification,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
      );
    } else {
      print("⚠️ schedulePeriodicNotification غير مدعوم على iOS Simulator");
    }
  }

  /// جدولة إشعار لمرة واحدة
  static Future<void> scheduleOneShot() async {
    if (Platform.isAndroid) {
      await AndroidAlarmManager.oneShot(
        const Duration(seconds: 10),
        123,
        AlarmAndNotifications.showNotification,
        exact: true,
        wakeup: true,
      );
    } else {
      print("⚠️ scheduleOneShot غير مدعوم على iOS Simulator");
    }
  }

  /// عرض الإشعار
  @pragma('vm:entry-point') // 👈 ضروري لأنها تُستدعى من النظام
  static Future<void> showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Reminder Notifications',
      channelDescription: 'Channel for daily reminders',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      '🔔 تذكير - شركة دومِنا',
      'يرجى مزامنة ورفع الزيارات والمعلومات.',
      notificationDetails,
      payload: 'go_to_sync',
    );
  }
}
