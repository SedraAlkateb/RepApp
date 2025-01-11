part of 'async_in_bloc.dart';

@immutable
sealed class AsyncInState extends Equatable {}

final class AsyncInInitial extends AsyncInState {
  @override
  List<Object?> get props => [];
}


final class SyncData1LoadingState extends AsyncInState {
  @override
  SyncData1LoadingState();
  @override
  List<Object?> get props =>[];
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

final class EditStatusState extends AsyncInState {
  EditStatusState();
  @override
  List<Object?> get props =>[];
}
final class EditStatusSErrorState extends AsyncInState {
  final Failure failure;
  EditStatusSErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

final class UpdateFlagState extends AsyncInState {
  UpdateFlagState();
  @override
  List<Object?> get props =>[];
}
final class UpdateFlagErrorState extends AsyncInState {
  final Failure failure;
  UpdateFlagErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

class GetState extends AsyncInState{

  @override
  List<Object?> get props => [];

}
