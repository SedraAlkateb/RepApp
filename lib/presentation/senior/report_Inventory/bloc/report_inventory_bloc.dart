import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/inventory_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'report_inventory_event.dart';
part 'report_inventory_state.dart';

class ReportInventoryBloc
    extends Bloc<ReportInventoryEvent, ReportInventoryState> {
  List<InventoryModel> inventoryModel = [];
  AllInventoryUsecase allInventoryUsecase;
  ReportInventoryBloc(this.allInventoryUsecase)
      : super(ReportInventoryInitial()) {
    on<SenSearchInventoryEvent>((event, emit) async {
      List<InventoryModel> inventoryNote = [];
      String search = normalizeText(event.contant);
      inventoryNote = inventoryModel.where((value) {
        if (normalizeText(value.title).contains(search)) {
          return true;
        }
        if (normalizeText(value.type.name).contains(search)) {
          return true;
        }
        return false;
      }).toList();
      emit(SenAllInventoryState(inventoryNote));
    });

    on<SenAllInventoryEvent>((event, emit) async {
      emit(SenAllInventoryLoadingState());
      (await allInventoryUsecase.execute(event.id, event.planId)).fold(
          (failure) async {
        emit(SenAllInventoryErrorState(failure: failure, planId: event.planId));
      }, (data) async {
        data.sort((b, a) => b.type.i.compareTo(a.type.i));
        inventoryModel = data;
        if (data.isEmpty) {
          emit(SenAllInventoryEmptyState());
        } else {
          emit(SenAllInventoryState(data));
        }
      });
    });
  }
}
