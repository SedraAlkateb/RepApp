part of 'order_bloc.dart';

@immutable
sealed class OrderEvent extends Equatable{}
 class PharmacyOrderEvent extends OrderEvent{
final  PharmacyOrderRequestBody order;
  PharmacyOrderEvent(this.order);

   @override
  List<Object?> get props => [order];
}
class BrandOrderEvent extends OrderEvent{

  @override
  List<Object?> get props => [];
}
class AddItemToOrderEvent extends OrderEvent {
  final List<OrderDetails> item;
  final List<BrandModel> brands;

  AddItemToOrderEvent(this.item,this.brands);

  @override
  List<Object?> get props => [item];
}
class RemoveItemFromOrderEvent extends OrderEvent {
  final int index;
  final List<OrderDetails> item;

  RemoveItemFromOrderEvent(this.index,this.item);

  @override
  List<Object?> get props => [index];
}