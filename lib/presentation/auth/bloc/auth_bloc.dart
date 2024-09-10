import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/data/network/requests/requsets.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/delete_sql_usecase.dart';
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

  AuthBloc(
      this.loginSqlUsecase,
      this.loginUsecase,
      )
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if(event is LoginEvent){
        emit(LoginLoadingState());
        (await loginUsecase.execute(LoginRequest(event.userName, event.password))).
        fold((failure) {
          emit(LoginErrorState(failure: failure));
        }, (data) async {
          LoginModel loginModel=data;
          print("object1");
          emit(LoginState(loginModel));
        });
      }
      if(event is LoginInsertEvent){
        (await loginSqlUsecase.execute(event.loginModel)).fold((failure) {
          emit(InsertLoginErrorState(failure: failure));
        }, (data) async {
          print("object");
          emit(InsertLoginState());
        });

      }
    });
  }
}
