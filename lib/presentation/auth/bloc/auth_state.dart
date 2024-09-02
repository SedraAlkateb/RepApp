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

final class SyncDataState extends AuthState {
  SyncDataState();
  @override
  List<Object?> get props =>[];
}
final class SyncDataErrorState extends AuthState {
  final Failure failure;
  SyncDataErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class SyncDataLoadingState extends AuthState {
  @override
  SyncDataLoadingState();
  @override
  List<Object?> get props =>[];
}