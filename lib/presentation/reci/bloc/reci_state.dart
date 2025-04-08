part of 'reci_bloc.dart';

@immutable
sealed class ReciState extends Equatable {}

final class ReciInitial extends ReciState {
  @override
  List<Object?> get props => [];
}

final class AllReciState extends ReciState {
  final List<ReciModel> reci;
  AllReciState(this.reci);
  @override
  List<Object?> get props =>[reci];
}
final class AllReciErrorState extends ReciState {
  final Failure failure;
  AllReciErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllReciLoadingState extends ReciState {
  @override
  AllReciLoadingState();
  @override
  List<Object?> get props =>[];
}
