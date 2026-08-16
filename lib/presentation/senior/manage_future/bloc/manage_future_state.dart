part of 'manage_future_bloc.dart';

@immutable
sealed class ManageFutureState extends Equatable {}

final class ManageFutureInitial extends ManageFutureState {
  @override
  List<Object?> get props => [];
}

final class AllSeniorRepState extends ManageFutureState {

  final List<AllRepresentativeFuture> representatives;
  AllSeniorRepState(this.representatives);
  @override
  List<Object?> get props => [representatives];
}

final class AllSeniorRepErrorState extends ManageFutureState {
  final Failure failure;

  AllSeniorRepErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class AllSeniorRepLoadingState extends ManageFutureState {
  @override
  List<Object?> get props => [];
}

final class ChangPlanStatusState extends ManageFutureState {
  final List<AllRepresentativeFuture> representatives;
  ChangPlanStatusState(this.representatives);
  @override
  List<Object?> get props => [representatives];
}

final class ChangPlanStatusErrorState extends ManageFutureState {
  final Failure failure;
  ChangPlanStatusErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class ChangPlanStatusLoadingState extends ManageFutureState {
  @override
  List<Object?> get props => [];
}

final class GetPlaceStatusState extends ManageFutureState {
  final List<PlaceModel> representatives;
  GetPlaceStatusState(this.representatives);
  @override
  List<Object?> get props => [representatives];
}

final class GetPlaceStatusErrorState extends ManageFutureState {
  final Failure failure;
  GetPlaceStatusErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}

final class GetPlaceStatusLoadingState extends ManageFutureState {
  @override
  List<Object?> get props => [];
}
