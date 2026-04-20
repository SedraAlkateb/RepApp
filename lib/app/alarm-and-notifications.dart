import 'dart:io';
import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/main.dart';
import 'package:domina_app/presentation/uniti/time.dart';
import 'package:domina_app/presentation/upload_delete/page/async_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AlarmAndNotifications {
  static Future<void> initialize() async {
    tz.initializeTimeZones(); // ضروري جداً لتفادي خطأ tz

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);

    await flutterLocalNotificationsPlugin.initialize(
   settings:   initSettings, // تم تصحيح استدعاء الباراميتر هنا
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onNotificationTap(response);
      },
    );

    if (Platform.isAndroid) {
      await AndroidAlarmManager.initialize();
    }
  }

  static void _onNotificationTap(NotificationResponse response) {
    initAsyncInModule();
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const AsyncPage()),
    );
  }

  /// دالة جدولة إشعار يوم الخطة (الساعة 9 صباحاً)
  static Future<void> scheduleExpirationNotification() async {
    if (UserInfo.endDate != null && UserInfo.endDate != "" && UserInfo.endDate != "0") {
      try {
        // تحويل تاريخ النهاية (dd-MM-yyyy)
        DateTime endDay = formatStringToDataTime(UserInfo.endDate!);

        // ضبط الوقت ليوم انتهاء الخطة - الساعة 9 صباحاً
        DateTime scheduledTime = DateTime(endDay.year, endDay.month, endDay.day, 9, 0);

        // التحقق من أن الوقت المجدول في المستقبل
        if (scheduledTime.isAfter(DateTime.now())) {
          await flutterLocalNotificationsPlugin.zonedSchedule(
            id: 1001,
            title: '🔔 شركة دومِنا - تذكير هام',
            body: 'اليوم هو اليوم الأخير في خطتك الحالية، يرجى مزامنة البيانات قبل نهاية اليوم.',
            payload: 'go_to_sync',
            scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
            notificationDetails: const NotificationDetails(
              android: AndroidNotificationDetails(
                'expiry_channel',
                'تنبيهات الخطة',
                importance: Importance.max,
                priority: Priority.high,
                playSound: true,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          );
          print("✅ تم جدولة الإشعار ليوم الانتهاء: $scheduledTime");
        }
      } catch (e) {
        print("❌ فشل جدولة الإشعار: $e");
      }
    }
  }
  @pragma('vm:entry-point')
  static Future<void> showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Reminder Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      id: 1,
      title: '🔔 تذكير - شركة دومِنا',
      body: 'يرجى مزامنة ورفع الزيارات والمعلومات.',
      notificationDetails: notificationDetails,
      payload: 'go_to_sync',
    );
  }

  static Future<void> scheduleOneShot() async {
    if (Platform.isAndroid) {
      await AndroidAlarmManager.oneShot(
        const Duration(seconds: 10),
        123,
        showNotification,
        exact: true,
        wakeup: true,
      );
    }
  }
}
