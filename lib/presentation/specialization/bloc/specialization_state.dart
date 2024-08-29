part of 'specialization_bloc.dart';

@immutable
sealed class SpecializationState extends Equatable{}

final class SpecializationInitial extends SpecializationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class AllSpecState extends SpecializationState {
  final List<SpecModel> Specs;
  AllSpecState(this.Specs);
  @override
  List<Object?> get props =>[Specs];
}
final class AllSpecErrorState extends SpecializationState {
  final Failure failure;
  AllSpecErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllSpecLoadingState extends SpecializationState {
  @override
  AllSpecLoadingState();
  @override
  List<Object?> get props =>[];
}