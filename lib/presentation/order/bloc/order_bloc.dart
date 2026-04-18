import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/data/responses/responses.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_brands_sql_usecase.dart';
import 'package:domina_app/domain/usecase/pharmacy_order_usecase%20.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PharmacyOrderUsecase pharmacyOrderUsecase;
  final AllBrandsSqlUsecase allBrandsSqlUsecase;

  OrderBloc(this.pharmacyOrderUsecase, this.allBrandsSqlUsecase)
      : super(OrderInitial()) {

    // 1. معالجة إرسال الطلبية النهائية
    on<PharmacyOrderEvent>((event, emit) async {
      emit(PharmacyOrderLoadingState());
      final result = await pharmacyOrderUsecase.execute(event.order);
      result.fold(
            (failure) => emit(PharmacyOrderErrorState(failure: failure)),
            (data) => emit(PharmacyOrderState(data)),
      );
    });
    // 2. معالجة جلب البراندات عند فتح الصفحة
    on<BrandOrderEvent>((event, emit) async {
      final result = await allBrandsSqlUsecase.execute();
      result.fold(
            (failure) => emit(BrandOrderErrorState(failure: failure)),
            (data) => emit(BrandOrderState(data, selectedItems: const [])),
      );
    });

    // 3. معالجة إضافة عنصر للقائمة (محلياً)
    on<AddItemToOrderEvent>((event, emit) {
      if (state is BrandOrderState) {
        final currentState = state as BrandOrderState;

        // إنشاء نسخة جديدة من القائمة وإضافة العنصر
        // ملاحظة: يمكنك هنا إضافة منطق للتحقق إذا كان المنتج مضافاً مسبقاً لزيادة الكمية فقط
        final List<OrderDetails> updatedList = List.from(currentState.selectedItems)
          ..add(event.item);

        emit(BrandOrderState(currentState.brands, selectedItems: updatedList));
      }
    });

    // 4. معالجة حذف عنصر من القائمة (محلياً)
    on<RemoveItemFromOrderEvent>((event, emit) {
      if (state is BrandOrderState) {
        final currentState = state as BrandOrderState;

        final List<OrderDetails> updatedList = List.from(currentState.selectedItems)
          ..removeAt(event.index);

        emit(BrandOrderState(currentState.brands, selectedItems: updatedList));
      }
    });
  }
}