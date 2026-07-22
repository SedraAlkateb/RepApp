
import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:domina_app/analytics/analytics_service.dart';
import 'package:domina_app/app/alarm-and-notifications.dart';
import 'package:domina_app/app/app.dart';
import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/crashlytics/app_bloc_observer.dart';
import 'package:domina_app/crashlytics/crashlytics_service.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/is_login_sql_usecase.dart';
import 'package:domina_app/presentation/uniti/time.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_framework/responsive_framework.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();

try {
await Firebase.initializeApp();

// 1️⃣ تفعيل Analytics صراحة للعمل في الـ Debug والـ Release
await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

// 2️⃣ تفعيل Crashlytics صراحة
await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

// 3️⃣ التقاط أخطاء Flutter Fatal (الواجهات والـ UI)
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

// 4️⃣ التقاط أخطاء الـ Async / Uncaught
PlatformDispatcher.instance.onError = (error, stackTrace) {
FirebaseCrashlytics.instance.recordError(
error,
stackTrace,
fatal: true,
);
return true;
};
} catch (e, stack) {
debugPrint("Firebase initialization error: $e");
FirebaseCrashlytics.instance.recordError(
e,
stack,
fatal: false,
);
}

FlutterNativeSplash.remove();

await _setupAppRequirements();

await _prepareUserData();

runApp(
Phoenix(
child: const MyResponsiveApp(),
),
);
}

Future<void> _setupAppRequirements() async {
await ScreenUtil.ensureScreenSize();

// Dependency Injection
await initAppModule();

// Bloc Crash Monitoring
Bloc.observer = AppBlocObserver(
instance<CrashlyticsService>(),
);

HttpOverrides.global = MyHttpOverrides();

await _initNotifications();

await requestNotificationPermission();

await SystemChrome.setPreferredOrientations([
DeviceOrientation.portraitUp,
DeviceOrientation.portraitDown,
]);
}

class MyResponsiveApp extends StatelessWidget {
const MyResponsiveApp({
super.key,
});

@override
Widget build(BuildContext context) {
final double deviceWidth = MediaQuery.of(context).size.width;
final bool isTabletDevice = deviceWidth > 450;

return ScreenUtilInit(
designSize: isTabletDevice ? const Size(400, 800) : const Size(360, 690),
minTextAdapt: true,
splitScreenMode: true,
builder: (context, child) {
return ResponsiveBreakpoints.builder(
breakpoints: const [
Breakpoint(start: 0, end: 450, name: MOBILE),
Breakpoint(start: 451, end: 1023, name: TABLET),
Breakpoint(start: 1024, end: double.infinity, name: DESKTOP),
],
child: MaterialApp(
navigatorKey: navigatorKey,
debugShowCheckedModeBanner: false,
home: const MyApp(),
),
);
},
);
}
}

Future<void> _prepareUserData() async {
final usecase = IsLoginSqlUsecase(instance());
final result = await usecase.execute();

await result.fold(
(failure) {
UserInfo.isLogging = 0;
},
(data) async {
if (data != null && data.isLogin > 0) {
UserInfo.fillFromModel(data);

final String repIdStr = UserInfo.repId.toString();

// 🆔 1. تعيين معرف المندوب في Crashlytics لربط الكراشات برقم المندوب مباشرة للفلترة
await FirebaseCrashlytics.instance.setUserIdentifier(repIdStr);
await instance<CrashlyticsService>().setUserId(repIdStr);

// 🆔 2. تعيين معرف المندوب والـ User Property في Analytics
await instance<AnalyticsService>().setUserId(repIdStr);
await FirebaseAnalytics.instance.setUserProperty(
name: 'rep_id',
value: repIdStr,
);

await _checkPlanExpiration();

await AlarmAndNotifications.scheduleExpirationNotification();
} else {
UserInfo.isLogging = 0;
}
},
);
}

Future<void> _initNotifications() async {
const AndroidInitializationSettings androidSettings =
AndroidInitializationSettings('@mipmap/ic_launcher');

const InitializationSettings settings =
InitializationSettings(android: androidSettings);

await flutterLocalNotificationsPlugin.initialize(
settings: settings,
);

await AlarmAndNotifications.initialize();
}

Future<void> requestNotificationPermission() async {
if (Platform.isAndroid) {
await Permission.notification.request();
}
}

Future<void> _checkPlanExpiration() async {
if (UserInfo.isLogging != 0 &&
UserInfo.endDate != null &&
UserInfo.endDate != "") {
try {
final today = DateFormat("dd-MM-yyyy").format(DateTime.now());

DateTime endDate = formatStringToDataTime(UserInfo.endDate!);

String nextDay =
DateFormat("dd-MM-yyyy").format(endDate.add(const Duration(days: 1)));

if (UserInfo.isLogging != 5 && today == nextDay) {
final edit = EditIsLoginSqlUsecase(instance());

await edit.execute(UserInfo.repId, 5);

UserInfo.isLogging = 5;
}
} catch (e, stack) {
await instance<CrashlyticsService>().recordError(
error: e,
stackTrace: stack,
reason: "Check Plan Expiration",
);
}
}
}

class MyHttpOverrides extends HttpOverrides {
@override
HttpClient createHttpClient(SecurityContext? context) {
return super.createHttpClient(context)
..badCertificateCallback =
(X509Certificate cert, String host, int port) => true;
}
}
