part of 'order_bloc.dart';

@immutable
sealed class OrderEvent extends Equatable {}

// إرسال الطلبية النهائية
class PharmacyOrderEvent extends OrderEvent {
  final PharmacyOrderRequestBody order;
  PharmacyOrderEvent(this.order);

  @override
  List<Object?> get props => [order];
}

// جلب قائمة الأدوية (Brands) عند فتح الصفحة
class BrandOrderEvent extends OrderEvent {
  @override
  List<Object?> get props => [];
}

// إضافة عنصر واحد للطلبية
class AddItemToOrderEvent extends OrderEvent {
  final OrderDetails item; // صنف واحد فقط

  AddItemToOrderEvent(this.item);

  @override
  List<Object?> get props => [item];
}

// حذف عنصر من القائمة عبر الـ index
class RemoveItemFromOrderEvent extends OrderEvent {
  final int index;

  RemoveItemFromOrderEvent(this.index);

  @override
  List<Object?> get props => [index];
}