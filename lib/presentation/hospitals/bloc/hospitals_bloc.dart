import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase%20.dart';
import 'package:equatable/equatable.dart';

part 'hospitals_event.dart';
part 'hospitals_state.dart';



class HospitalsBloc extends Bloc<HospitalsEvent, HospitalsState> {
  AllHospitalUsecase allHospitalUsecase;
  HospitalsBloc(
    this.allHospitalUsecase
  ) : super(HospitalsInitial()) {
    on<HospitalsEvent>((event, emit)async {
 if(event is AllHospitalEvent){
        emit(AllHospitalLoadingState());
        (
            await allHospitalUsecase.execute(event.id)).fold(
      (failure)  {
      emit(AllHospitalErrorState(failure: failure));
      },
      (data)  async{
      emit(AllHospitalsState(data));
      }

      );
    }
    });
  }
}
