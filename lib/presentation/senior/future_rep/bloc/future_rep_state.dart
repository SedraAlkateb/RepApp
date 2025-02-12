part of 'future_rep_bloc.dart';

@immutable
sealed class FutureRepState extends Equatable{}

final class FutureRepInitial extends FutureRepState {
  @override
  List<Object?> get props => [];
}
final class FutureSpRepState extends FutureRepState {
  final List<SpecDModel> Specs;
  FutureSpRepState(this.Specs);
  @override
  List<Object?> get props =>[Specs];
}
final class FutureSpRepErrorState extends FutureRepState {
  final Failure failure;
  FutureSpRepErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}

final class FutureSpRepLoadingState extends FutureRepState {
  @override
  FutureSpRepLoadingState();
  @override
  List<Object?> get props =>[];
}