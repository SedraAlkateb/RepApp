import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase%20.dart';
import 'package:equatable/equatable.dart';

part 'hospitals_event.dart';
part 'hospitals_state.dart';



class HospitalsBloc extends Bloc<HospitalsEvent, HospitalsState> {
  AlHospitalsUsecase allhospital;
  HospitalsBloc(
    this.allDoctorUsecase
  ) : super(DoctorsInitial()) {
    on<DoctorsEvent>((event, emit)async {
 if(event is AllDoctorEvent){
        emit(AllDoctorLoadingState());
        (
            await allDoctorUsecase.execute(event.id)).fold(
      (failure)  {
      emit(AllDoctorErrorState(failure: failure));
      },
      (data)  async{
      emit(AllDoctorState(data));
      }

      );
    }
    });
  }
}
