part of 'async_in_bloc.dart';

@immutable
sealed class AsyncInState extends Equatable {}

final class AsyncInInitial extends AsyncInState {
  @override
  List<Object?> get props => [];
}



final class SyncData1State extends AsyncInState {
  SyncData1State();
  @override
  List<Object?> get props =>[];
}
final class SyncData1ErrorState extends AsyncInState {
  final Failure failure;
  SyncData1ErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class SyncData1LoadingState extends AsyncInState {
  @override
  SyncData1LoadingState();
  @override
  List<Object?> get props =>[];
}
