part of 'plan_management_bloc.dart';

@immutable
abstract class PlanManagementEvent extends Equatable{

  const PlanManagementEvent();

  @override
  List<Object?> get props => [];
}
class RepPlanBrandSpEvent extends PlanManagementEvent {
  final RepSp rep;
  RepPlanBrandSpEvent(this.rep);
  @override
  List<Object?> get props => [rep];
}
// حدث تحديث الكمية في الذاكرة
class UpdateBrandQuantityEvent extends PlanManagementEvent {
  final int index;
  final int quantity;
   UpdateBrandQuantityEvent({required this.index, required this.quantity});

  @override
  List<Object?> get props => [index, quantity];
}

// حدث الموافقة والإرسال النهائي
class SubmitPlanEvent extends PlanManagementEvent {
   SubmitPlanEvent();
}