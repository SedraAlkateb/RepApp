part of 'delete_bloc.dart';

@immutable
abstract class DeleteState extends Equatable{}

final class DeleteInitial extends DeleteState {
  @override
  List<Object?> get props => [];
}
final class DeleteBaseState extends DeleteState {
  DeleteBaseState();
  @override
  List<Object?> get props =>[];
}
final class DeleteBaseErrorState extends DeleteState {
  final Failure failure;
  DeleteBaseErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class DeleteBaseLoadingState extends DeleteState {
  @override
  DeleteBaseLoadingState();
  @override
  List<Object?> get props =>[];
}

final class DeleteAllState extends DeleteState {
  DeleteAllState();
  @override
  List<Object?> get props =>[];
}
final class DeleteAllErrorState extends DeleteState {
  final Failure failure;
  DeleteAllErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

final class Edit1StatusState extends DeleteState {
  Edit1StatusState();
  @override
  List<Object?> get props =>[];
}
final class Edit1StatusSErrorState extends DeleteState {
  final Failure failure;
  Edit1StatusSErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

