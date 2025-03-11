part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable{}

final class AuthInitial extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class FinishedAsync extends AuthState{

  @override
  List<Object?> get props => [];
}
class ErrorAsync extends AuthState{


  @override
  List<Object?> get props => [];

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
 // final LoginModel loginModel;
//  LoginState(this.loginModel);
  @override
  List<Object?> get props =>[];
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
final class DeleteStateError extends AuthState {
  final Failure failure;
  DeleteStateError({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class DeleteState extends AuthState {

  @override

  List<Object?> get props =>[];
}

final class ShowPasswordState extends AuthState {
  final bool isObscured;
  ShowPasswordState({ required this.isObscured});

  @override
  List<Object?> get props => [isObscured];
}