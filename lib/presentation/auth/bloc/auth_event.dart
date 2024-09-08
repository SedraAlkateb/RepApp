part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable{

}
class AsyncDataEvent extends AuthEvent{
  @override

  List<Object?> get props => throw UnimplementedError();


}

class LoginEvent extends AuthEvent{

  final String userName;
  final String password;
  LoginEvent(this.userName,this.password);
  @override

  List<Object?> get props => throw UnimplementedError();


}
class LoginInsertEvent extends AuthEvent{

  final LoginModel loginModel;
  LoginInsertEvent(this.loginModel);
  @override
  List<Object?> get props => [loginModel];


}
