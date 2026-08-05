// lib/app/di/di_core.dart
import 'package:domina_app/crashlytics/firebase_crashlytics_service.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:domina_app/app/logger/error_reporter.dart';
import 'package:domina_app/crashlytics/crashlytics_service.dart';
import 'package:domina_app/analytics/firebase_analytics_service.dart';
import 'package:domina_app/analytics/analytics_service.dart';
import 'package:domina_app/data/network/network_info.dart';

Future<void> initCoreModule() async {
  final getIt = GetIt.instance;

  if (!getIt.isRegistered<FirebaseCrashlytics>()) {
    getIt.registerLazySingleton<FirebaseCrashlytics>(() => FirebaseCrashlytics.instance);
  }
  if (!getIt.isRegistered<CrashlyticsService>()) {
    getIt.registerLazySingleton<CrashlyticsService>(() => FirebaseCrashlyticsService(getIt<FirebaseCrashlytics>()));
  }
  if (!getIt.isRegistered<ErrorReporter>()) {
    getIt.registerLazySingleton<ErrorReporter>(() => ErrorReporter(getIt<CrashlyticsService>()));
  }

  if (!getIt.isRegistered<FirebaseAnalytics>()) {
    getIt.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
  }
  if (!getIt.isRegistered<AnalyticsService>()) {
    getIt.registerLazySingleton<AnalyticsService>(() => FirebaseAnalyticsService(getIt<FirebaseAnalytics>()));
  }

  if (!getIt.isRegistered<NetworkInfo>()) {
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
  }
}