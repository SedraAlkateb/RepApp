part of 'active_plan_bloc.dart';


@immutable
abstract class ActivePlanEvent extends Equatable {
}
class GetActivePlanEvent extends ActivePlanEvent{
 final int index;
 GetActivePlanEvent(this.index);
 @override
 List<Object?> get props => [];

}
class SearchActivePlanEvent extends ActivePlanEvent{
 final String search;
 SearchActivePlanEvent(this.search);
 @override
 List<Object?> get props => [search];

}