import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_doctor_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_hospial_usecase%20.dart';
import 'package:domina_app/domain/usecase/all_no_visit_doctor_usecase.dart';
import 'package:domina_app/domain/usecase/all_place_usecase.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_notes_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'senior_prof_event.dart';
part 'senior_prof_state.dart';

class SeniorProfBloc extends Bloc<SeniorProfEvent, SeniorProfState> {
  AllPlaceUsecase allPlaceUsecase;
  AllSpeUsecase allSpeUsecase;
  AllHospitalUsecase allHospitalUsecase;
  AllDoctorUsecase allDoctorUsecase;
  AllVisitNotesUsecase allVisitNotesUsecase;
  AllNoVisitDoctorUsecase allNoVisitDoctorUsecase;
  List<SpecDModel> specialization = [];
  List<HospitalModel> hospital = [];
  List<DoctorNoteModel> doctorNoteModel = [];
  List<NoVisitDocModel> noVisitDoc = [];

  List<DoctorModel> doctor = [];
  SeniorProfBloc(this.allPlaceUsecase, this.allSpeUsecase,
      this.allDoctorUsecase, this.allHospitalUsecase, this.allVisitNotesUsecase,this.allNoVisitDoctorUsecase)
      : super(SeniorProfInitial()) {
    on<SeniorProfEvent>((event, emit) async {
      if (event is SenAllPlaceEvent) {
        emit(SenAllPlaceLoadingState());
        (await allPlaceUsecase.execute(event.id)).fold((failure) {
          emit(SenAllPlaceErrorState(failure: failure));
        }, (data) async {
          emit(SenAllPlaceState(data));
        });
      }
      if (event is SenAllHospitalEvent) {
        emit(SenAllHospitalLoadingState());
        (await allHospitalUsecase.execute(event.id)).fold((failure) {
          emit(SenAllHospitalErrorState(failure: failure));
        }, (data) async {
          emit(SenAllHospitalsState(data));
        });
      }
      if (event is SenAllSpecEvent) {
        emit(SenAllSpecLoadingState());
        (await allSpeUsecase.execute(event.id)).fold((failure) {
          emit(SenAllSpecErrorState(failure: failure));
        }, (data) async {
          specialization = data;
          emit(SenAllSpecState(data));
        });
      } else if (event is SenSearchSpecEvent) {
        List<SpecDModel> spec;
        String search = normalizeText(event.contant);
        spec = specialization.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(SenAllSpecState(spec));
      } else if (event is SenSearchHospEvent) {
        List<HospitalModel> hospitalList;
        String search = normalizeText(event.contant);
        hospitalList = hospital.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          if (normalizeText(value.address).contains(search)) {
            return true;
          }
          if (normalizeText(value.placeTitle).contains(search)) {
            return true;
          }
          return false;
        }).toList();

        emit(SenAllHospitalsState(hospitalList));
      }
      if (event is SenAllDoctorEvent) {
        emit(SenAllDoctorLoadingState());
        (await allDoctorUsecase.execute(event.id)).fold((failure) {
          emit(SenAllDoctorErrorState(failure: failure));
          print(failure.massage);
        }, (data) async {
          doctor = data;
          if (doctor.isNotEmpty) {
            emit(SenAllDoctorsState(data));
          } else {
            emit(SenAllDoctorEmptyState());
          }
        });
      } else if (event is SenSearchDoctorEvent) {
        List<DoctorModel> doctorList;
        String search = normalizeText(event.contant);
        doctorList = doctor.where((value) {
          if (normalizeText(value.title).contains(search)) {
            return true;
          }
          if (normalizeText(value.address).contains(search)) {
            return true;
          }
          if (normalizeText(value.placeTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.spTitle).contains(search)) {
            return true;
          }
          return false;
        }).toList();

        emit(SenAllDoctorsState(doctorList));
      }
      else if (event is SenAllNoteDoctorEvent) {
        emit(SenAllNoteDoctorLoadingState());
        (await allVisitNotesUsecase.execute(event.id)).fold((failure) {
          emit(SenAllNoteDoctorErrorState(failure: failure));
        }, (data) async {
          doctorNoteModel=data;
          if(data.isEmpty){
            emit(SenAllNoteDoctorEmptyState());
          }else{
            emit(SenAllNoteDoctorsState(data));
          }

        });
      }
      else if (event is NoVisitDocEvent) {
        emit(SenNoVisitDocLoadingState());
        (await allNoVisitDoctorUsecase.execute(event.id)).fold((failure) {
          emit(SenNoVisitDocErrorState(failure: failure));
        }, (data) async {
          noVisitDoc=data;
          if(data.isEmpty){
            emit(SenNoVisitDocEmptyState());
          }else{
            emit(SenNoVisitDocsState(data));
          }

        });
      }
    });
  }
}
