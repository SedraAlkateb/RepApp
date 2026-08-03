// name=lib/app/di_core.dart
import 'package:domina_app/crashlytics/firebase_crashlytics_service.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:domina_app/app/logger/error_reporter.dart';
import 'package:domina_app/crashlytics/crashlytics_service.dart';
import 'package:domina_app/analytics/firebase_analytics_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:domina_app/data/network/network_info.dart';

final GetIt getIt = GetIt.instance;

Future<void> initCoreModule() async {
  // Crashlytics
  if (!getIt.isRegistered<FirebaseCrashlytics>()) {
    getIt.registerLazySingleton<FirebaseCrashlytics>(() => FirebaseCrashlytics.instance);
    getIt.registerLazySingleton<CrashlyticsService>(
          () => FirebaseCrashlyticsService(getIt<FirebaseCrashlytics>()),
    );
    getIt.registerLazySingleton<ErrorReporter>(() => ErrorReporter(getIt<CrashlyticsService>()));
  }

  // Analytics
  if (!getIt.isRegistered<FirebaseAnalytics>()) {
    getIt.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
    getIt.registerLazySingleton(
            () => FirebaseAnalyticsService(getIt<FirebaseAnalytics>()));
  }

  // NetworkInfo
  if (!getIt.isRegistered<NetworkInfo>()) {
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
  }


}