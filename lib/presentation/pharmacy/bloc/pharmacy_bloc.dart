import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_pharmacy_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'pharmacy_event.dart';
part 'pharmacy_state.dart';

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  AllPharmacyUsecase allPharmacyUsecase;
  PharmacyBloc(this.allPharmacyUsecase) : super(PharmacyInitial()) {
    on<PharmacyEvent>((event, emit) async{
      if(event is AllPharmacyEvent){
        emit(AllPharmacyLoadingState());
        (
            await allPharmacyUsecase.execute(event.id)).fold(
      (failure)  {
      emit(AllPharmacyErrorState(failure: failure));
      },
      (data)  async{
      emit(AllPharmacyState(data));
      }

      );
    }
    });
  }
}
