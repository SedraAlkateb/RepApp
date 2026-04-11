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
  PharmacyOrderUsecase pharmacyOrderUsecase;
  AllBrandsSqlUsecase allBrandsSqlUsecase;
  OrderBloc(this.pharmacyOrderUsecase, this.allBrandsSqlUsecase)
      : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async{
      if (event is PharmacyOrderEvent) {
        emit(PharmacyOrderLoadingState());
      await  pharmacyOrderUsecase.execute(event.order).then((value) {
          value.fold((failure) {
            emit(PharmacyOrderErrorState(failure: failure));
          }, (data) async {
            emit(PharmacyOrderState(data));
          });
        });
      } else if (event is BrandOrderEvent) {
        emit(BrandOrderLoadingState());
        await    allBrandsSqlUsecase.execute().then((value) {
          value.fold((failure) {
            emit(BrandOrderErrorState(failure: failure));
          }, (data) async {
            emit(BrandOrderState(data));
          });
        });
      }
    });
  }
}
