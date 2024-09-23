import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_doctor_sql_usecase%20.dart';
import 'package:equatable/equatable.dart';
part 'doctors_event.dart';
part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
  AllDoctorsSqlUsecase allDoctorsqlUsecase;
      List<DoctorModel> doctor=[];
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
                  doctor=data;
              emit(AllDoctorState(data));
          
            }

        );
      }     if (event is SearchDocEvent) {
        List<DoctorModel> doctorlist ;

        doctorlist=doctor.where((value) {
          if (value.title.contains(event.contant)) {
          return true;
          }  if (value.address.contains(event.contant)) {
          return true;
          } 
            if (value.placeTitle.contains(event.contant)) {
          return true;
          }
              if (value.spTitle.contains(event.contant)) {
          return true;
          }
           
          return false;
        }).toList();
          
        emit(AllDoctorState(doctorlist));
      }
      
    });
  }
}
