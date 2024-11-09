part of 'async_bloc.dart';

@immutable
sealed class AsyncState extends Equatable{}

final class AsyncInitial extends AsyncState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
final class SyncDataState extends AsyncState {
  SyncDataState();
  @override
  List<Object?> get props =>[];
}
final class SyncDataErrorState extends AsyncState {
  final Failure failure;
  SyncDataErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class SyncDataLoadingState extends AsyncState {
  final int loading;
  SyncDataLoadingState(this.loading);
  @override
  List<Object?> get props =>[loading];
}
final class LoadingState extends AsyncState {
  final int loading;
  LoadingState(this.loading);
  @override
  List<Object?> get props =>[loading];
}
final class EditStatusDState extends AsyncState {
  EditStatusDState();
  @override
  List<Object?> get props =>[];
}
final class EditStatusDErrorState extends AsyncState {
  final Failure failure;
  EditStatusDErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

final class getDataSucState extends AsyncState {

  @override

  List<Object?> get props =>[];
}
///////////////
final class IsActiveState extends AsyncState {
  IsActiveState();
  @override
  List<Object?> get props =>[];
}
final class IsActiveErrorState extends AsyncState {
  final Failure failure;
  IsActiveErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}


final class UpdateIsActiveState extends AsyncState {
  UpdateIsActiveState();
  @override
  List<Object?> get props =>[];
}
final class UpdateIsActiveErrorState extends AsyncState {
  final Failure failure;
  UpdateIsActiveErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

final class DeleteAllState extends AsyncState {
  DeleteAllState();
  @override
  List<Object?> get props =>[];
}
final class DeleteAllErrorState extends AsyncState {
  final Failure failure;
  DeleteAllErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class DeleteAllLoadingState extends AsyncState {
  @override
  DeleteAllLoadingState();
  @override
  List<Object?> get props =>[];
}