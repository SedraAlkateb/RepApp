import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:domina_app/analytics/analytics_service.dart';
import 'package:domina_app/app/alarm-and-notifications.dart';
import 'package:domina_app/app/app.dart';
import 'package:domina_app/app/di/di.dart';
import 'package:domina_app/app/logger/app_logger.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/crashlytics/app_bloc_observer.dart';
import 'package:domina_app/crashlytics/crashlytics_service.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/is_login_sql_usecase.dart';
import 'package:domina_app/firebase_options.dart';
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
  AppLogger.init();

  // جعل أشرطة النظام شفافة تماماً لتجنب ظهور المربعات السوداء
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // شفاف لشريط الأعلى (الساعة والشحن)
      statusBarIconBrightness: Brightness.dark, // لون أيقونات الساعة (dark أو light)
      systemNavigationBarColor: Colors.transparent, // شفاف للشريط السفلي
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // إذا كنت تريد أن يتمدد التطبيق تحت أشرطة النظام بالكامل (Edge-to-Edge):
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

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
      } catch (e) {
        debugPrint('Crashlytics platform error: $e');
      }

      return true;
    };
  } catch (e, stack) {
    debugPrint('Firebase initialization error: $e');

    try {
      if (Firebase.apps.isNotEmpty) {
        await FirebaseCrashlytics.instance.recordError(
          e,
          stack,
          fatal: false,
        );
      }
    } catch (crashError) {
      debugPrint('Crashlytics recording error: $crashError');
    }
  }

// ------------------------------------------------------------
// App requirements
// ------------------------------------------------------------
  try {
    await _setupAppRequirements();
  } catch (e, stack) {
    debugPrint('App requirements initialization error: $e');

    try {
      if (Firebase.apps.isNotEmpty) {
        await FirebaseCrashlytics.instance.recordError(
          e,
          stack,
          fatal: false,
          reason: 'App requirements initialization',
        );
      }
    } catch (_) {}
  }

// ------------------------------------------------------------
// User data
// مهم: لا نسمح لهذه العملية بمنع تشغيل التطبيق
// ------------------------------------------------------------
  try {
    await _prepareUserData();
  } catch (e, stack) {
    debugPrint('User data initialization error: $e');

    try {
      UserInfo.isLogging = 0;
    } catch (_) {}

    try {
      if (Firebase.apps.isNotEmpty) {
        await FirebaseCrashlytics.instance.recordError(
          e,
          stack,
          fatal: false,
          reason: 'User data initialization',
        );
      }
    } catch (_) {}
  }

// ------------------------------------------------------------
// إزالة Native Splash دائمًا قبل runApp
// ------------------------------------------------------------
  FlutterNativeSplash.remove();

// ------------------------------------------------------------
// Start Flutter app
// ------------------------------------------------------------
  runApp(
    Phoenix(
      child: const MyResponsiveApp(),
    ),
  );
}

// ============================================================
// APP REQUIREMENTS
// ============================================================

Future<void> _setupAppRequirements() async {
// ------------------------------------------------------------
// Screen
// ------------------------------------------------------------
  await ScreenUtil.ensureScreenSize();

// ------------------------------------------------------------
// Dependency Injection
// ------------------------------------------------------------
  try {
    await initAppModule();
  } catch (e, stack) {
    debugPrint('DI initialization error: $e');

    try {
      if (Firebase.apps.isNotEmpty) {
        await FirebaseCrashlytics.instance.recordError(
          e,
          stack,
          fatal: false,
          reason: 'DI initialization',
        );
      }
    } catch (_) {}
  }

// ------------------------------------------------------------
// Network
// ------------------------------------------------------------
  try {
    await ensureNetworkModule();
  } catch (e) {
    debugPrint('Network module error: $e');
  }

// ------------------------------------------------------------
// Bloc Crash Monitoring
// ------------------------------------------------------------
  try {
    Bloc.observer = AppBlocObserver(
      instance<CrashlyticsService>(),
    );
  } catch (e) {
    debugPrint('Bloc observer error: $e');
  }

// ------------------------------------------------------------
// HTTP Overrides
// ------------------------------------------------------------
  HttpOverrides.global = MyHttpOverrides();

// ------------------------------------------------------------
// Notifications
// لا تسمح بفشل الإشعارات بإيقاف التطبيق
// ------------------------------------------------------------
  try {
    await _initNotifications();
  } catch (e, stack) {
    debugPrint('Notifications initialization error: $e');

    try {
      if (Firebase.apps.isNotEmpty) {
        await FirebaseCrashlytics.instance.recordError(
          e,
          stack,
          fatal: false,
          reason: 'Notifications initialization',
        );
      }
    } catch (_) {}
  }

// ------------------------------------------------------------
// Notification Permission
// ------------------------------------------------------------
  try {
    await requestNotificationPermission();
  } catch (e) {
    debugPrint('Notification permission error: $e');
  }

// ------------------------------------------------------------
// Device Orientation
// ------------------------------------------------------------
  try {
    final views = WidgetsBinding.instance.platformDispatcher.views;

    if (views.isEmpty) {
      return;
    }

    final view = views.first;

    final physicalWidth = view.physicalSize.width;
    final devicePixelRatio = view.devicePixelRatio;

    if (devicePixelRatio <= 0) {
      return;
    }

    final logicalWidth = physicalWidth / devicePixelRatio;

    final bool isTablet = logicalWidth >= 600;

    if (isTablet) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  } catch (e) {
    debugPrint('Orientation configuration error: $e');
  }
}

// ============================================================
// RESPONSIVE APP
// ============================================================

