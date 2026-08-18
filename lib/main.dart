import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:domina_app/analytics/analytics_service.dart';
import 'package:domina_app/app/alarm-and-notifications.dart';
import 'package:domina_app/app/app.dart';
import 'package:domina_app/app/di/di.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();

    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stackTrace) {
      try {
        FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
          fatal: true,
        );
      } catch (_) {}
      return true;
    };
  } catch (e, stack) {
    debugPrint("Firebase initialization error: $e");
    try {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: false);
    } catch (_) {}
  }

  await _setupAppRequirements();
  await _prepareUserData();

  FlutterNativeSplash.remove();

  runApp(
    Phoenix(
      child: const MyResponsiveApp(),
    ),
  );
}

Future<void> _setupAppRequirements() async {
  await ScreenUtil.ensureScreenSize();

  // init light DI (core + local)
  await initAppModule();

  // تهيئة شبكة الاتصالات هنا بدلاً من initState
  try {
    await ensureNetworkModule();
  } catch (_) {}

  // Bloc Crash Monitoring
  try {
    Bloc.observer = AppBlocObserver(instance<CrashlyticsService>());
  } catch (_) {}

  HttpOverrides.global = MyHttpOverrides();

  await _initNotifications();
  await requestNotificationPermission();

  // جلب قياسات الشاشة بالطريقة الحديثة المعتمدة في Flutter
  final view = WidgetsBinding.instance.platformDispatcher.views.first;
  final physicalWidth = view.physicalSize.width;
  final devicePixelRatio = view.devicePixelRatio;
  final logicalWidth = physicalWidth / devicePixelRatio;

  // فحص هل الجهاز تابلت (العرض المنطقي أكبر من أو يساوي 600)
  final bool isTablet = logicalWidth >= 600;

  if (isTablet) {
    // التابلت: مسموح التدوير بالطول والعرض (Portrait + Landscape)
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } else {
    // الموبايل: بالطول فقط (Portrait)
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

class MyResponsiveApp extends StatelessWidget {
  const MyResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final double deviceWidth = mq.size.width;
    final bool isTabletDevice = deviceWidth > 450;

    // 🌟 فحص ما إذا كان الجهاز تابلت وفي الوضع العرضي حصراً
    final bool isTabletLandscape = isTabletDevice && mq.orientation == Orientation.landscape;

    return ScreenUtilInit(
      designSize: isTabletDevice ? const Size(500, 800) : const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      // 🌟 تطبيق تعديل الخط فقط إذا كان تابلت وفي الوضع العرضي
      fontSizeResolver: (fontSize, instance) {
        if (isTabletLandscape) {
          // تصغير الخط بنسبة 10% فقط في الوضع العرضي للتابلت
          return (fontSize * instance.scaleText) * 3;
        }
        // في بقية الحالات (طولي أو موابيل) يبعد الخط كالمعتاد
        return fontSize * instance.scaleText;
      },

      builder: (context, child) {
        // نمرر تطبيق MyApp الأصلي الذي يحتوي على MultiBlocProvider و MaterialApp الوحيدة!
        return SafeArea(
bottom: true,
          child:  const MyApp(key: ValueKey('app_root')),
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
        try {
          await FirebaseCrashlytics.instance.setUserIdentifier(repIdStr);
          await instance<CrashlyticsService>().setUserId(repIdStr);
        } catch (_) {}
        try {
          await instance<AnalyticsService>().setUserId(repIdStr);
          await FirebaseAnalytics.instance.setUserProperty(name: 'rep_id', value: repIdStr);
        } catch (_) {}
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

  const InitializationSettings settings = InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(settings: settings);
  await AlarmAndNotifications.initialize();
}

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid) await Permission.notification.request();
}

Future<void> _checkPlanExpiration() async {
  if (UserInfo.isLogging != 0 && UserInfo.endDate != null && UserInfo.endDate != "") {
    try {
      final today = DateFormat("dd-MM-yyyy").format(DateTime.now());
      DateTime endDate = formatStringToDataTime(UserInfo.endDate!);
      String nextDay = DateFormat("dd-MM-yyyy").format(endDate.add(const Duration(days: 1)));
      if (UserInfo.isLogging != 5 && today == nextDay) {
        final edit = EditIsLoginSqlUsecase(instance());
        await edit.execute(UserInfo.repId, 5);
        UserInfo.isLogging = 5;
      }
    } catch (e, stack) {
      await instance<CrashlyticsService>().recordError(error: e, stackTrace: stack, reason: "Check Plan Expiration");
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        if (host == '192.168.1.50' || host == 'localhost') return true;
        return false;
      };
  }
}