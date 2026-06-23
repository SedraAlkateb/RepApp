part of 'finished_plan_bloc.dart';

@immutable
abstract class FinishedPlanEvent extends Equatable {
  const FinishedPlanEvent();

  @override
  List<Object> get props => [];
}

class GetFinishedPlansEvent extends FinishedPlanEvent {
  final int cityId;
  GetFinishedPlansEvent({required this.cityId});
}

class GetPlanRepsEvent extends FinishedPlanEvent {
  final int planId;
  GetPlanRepsEvent({required this.planId});
}

class GetAllCityEventForPlan extends FinishedPlanEvent {
  const GetAllCityEventForPlan();

  @override
  List<Object> get props => [];
}