class MyResponsiveApp extends StatelessWidget {
  const MyResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final double deviceWidth = mq.size.width;
    final bool isTabletDevice = deviceWidth > 450;
    final bool isTabletLandscape =
        isTabletDevice && mq.orientation == Orientation.landscape;

    return ScreenUtilInit(
      designSize: isTabletDevice ? const Size(500, 800) : const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      fontSizeResolver: (fontSize, instance) {
        if (isTabletLandscape) {
          return (fontSize * instance.scaleText) * 2;
        }
        return fontSize * instance.scaleText;
      },
      builder: (context, child) {
        // جلب مساحة شريط الحالة بالأعلى والشريط السفلي دون استخدام SafeArea
        final double bottomPadding = MediaQuery.of(context).padding.bottom;

        return Container(
          color: const Color(0xFFFFFFFF), // نفس لون خلفية التطبيق أو الـ Scaffold لديك
                child: Padding(
                padding: EdgeInsets.only(
                bottom: bottomPadding,
                ),
          child: const MyApp(
            key: ValueKey('app_root'),
          ),
        ),
                );
      },
    );
  }
}
// ============================================================
// USER DATA
// ============================================================

Future<void> _prepareUserData() async {
  final usecase = IsLoginSqlUsecase(instance());

  final result = await usecase.execute();

  await result.fold(
// ----------------------------------------------------------
// Failure
// ----------------------------------------------------------
    (failure) async {
      debugPrint('IsLoginSqlUsecase failure: $failure');

      UserInfo.isLogging = 0;
    },

// ----------------------------------------------------------
// Success
// ----------------------------------------------------------
    (data) async {
      if (data != null && data.isLogin > 0) {
        UserInfo.fillFromModel(data);

        final String repIdStr = UserInfo.repId.toString();

// ------------------------------------------------------
// Crashlytics User ID
// ------------------------------------------------------
        try {
          if (Firebase.apps.isNotEmpty) {
            await FirebaseCrashlytics.instance.setUserIdentifier(
              repIdStr,
            );
          }
        } catch (e) {
          debugPrint('Crashlytics user ID error: $e');
        }

        try {
          await instance<CrashlyticsService>().setUserId(
            repIdStr,
          );
        } catch (e) {
          debugPrint('CrashlyticsService user ID error: $e');
        }

// ------------------------------------------------------
// Analytics User ID
// ------------------------------------------------------
        try {
          await instance<AnalyticsService>().setUserId(
            repIdStr,
          );
        } catch (e) {
          debugPrint('AnalyticsService user ID error: $e');
        }

        try {
          if (Firebase.apps.isNotEmpty) {
            await FirebaseAnalytics.instance.setUserProperty(
              name: 'rep_id',
              value: repIdStr,
            );
          }
        } catch (e) {
          debugPrint('Firebase Analytics user property error: $e');
        }

// ------------------------------------------------------
// Plan expiration
// ------------------------------------------------------
        try {
          await _checkPlanExpiration();
        } catch (e, stack) {
          debugPrint('Plan expiration error: $e');

          try {
            await instance<CrashlyticsService>().recordError(
              error: e,
              stackTrace: stack,
              reason: 'Check Plan Expiration',
            );
          } catch (_) {}
        }

// ------------------------------------------------------
// Expiration notification
// ------------------------------------------------------
        try {
          await AlarmAndNotifications.scheduleExpirationNotification();
        } catch (e) {
          debugPrint(
            'Schedule expiration notification error: $e',
          );
        }
      } else {
        UserInfo.isLogging = 0;
      }
    },
  );
}

// ============================================================
// LOCAL NOTIFICATIONS
// ============================================================

Future<void> _initNotifications() async {
// ------------------------------------------------------------
// Android
// ------------------------------------------------------------
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

// ------------------------------------------------------------
// iOS
// مهم جدًا: يجب وجود هذه الإعدادات عند تشغيل iOS
// ------------------------------------------------------------
  const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

// ------------------------------------------------------------
// Common initialization
// ------------------------------------------------------------
  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    settings: settings,
  );

// ------------------------------------------------------------
// App notification/alarm initialization
// ------------------------------------------------------------
  try {
    await AlarmAndNotifications.initialize();
  } catch (e) {
    debugPrint(
      'AlarmAndNotifications initialization error: $e',
    );
  }
}

// ============================================================
// NOTIFICATION PERMISSION
// ============================================================

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid || Platform.isIOS) {
    await Permission.notification.request();
  }
}

// ============================================================
// PLAN EXPIRATION
// ============================================================

Future<void> _checkPlanExpiration() async {
  if (UserInfo.isLogging == 0 ||
      UserInfo.endDate == null ||
      UserInfo.endDate!.isEmpty) {
    return;
  }

  try {
    final String today = DateFormat("dd-MM-yyyy").format(DateTime.now());

    final DateTime endDate = formatStringToDataTime(UserInfo.endDate!);

    final String nextDay = DateFormat("dd-MM-yyyy").format(
      endDate.add(
        const Duration(days: 1),
      ),
    );

    if (UserInfo.isLogging != 5 && today == nextDay) {
      final edit = EditIsLoginSqlUsecase(instance());

      await edit.execute(
        UserInfo.repId,
        5,
      );

      UserInfo.isLogging = 5;
    }
  } catch (e, stack) {
    try {
      await instance<CrashlyticsService>().recordError(
        error: e,
        stackTrace: stack,
        reason: "Check Plan Expiration",
      );
    } catch (_) {}

    debugPrint(
      'Check plan expiration error: $e',
    );
  }
}

// ============================================================
// HTTP OVERRIDES
// ============================================================

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(
    SecurityContext? context,
  ) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) {
        if (host == '192.168.1.50' || host == 'localhost') {
          return true;
        }

        return false;
      };
  }
}
