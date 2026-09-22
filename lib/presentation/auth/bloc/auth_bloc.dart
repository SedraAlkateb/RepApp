import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domina_app/analytics/analytics_service.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final LoginSqlUsecase loginSqlUsecase;
  final AnalyticsService analyticsService;
  LoginModel? loginModel;
  AuthBloc(this.loginSqlUsecase, this.loginUsecase, this.analyticsService)
      : super(AuthInitial()) {
    on<ShowPasswordEvent>((event, emit) {
      emit(ShowPasswordState(isObscured: event.isObscured));
    });

    on<LoginEvent>((event, emit) async {
      emit(LoginLoadingState());

      final result = await loginUsecase.execute(
        LoginRequest(
          event.userName,
          event.password,
        ),
      );

      await result.fold(
        (failure) async {
          emit(
            LoginErrorState(
              failure: failure,
            ),
          );
        },
        (data) async {
          loginModel = data;

          UserInfo.repId = loginModel!.repId;

          UserInfo.otherPlanId = loginModel!.otherPlanId;

          UserInfo.activePlanId = loginModel!.activePlanId ?? -5;

          UserInfo.otherstatus = loginModel!.otherStatus;

          UserInfo.percentage = loginModel!.percentage;

          UserInfo.recipesCount = loginModel!.recipesCount;

          UserInfo.token = loginModel!.token;

          UserInfo.name = loginModel!.name;
          UserInfo.groupTitle = loginModel!.groupTitle;

          UserInfo.cityId = loginModel!.cityId;

          UserInfo.cityTitle = loginModel!.cityTitle;
          if (loginModel!.repType.i == 4 || loginModel!.repType.i == 5) {
            UserInfo.isLogging = 2;
          } else {
            UserInfo.isLogging = 1;
          }

          UserInfo.startDate = data.startDate;

          UserInfo.endDate = data.endDate;
          UserInfo.totDoc = data.totDoc;

          UserInfo.totHos = data.totHos;
          UserInfo.totalReci = loginModel!.totalReci;
          UserInfo.remainReci = loginModel!.remainReci;
          UserInfo.usedReci = loginModel!.usedReci;
          UserInfo.otherStartDate = data.otherStartDate;

          UserInfo.otherEndDate = data.otherEndDate;

          loginModel?.flag1 = 0;

          UserInfo.flag1 = 0;

          UserInfo.repType = data.repType;

          UserInfo.initializeUserPlan();

          emit(LoginState());
        },
      );
    });

    on<LoginInsertEvent>((event, emit) async {
      (await loginSqlUsecase.execute(loginModel!)).fold((failure) {
        emit(InsertLoginErrorState(failure: failure));
      }, (data) async {
        emit(InsertLoginState());
      });
    });
  }

  // ============================================================
  // Analytics: مراقبة الحالة بس (onChange) بدون أي تعديل على منطق
  // تسجيل الدخول نفسه، وبدون await حتى لا نؤخر أي شيء (fire-and-forget).
  // ============================================================
  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);

    final next = change.nextState;

    if (next is LoginState) {
      unawaited(
        analyticsService.logUserLogin(
          userId: UserInfo.repId.toString(),
          loginMethod: 'password',
        ),
      );
    } else if (next is LoginErrorState) {
      unawaited(
        analyticsService.logEvent(
          name: 'login_failed',
          parameters: {
            'error_code': next.failure.code.toString(),
          },
        ),
      );
    }
  }
}
