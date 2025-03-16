part of 'future_rep_bloc.dart';

@immutable
sealed class FutureRepState extends Equatable {}

final class FutureRepInitial extends FutureRepState {
  @override
  List<Object?> get props => [];
}

final class FutureSpRepState extends FutureRepState {
  final List<SpecDModel> Specs;
  FutureSpRepState(this.Specs);
  @override
  List<Object?> get props => [Specs];
}

final class FuturePlanBrandState extends FutureRepState {
  final List<PlanBrandModel> planbrand;
  FuturePlanBrandState(this.planbrand);
  @override
  List<Object?> get props => [planbrand];
}
final class FutureChangePlanBrandTypeState extends FutureRepState {
  final List<PlanBrandModel> planbrand;
  FutureChangePlanBrandTypeState(this.planbrand);
  @override
  List<Object?> get props => [planbrand];
}
final class FutureSpRepErrorState extends FutureRepState {
  final Failure failure;
  FutureSpRepErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class FutureChangePlanBrandTypeErrorState extends FutureRepState {
  final Failure failure;
  FutureChangePlanBrandTypeErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class FutureSpRepLoadingState extends FutureRepState {
  @override
  FutureSpRepLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureChangePlanBrandTypeLoadingState extends FutureRepState {
  @override
  FutureChangePlanBrandTypeLoadingState();
  @override
  List<Object?> get props => [];
}