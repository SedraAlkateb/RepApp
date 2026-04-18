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
final class FutureRepPlanBrandSpState extends FutureRepState {
  final List<PlanBrandSp> planBrandSp;
  FutureRepPlanBrandSpState(this.planBrandSp);
  @override
  List<Object?> get props => [planBrandSp];
}
final class FutureSpRepLoadingState extends FutureRepState {
  @override
  FutureSpRepLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureSpRepErrorState extends FutureRepState {
  final Failure failure;
  FutureSpRepErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class FutureRepPlanBrandSpErrorState extends FutureRepState {
  final Failure failure;
  FutureRepPlanBrandSpErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class FutureRepPlanBrandSpLoadingState extends FutureRepState {
  @override
  FutureRepPlanBrandSpLoadingState();
  @override
  List<Object?> get props => [];
}
final class FutureRepPlanBrandSpEmptyState extends FutureRepState {
  final AllPlanBrandSp planBrandSp;
  FutureRepPlanBrandSpEmptyState(this.planBrandSp);
  @override
  List<Object?> get props =>[planBrandSp];
}

final class SumErrorState extends FutureRepState {
  final Failure failure;
  SumErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class UpdateAmountLoadingState extends FutureRepState {
  @override
  UpdateAmountLoadingState();
  @override
  List<Object?> get props => [];
}
final class UpdateAmountState extends FutureRepState {
  UpdateAmountState();
  @override
  List<Object?> get props => [];
}
final class EditeStatusLoadingState extends FutureRepState {
  @override
  EditeStatusLoadingState();
  @override
  List<Object?> get props => [];
}
final class EditeStatusFailureState extends FutureRepState {
  final Failure failure;
  EditeStatusFailureState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
final class EditeStatusState extends FutureRepState {
  @override
  EditeStatusState();
  @override
  List<Object?> get props => [];
}