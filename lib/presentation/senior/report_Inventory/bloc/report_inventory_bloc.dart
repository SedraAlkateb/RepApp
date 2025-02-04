import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/inventory_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'report_inventory_event.dart';
part 'report_inventory_state.dart';

class ReportInventoryBloc extends Bloc<ReportInventoryEvent, ReportInventoryState> {
  List<InventoryModel> inventoryModel = [];
  AllInventoryUsecase allInventoryUsecase ;
  ReportInventoryBloc(this.allInventoryUsecase) : super(ReportInventoryInitial()) {
    on<ReportInventoryEvent>((event, emit) async {
      if (event is SenSearchInventoryEvent) {
        List<InventoryModel> inventoryNote;
        String search = normalizeText(event.contant);
        inventoryNote = inventoryModel.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }


          return false;
        }).toList();
        emit(SenAllInventoryState(inventoryModel));
      }
      else if (event is SenAllInventoryEvent) {
        emit(SenAllInventoryLoadingState());
        (await allInventoryUsecase.execute(event.id)).fold((failure) async{
      emit(SenAllInventoryErrorState(failure: failure));
      }, (data) async {
          inventoryModel=data;
      if(data.isEmpty){
      emit(SenAllInventoryEmptyState());
      }else{
      emit(SenAllInventoryState(data));
      }

      });
      }

    });
  }
}
