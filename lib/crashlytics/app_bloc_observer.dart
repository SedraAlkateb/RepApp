import 'package:flutter_bloc/flutter_bloc.dart';
import 'crashlytics_service.dart';



class AppBlocObserver extends BlocObserver {


  final CrashlyticsService crashlyticsService;



  AppBlocObserver(
      this.crashlyticsService,
      );




  @override
  void onError(
      BlocBase bloc,
      Object error,
      StackTrace stackTrace,
      ) {


    crashlyticsService.recordError(

      error: error,

      stackTrace: stackTrace,

      reason:
      "Bloc Error : ${bloc.runtimeType}",

      fatal: false,

    );



    super.onError(
      bloc,
      error,
      stackTrace,
    );

  }



}