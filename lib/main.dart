import 'dart:io';
import 'package:domina_app/app/app.dart';
import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/is_login_sql_usecase.dart';
import 'package:domina_app/presentation/uniti/time.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _showEndDateNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'التنبيهات',
    channelDescription: 'تنبيهات خاصة بالوقت',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    enableVibration: true,
    playSound: true,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'شركة دومِنا',
    'لقد وصلت إلى نهاية الخطة الحالية, يرجى ضغط زر المزامنة لرفع الزيارات وتحديث المعلومات ', // نص الإشعار
    platformChannelSpecifics,
    payload: 'end_date_notification',
  );
}

Future<int?> sss() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = MyHttpOverrides();
  IsLoginSqlUsecase isLoginSqlUsecase = IsLoginSqlUsecase(instance());
  (await isLoginSqlUsecase.execute()).fold((failure) {
    return 0;
  }, (data) async {
    if (data != null && (data.isLogin > 0)) {
      UserInfo.name = data.name;
      UserInfo.isLogging = data.isLogin;
      UserInfo.activePlanId = data.activePlanId ?? -5;
      UserInfo.otherPlanId = data.otherPlanId;
      UserInfo.otherstatus = data.otherStatus;
      UserInfo.percentage = data.percentage;
      UserInfo.recipesCount = data.recipesCount;
      UserInfo.repId = data.repId;
      UserInfo.token = data.token;
      UserInfo.startDate = data.startDate;
      UserInfo.endDate = data.endDate;
      UserInfo.otherStartDate = data.otherStartDate;
      UserInfo.otherEndDate = data.otherEndDate;
      UserInfo.samplesCount = data.samplesCount;
      UserInfo.repType = data.repType;
      UserInfo.flag = data.flag;
      UserInfo.flag1 = UserInfo.otherstatus == -1 ? 0 : data.flag1;
   //   UserInfo.endDate="27-02-2025";
      if (UserInfo.isLogging != 0 && UserInfo.endDate != null) {

        final now = formatDateTimeFromDataTime(DateTime.now());
        final String endDate = UserInfo.endDate ?? "";
        if (UserInfo.endDate != null && now == formatDateTime(endDate)) {
          _showEndDateNotification();
        }
        String? nextDay = UserInfo.endDate != null
            ? DateFormat("dd-MM-yyyy").format(
            formatStringToDataTime(UserInfo.endDate!).add(Duration(days: 1)))
            : "";

        print(UserInfo.isLogging );
        if (UserInfo.isLogging != 5) {
          print("now");
          print(now);
          print("nextDay");
          print(nextDay);
          if (now==nextDay) {
            print(now);
            print(nextDay);
            EditIsLoginSqlUsecase editIsLoginSqlUsecase =
                EditIsLoginSqlUsecase(instance());
            (await editIsLoginSqlUsecase.execute(UserInfo.repId, 5)).fold(
                (failure) {
              return 0;
            }, (data) async {
              UserInfo.isLogging = 5;
            });
          }
        }
      }
    } else {
      UserInfo.isLogging = 0;
    }
    return data ?? 0;
  });

  return null;
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await _initNotifications();
  await requestNotificationPermission();
  await sss();
  //initializeTimeZones();
  runApp(Phoenix(child: const MyApp()));
}

Future<void> _initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid) {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print("تم منح إذن الإشعارات.");
    } else if (status.isDenied) {
      openAppSettings();
    } else if (status.isPermanentlyDenied) {
      print("تم رفض الإذن نهائيًا. يمكنك طلبه من إعدادات النظام.");
    }
  }
}
