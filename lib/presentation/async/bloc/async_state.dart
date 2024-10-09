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
  @override
  SyncDataLoadingState();
  @override
  List<Object?> get props =>[];
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