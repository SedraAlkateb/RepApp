import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_hospitals_sql_usecase%20.dart';
import 'package:equatable/equatable.dart';
part 'hospitals_event.dart';
part 'hospitals_state.dart';

class HospitalsBloc extends Bloc<HospitalsEvent, HospitalsState> {
  AllHospitalsSqlUsecase allHospitalsqlUsecase;
  List<HospitalModel> hospital = [];
  HospitalsBloc(this.allHospitalsqlUsecase) : super(HospitalsInitial()) {
    on<HospitalsEvent>((event, emit) async {
      if (event is AllHospitalEvent) {
        (await allHospitalsqlUsecase.execute()).fold((failure) {
          emit(AllHospitalErrorState(failure: failure));
        }, (data) async {hospital=data;
          emit(AllHospitalsState(data));
        });
      }
      else     if (event is SearchhosEvent) {
        List<HospitalModel> hospitallist;

        hospitallist = hospital.where((value) {
          if (value.title.contains(event.contant)) {
            return true;
          }
          if (value.address.contains(event.contant)) {
            return true;
          }
          if (value.placeTitle.contains(event.contant)) {
            return true;
          }

          return false;
        }).toList();

        emit(AllHospitalsState(hospitallist));
      }
    });
  }
}
