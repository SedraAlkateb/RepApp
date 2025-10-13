import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_doctor_sp_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_hospital_sp_sql_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_sql_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'specialization_event.dart';
part 'specialization_state.dart';

class SpecializationBloc
    extends Bloc<SpecializationEvent, SpecializationState> {
  AllSpecsSqlUsecase allSpeUsecase;
  AllDoctorSpSqlUsecase allDoctorSpSqlUsecase;
  AllHospitalSpSqlUsecase allHospitalsSpSqlUsecase;
  List<SpecDModel> specialization = [];
  int current = 0;

  SpecializationBloc(this.allSpeUsecase, this.allDoctorSpSqlUsecase,
      this.allHospitalsSpSqlUsecase)
      : super(SpecializationInitial()) {
    on<SpecializationEvent>((event, emit) async {
      if (event is SpecEvent) {
        //       emit(AllSpecLoadingState());
        (await allSpeUsecase.execute()).fold((failure) {
          emit(AllSpecErrorState(failure: failure));
        }, (data) async {
          specialization = data;
          emit(AllSpecState(data));
        });
      } else if (event is SearchSpecEvent) {
        List<SpecDModel> spec;
        String search = normalizeText(event.contan);
        spec = specialization.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }

          return false;
        }).toList();

        emit(AllSpecState(spec));
      } else if (event is DoctorSpEvent) {
        (await allDoctorSpSqlUsecase.execute(event.sp)).fold((failure) {
          emit(AllSpecDoctorErrorState(failure: failure));
        }, (data) async {
          emit(AllDoctorSpState(data));
        });
      } else if (event is HospitalSpEvent) {
        (await allHospitalsSpSqlUsecase.execute(event.sp)).fold((failure) {
          emit(AllSpecHospitalErrorState(failure: failure));
        }, (data) async {
          emit(AllHospitalSpState(data));
        });
      }
    });
  }
}
