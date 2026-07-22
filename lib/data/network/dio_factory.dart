// ignore_for_file: deprecated_member_use, prefer_interpolation_to_compose_strings, prefer_const_constructors, constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:domina_app/app/constants.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/crashlytics/crashlytics_service.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


const String APPLICATION_JSON = "application/json";
const String MULTIPART = "multipart/form-data";
const String CONTENT_TYPE = "contentType";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "lang";



class DioFactory {


  final CrashlyticsService crashlyticsService;


  DioFactory(
      this.crashlyticsService,
      );



  Future<Dio> getDio() async {


    Dio dio = Dio();



    (dio.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate =
        (HttpClient client) {

      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      return client;

    };



    String to = UserInfo.token ?? "";

    String token = "Bearer " + to;


    Map<String, String> headers = {

      CONTENT_TYPE: MULTIPART,

      ACCEPT: APPLICATION_JSON,

      "X-Requested-With": "XMLHttpRequest",

      AUTHORIZATION: token,

      DEFAULT_LANGUAGE: "ar",

      "Access-Control-Allow-Headers": "*",

      "Access-Control-Allow-Methods":
      "POST, GET, OPTIONS, PUT, DELETE, HEAD",

    };



    dio.options = BaseOptions(

      baseUrl: Constants.baseUrl,

      headers: headers,

      connectTimeout:
      Duration(seconds: 50),

      receiveTimeout:
      Duration(seconds: 50),

    );




    dio.interceptors.add(
      MyApiInterceptor(
        crashlyticsService,
      ),
    );



    if (!kReleaseMode) {


      dio.interceptors.add(

        PrettyDioLogger(

          requestHeader: true,

          requestBody: true,

          responseHeader: true,

        ),

      );


    }



    return dio;

  }

}






class MyApiInterceptor extends Interceptor {


  final CrashlyticsService crashlyticsService;



  MyApiInterceptor(
      this.crashlyticsService,
      );




  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {


    String? authToken = UserInfo.token;

    String lang = "en";



    if(authToken != null){

      options.headers['Authorization'] =
      "Bearer $authToken";


      options.headers['lang'] =
          lang;


      if(!kReleaseMode){

        print(authToken);

      }

    }



    return handler.next(options);

  }






  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {


    final statusCode =
        err.response?.statusCode;



    final path =
        err.requestOptions.path;



    debugPrint(
      'ERROR[$statusCode] => PATH: $path',
    );




    // ============================
    // Server Errors
    // Crashlytics
    // ============================


    if(statusCode != null &&
        statusCode >= 500){


      crashlyticsService.recordError(

        error: err,

        stackTrace:
        err.stackTrace ??
            StackTrace.current,

        reason:
        "Server Error $statusCode : $path",

        fatal: false,

      );


    }




    // ============================
    // Authentication
    // Log فقط
    // ============================


    else if(statusCode == 401 ||
        statusCode == 403){


      crashlyticsService.log(
        "Authorization Error $statusCode : $path",
      );


    }





    // ============================
    // Not Found
    // ============================


    else if(statusCode == 404){


      crashlyticsService.log(
        "API Not Found : $path",
      );


    }





    // ============================
    // Timeout / Internet
    // ============================


    else if(
    err.type ==
        DioExceptionType.connectionTimeout ||
        err.type ==
            DioExceptionType.receiveTimeout ||
        err.type ==
            DioExceptionType.connectionError
    ){


      crashlyticsService.log(
        "Network Error : ${err.message}",
      );


    }





    // ============================
    // Unknown Dio Error
    // ============================


    else{


      crashlyticsService.recordError(

        error: err,

        stackTrace:
        err.stackTrace ??
            StackTrace.current,

        reason:
        "Unknown Dio Error : $path",

        fatal: false,

      );


    }



    super.onError(
      err,
      handler,
    );

  }


}