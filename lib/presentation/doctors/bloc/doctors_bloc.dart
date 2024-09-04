import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase%20.dart';
import 'package:equatable/equatable.dart';
part 'doctors_event.dart';
part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
  AllDoctorUsecase allDoctorUsecase;
  DoctorsBloc(
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
