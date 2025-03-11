part of 'report_inventory_bloc.dart';

@immutable
sealed class ReportInventoryState extends Equatable{}

final class ReportInventoryInitial extends ReportInventoryState {
  @override
  List<Object?> get props =>[];}
final class  SenAllInventoryErrorState extends ReportInventoryState {
  final Failure failure;
  SenAllInventoryErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  SenAllInventoryLoadingState extends ReportInventoryState {
  SenAllInventoryLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  SenAllInventoryEmptyState extends ReportInventoryState {
  SenAllInventoryEmptyState();
  @override
  List<Object?> get props =>[];
}

final class SenAllInventoryState extends ReportInventoryState {
  final List<InventoryModel> inventoryModel;
  SenAllInventoryState(this.inventoryModel);
  @override
  List<Object?> get props =>[inventoryModel];
}