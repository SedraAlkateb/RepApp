part of 'report_inventory_bloc.dart';

@immutable
sealed class ReportInventoryEvent extends Equatable {}
class SenSearchInventoryEvent extends ReportInventoryEvent{
  final String contant;
  SenSearchInventoryEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}
class SenAllInventoryEvent extends ReportInventoryEvent{
  final  int id;
  final int planId;
  @override
  SenAllInventoryEvent(this.id,this.planId);
  List<Object?> get props => [id];
}
