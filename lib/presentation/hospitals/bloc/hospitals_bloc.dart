import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_hospital_sp_n_sql_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
part 'hospitals_event.dart';
part 'hospitals_state.dart';

class HospitalsBloc extends Bloc<HospitalsEvent, HospitalsState> {
  AllHospitalSpNSqlUsecase allHospitalSpNSqlUsecase;
  List<HospitalSpAllModel> hospital = [];
  HospitalsBloc(this.allHospitalSpNSqlUsecase) : super(HospitalsInitial()) {
    on<HospitalsEvent>((event, emit) async {
      if (event is AllHospitalEvent) {
        (await allHospitalSpNSqlUsecase.execute()).fold((failure) {
          emit(AllHospitalErrorState(failure: failure));
        }, (data) async {
          hospital = data;
          if (hospital.isNotEmpty) {
            emit(AllHospitalsState(data));
          } else {
            emit(AllHospitalEmptyState());
          }
        });
      } else if (event is SearchhosEvent) {
        List<HospitalSpAllModel> hospitallist;
        String search = normalizeText(event.contant);
        hospitallist = hospital.where((value) {
          if (normalizeText(value.title ?? "").contains(search)) {
            return true;
          }
          if (normalizeText(value.address ?? "").contains(search)) {
            return true;
          }
          if (normalizeText(value.placeTitle ?? "").contains(search)) {
            return true;
          }

          return false;
        }).toList();

        emit(AllHospitalsState(hospitallist));
      }
    });
  }
}
