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

final class DeleteBaseState extends AsyncInState {
  DeleteBaseState();
  @override
  List<Object?> get props =>[];
}
final class DeleteBaseErrorState extends AsyncInState {
  final Failure failure;
  DeleteBaseErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class DeleteBaseLoadingState extends AsyncInState {
  @override
  DeleteBaseLoadingState();
  @override
  List<Object?> get props =>[];
}

final class DeleteAllState extends AsyncInState {
  DeleteAllState();
  @override
  List<Object?> get props =>[];
}
final class DeleteAllErrorState extends AsyncInState {
  final Failure failure;
  DeleteAllErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class DeleteAllLoadingState extends AsyncInState {
  @override
  DeleteAllLoadingState();
  @override
  List<Object?> get props =>[];
}