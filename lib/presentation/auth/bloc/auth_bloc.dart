import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/login_sql_usecase.dart';
import 'package:domina_app/domain/usecase/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUsecase loginUsecase;
  LoginSqlUsecase loginSqlUsecase;
  //DeleteSqlUsecase deleteSqlUsecase;
  LoginModel? loginModel;
  AuthBloc(this.loginSqlUsecase, this.loginUsecase
   //   , this.deleteSqlUsecase
      )
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {

        emit(LoginLoadingState());
        (await loginUsecase
                .execute(LoginRequest(event.userName, event.password)))
            .fold((failure) {
          emit(LoginErrorState(failure: failure));
        },
                (data) async {
              print(data.repType);
              print("data.repType");
          loginModel = data;
          UserInfo.repId = loginModel!.repId;
          UserInfo.otherPlanId = loginModel!.otherPlanId;
          UserInfo.activePlanId = loginModel!.activePlanId;
          UserInfo.otherstatus = loginModel!.otherStatus;
          UserInfo.percentage = loginModel!.percentage;
          UserInfo.recipesCount = loginModel!.recipesCount;
          UserInfo.token = loginModel!.token;
          UserInfo.name = loginModel!.name;
          UserInfo.isLogging = 1;
          UserInfo.startDate=data.startDate;
          UserInfo.endDate=data.endDate;
          UserInfo.otherStartDate=data.otherStartDate;
          UserInfo.otherEndDate=data.otherEndDate;
          loginModel?.flag1=0;
          UserInfo.flag1 =0;
          UserInfo.repType=data.repType;
          emit(LoginState());
        });
      } else if (event is LoginInsertEvent) {
        (await loginSqlUsecase.execute(loginModel!)).fold((failure) {
          emit(InsertLoginErrorState(failure: failure));
        }, (data) async {
          print("object");
          emit(InsertLoginState());
        });
      } /*
      else if (event is DeleteDataEvent) {
        (await deleteSqlUsecase.execute()).fold((failure) {
          emit(DeleteStateError(failure: failure));
          return false;
        }, (data) async {
          emit(DeleteState());
        });
      }
      */
    });
  }
}
