import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_doctor_sql_usecase%20.dart';
import 'package:equatable/equatable.dart';
part 'doctors_event.dart';
part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
  AllDoctorsSqlUsecase allDoctorsqlUsecase;
  DoctorsBloc(
      this.allDoctorsqlUsecase
      ) : super(DoctorsInitial()) {
    on<DoctorsEvent>((event, emit)async {
      if(event is AllDoctorEvent){

        (
            await allDoctorsqlUsecase.execute()).fold(
                (failure)  {
              emit(AllDoctorErrorState(failure: failure));
              print(failure.massage);
            },
                (data)  async{
              emit(AllDoctorState(data));
              print("object");
            }

        );
      }
    });
  }
}
