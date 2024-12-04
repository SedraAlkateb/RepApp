// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' ;
// import 'package:timezone/timezone.dart' ;
//
// // Future<void> scheduleNotification() async {
// //   // تحميل البيانات الزمنية (مطلوب للاستخدام الصحيح للمناطق الزمنية)
// //   tz.initializeTimeZones();
// //
// //   // تحديد وقت الإشعار
// //   final tz.TZDateTime scheduledTime = tz.TZDateTime.now(tz.local).add(
// //     const Duration(seconds: 10), // اضبط الوقت إلى المدة المطلوبة
// //   );
// //
// //   // إنشاء الإشعار
// //   await flutterLocalNotificationsPlugin.zonedSchedule(
// //     0, // معرف الإشعار
// //     'إشعار مجدول', // العنوان
// //     'هذا الإشعار تم جدولته للعرض الآن!', // النص
// //     scheduledTime, // وقت الإشعار
// //     const NotificationDetails(
// //       android: AndroidNotificationDetails(
// //         'channel_id', // معرف القناة
// //         'channel_name', // اسم القناة
// //         channelDescription: 'channel_description', // وصف القناة
// //         importance: Importance.high, // أهمية الإشعار
// //         priority: Priority.high, // أولوية الإشعار
// //       ),
// //     ),
// //  //   androidAllowWhileIdle: true, // يسمح للإشعار بالعمل أثناء الخمول
// //     uiLocalNotificationDateInterpretation:
// //     UILocalNotificationDateInterpretation.absoluteTime,
// //   );
// // }
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// Future<void> initializeNotifications() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('app_icon'); // ضع اسم الأيقونة هنا.
//
//   const InitializationSettings initializationSettings =
//   InitializationSettings(android: initializationSettingsAndroid);
//
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//   );
// }
