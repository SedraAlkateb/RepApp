import 'dart:io';
import 'package:domina_app/app/app.dart';
import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/usecase/edit_is_login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/is_login_sql_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'presentation/uniti/time.dart';


Future<int?> sss() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = MyHttpOverrides();
  ///
  String? nextDay = UserInfo.endDate != null

      ? DateTime.parse(UserInfo.endDate!).add(Duration(days: 1)).toIso8601String()

      : null;

  print(nextDay ?? "تاريخ نهاية الخطة غير موجود.");

if(formatDateTimeFromDataTime( DateTime.now())==formatDateTime(nextDay!)){
  EditIsLoginSqlUsecase editIsLoginSqlUsecase =EditIsLoginSqlUsecase(instance());
 (await editIsLoginSqlUsecase.execute(UserInfo.repId, 5)).fold((failure) {
   print("object");
   return 0;
 }, (data) async{

 });
}
  IsLoginSqlUsecase isLoginSqlUsecase = IsLoginSqlUsecase(instance());
  (await isLoginSqlUsecase.execute()).fold((failure) {
    print("object");
    return 0;
  },
  (data) async {
    if (data != null && (data.isLogin > 0)) {
      UserInfo.name = data.name;
      UserInfo.isLogging = data.isLogin;
      UserInfo.activePlanId = data.activePlanId;
      UserInfo.otherPlanId = data.otherPlanId;
      UserInfo.otherstatus = data.otherStatus;
      UserInfo.percentage = data.percentage;
      UserInfo.recipesCount = data.recipesCount;
      UserInfo.repId = data.repId;
      UserInfo.token = data.token;
      UserInfo.startDate = data.startDate;
      UserInfo.endDate = data.endDate;
      UserInfo.endDate = data.endDate;
      UserInfo.otherStartDate = data.otherStartDate;
      UserInfo.otherEndDate = data.otherEndDate;
      UserInfo.samplesCount = data.samplesCount;
      UserInfo.flag = data.flag;
      UserInfo.flag1 = UserInfo.otherstatus == -1 ? 0 : data.flag1;
    } else {
      UserInfo.isLogging = data?.isLogin ?? 0;
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
 await sss();
 //initializeTimeZones();
  runApp(Phoenix( child: const MyApp()));
}


Future<void> _initNotifications() async {
  // إعداد الإشعارات المحلية
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
