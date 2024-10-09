part of 'brand_plan_bloc.dart';

@immutable
abstract class BrandPlanEvent extends Equatable {

}
class AllBrandPlanEvent extends BrandPlanEvent{
 final int index;
  AllBrandPlanEvent(this.index);
  @override
  List<Object?> get props => [];

}
