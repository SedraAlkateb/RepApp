part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable{

}
class AsyncData extends AuthEvent{
  @override

  List<Object?> get props => throw UnimplementedError();


}
