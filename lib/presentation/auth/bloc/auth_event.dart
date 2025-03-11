part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable{

}

class LoginEvent extends AuthEvent{

  final String userName;
  final String password;
  LoginEvent(this.userName,this.password);
  @override

  List<Object?> get props => [];


}
class LoginInsertEvent extends AuthEvent{


  LoginInsertEvent();
  @override
  List<Object?> get props => [];


}
class DeleteDataEvent extends AuthEvent{

  @override
  List<Object?> get props => [];


}
class ShowPasswordEvent extends AuthEvent{
  final bool isObscured ;
  ShowPasswordEvent(this.isObscured);

  @override
  List<Object?> get props => [isObscured];
}