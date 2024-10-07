import 'package:domina_app/app/app.dart';
import 'package:domina_app/app/di.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/usecase/is_login_sql_usecase.dart';
import 'package:flutter/material.dart';

Future<int?> sss()async{
  IsLoginSqlUsecase isLoginSqlUsecase=IsLoginSqlUsecase(instance());
  (await isLoginSqlUsecase.execute()).fold((failure) {
    print("object");
    return 0;
  }, (data) async {
    if(data!=null&&(data.isLogin==1||data.isLogin==2)){
      UserInfo.name=data.name;
      UserInfo.isLogging=data.isLogin;
      UserInfo.activePlanId=data.activePlanId;
      UserInfo.otherPlanId=data.otherPlanId;
      UserInfo.percentage=data.percentage;
      UserInfo.repId=data.repId;
      UserInfo.token=data.token;
    }else {
      UserInfo.isLogging=data?.isLogin??0;
    }
   return data??0;
  });
  return null;
}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
 await sss();
  runApp(const MyApp());
}

