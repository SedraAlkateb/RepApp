import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_pharmacy_sql_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'pharmacy_event.dart';
part 'pharmacy_state.dart';

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  AllPharmacySqlUsecase allPharmacyUsecase;
  List<PharmacyModel> Pharmacy=[];
  PharmacyBloc(this.allPharmacyUsecase) : super(PharmacyInitial()) {
    on<PharmacyEvent>((event, emit) async{
      if(event is AllPharmacyEvent){
    //    emit(AllPharmacyLoadingState());
        (
            await allPharmacyUsecase.execute()).fold(
      (failure)  {
      emit(AllPharmacyErrorState(failure: failure));
      },
      (data)  async{
         Pharmacy=data;
      emit(AllPharmacyState(data));
      }

      );
    }
      else if (event is SearchphEvent) {
        List<PharmacyModel> PharmacyModelList ;
        String search = normalizeText(event.contant);
       PharmacyModelList=Pharmacy.where((value) {
          if (normalizeText(value.title).contains(search)) {
          return true;
          }  if (normalizeText(value.address).contains(search)) {
          return true;
          }
          return false;
        }).toList();

        emit(AllPharmacyState(PharmacyModelList));
      }
    });
  }
}
