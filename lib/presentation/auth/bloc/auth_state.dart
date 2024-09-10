part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable{}

final class AuthInitial extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class FinishedAsync extends AuthState{

  @override
  List<Object?> get props => throw UnimplementedError();
}
class ErrorAsync extends AuthState{


  @override
  List<Object?> get props => throw UnimplementedError();

}
final class InsertAllBrandState extends AuthState {

  InsertAllBrandState();
  @override
  List<Object?> get props =>[];
}
final class InsertAllBrandErrorState extends AuthState {
  final Failure failure;
  InsertAllBrandErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class InsertAllBrandLoadingState extends AuthState {
  @override
  InsertAllBrandLoadingState();
  @override
  List<Object?> get props =>[];
}


final class LoginState extends AuthState {
  final LoginModel loginModel;
  LoginState(this.loginModel);
  @override
  List<Object?> get props =>[loginModel];
}
final class LoginErrorState extends AuthState {
  final Failure failure;
  LoginErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class LoginLoadingState extends AuthState {
  @override
  LoginLoadingState();
  @override
  List<Object?> get props =>[];
}

final class InsertLoginState extends AuthState {
  InsertLoginState();
  @override
  List<Object?> get props =>[];
}
final class InsertLoginErrorState extends AuthState {
  final Failure failure;
  InsertLoginErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}