import 'dart:io';
import 'package:domina_app/app/alarm-and-notifications.dart';
import 'package:domina_app/app/app.dart';
import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/is_login_sql_usecase.dart';
import 'package:domina_app/presentation/uniti/time.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper();
  final appSqlApi = AppSqlApi(dbHelper);
  await appSqlApi.debugOtherPlanBrandByRepPlanId(UserInfo.activePlanId);

  await initAppModule();
  await _initNotifications();
  await requestNotificationPermission();
  AlarmAndNotifications.showNotification();
  await sss();

  runApp(Phoenix(child: const MyResponsiveApp()));
}

Future<void> _initNotifications() async {
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initSettings =
  InitializationSettings(android: androidSettings, iOS: iosSettings);

  await flutterLocalNotificationsPlugin.initialize(settings: initSettings);
  await AlarmAndNotifications.initialize();
  await AlarmAndNotifications.scheduleOneShot();
}

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid) {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print("✅ تم منح إذن الإشعارات على Android.");
    } else if (status.isDenied) {
      print("⚠️ تم رفض إذن الإشعارات مؤقتًا.");
      openAppSettings();
    } else if (status.isPermanentlyDenied) {
      print("🚫 تم رفض الإذن نهائيًا. يمكنك تفعيله من إعدادات النظام.");
    }
  } else if (Platform.isIOS) {
    final iosPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    await iosPlugin?.requestPermissions(alert: true, badge: true, sound: true);
    print("✅ تم طلب صلاحيات الإشعارات على iOS.");
  }
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
      UserInfo.cityId = data.cityId;
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

      if (UserInfo.isLogging != 0 && UserInfo.endDate != null) {
        final now = formatDateTimeFromDataTime(DateTime.now());
        if (now == formatDateTime(UserInfo.endDate!)) {
          _showEndDateNotification();
        }

        String? nextDay = UserInfo.endDate != null
            ? DateFormat("dd-MM-yyyy")
            .format(formatStringToDataTime(UserInfo.endDate!).add(const Duration(days: 1)))
            : "";

        if (UserInfo.isLogging != 5 && now == nextDay) {
          EditIsLoginSqlUsecase editIsLoginSqlUsecase = EditIsLoginSqlUsecase(instance());
          (await editIsLoginSqlUsecase.execute(UserInfo.repId, 5)).fold((failure) {
            return 0;
          }, (data) async {
            UserInfo.isLogging = 5;
          });
        }
      }
    } else {
      UserInfo.isLogging = 0;
    }
    return data ?? 0;
  });

  return null;
}

Future<void> _showEndDateNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'your_channel_id',
    'التنبيهات',
    channelDescription: 'تنبيهات خاصة بالوقت',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    enableVibration: true,
    playSound: true,
  );

  const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    id: 2, // يجب إضافة id: هنا
    title: 'شركة دومِنا', // يجب إضافة title: هنا
    body: 'لقد وصلت إلى نهاية الخطة الحالية، يرجى ضغط زر المزامنة لرفع الزيارات وتحديث المعلومات.', // يجب إضافة body: هنا
    notificationDetails: platformDetails, // يجب إضافة notificationDetails: هنا
    payload: 'end_date_notification',
  );
}

class MyResponsiveApp extends StatelessWidget {
  const MyResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      breakpoints: const [
        Breakpoint(start: 0, end: 450, name: MOBILE),
        Breakpoint(start: 451, end: 1023, name: TABLET),
        Breakpoint(start: 1024, end: double.infinity, name: DESKTOP),
      ],
      child: Builder(
        builder: (context) {
          final breakPoint = ResponsiveBreakpoints.of(context).breakpoint;
          final designSize = getDesignSizeByBreakpoint(breakPoint);

          return ScreenUtilInit(
            designSize: designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => const MyApp(),
          );
        },
      ),
    );
  }
}

Size getDesignSizeByBreakpoint(Breakpoint breakPoint) {
  if (breakPoint.name == MOBILE) {
    UserInfo.isScreenWidth = false;
    return const Size(360, 690);
  } else if (breakPoint.name == TABLET) {
    UserInfo.isScreenWidth = true;
    return const Size(768, 1024);
  } else {
    return const Size(1024, 768);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
