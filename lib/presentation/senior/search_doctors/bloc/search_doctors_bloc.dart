import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_search_hos_note_usecase.dart';
import 'package:domina_app/domain/usecase/all_search_hos_usecase.dart';
import 'package:domina_app/domain/usecase/doc_doctors_usecase.dart';
import 'package:domina_app/domain/usecase/doctor_info_usecase.dart';
import 'package:domina_app/domain/usecase/search_doctors_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'search_doctors_event.dart';
part 'search_doctors_state.dart';

class SearchDoctorsBloc extends Bloc<SearchDoctorsEvent, SearchDoctorsState> {
  List<doctorsModel> representative = [];
  List<DocdoctorsModel> doctorDetails = [];
  List<SearchHospitalModel> allSearchHospital = [];
  List<SearchHospitalNoteModel> allSearchHospitalNote = [];
  SearchDoctorsUsecase searchDoctorsUsecase;
  AllSearchHosUsecase allSearchHosUsecase;
  AllSearchHosNoteUsecase allSearchHosNoteUsecase;
  DocDoctorsUseCase docDoctorsUseCase;
  DoctorInfoUsecase doctorInfoUsecase;
  int value = 0;
  String name1 = ' ';
  SearchDoctorsBloc(
      this.searchDoctorsUsecase,
      this.docDoctorsUseCase,
      this.doctorInfoUsecase,
      this.allSearchHosUsecase,
      this.allSearchHosNoteUsecase)
      : super(EditBrandPlanInitial()) {
    on<FutureSearchDocEvent>((event, emit) async {
      representative = [];
      emit(FutureSearchDoctorsLoadingState());
      (await searchDoctorsUsecase.execute(event.name, event.id,
              cityId: event.cityId))
          .fold((failure) {
        emit(FutureSearchDoctorsErrorState(failure: failure));
      }, (data) async {
        representative = data;
        if (data.isEmpty) {
          emit(FutureSearchDoctorsEmptyState());
        } else {
          emit(FutureSearchDoctorsState(data));
        }
      });
    });

    on<FutureDocDoctorsEvent>((event, emit) async {
      doctorDetails = [];
      emit(FutureDocDoctorsLoadingState());
      (await docDoctorsUseCase.execute(event.docId)).fold((failure) {
        emit(FutureDocDoctorsErrorState(failure: failure));
      }, (data) async {
        if (data.isEmpty) {
          emit(FutureDocDoctorsEmptyState());
        } else {
          doctorDetails = data;
          emit(FutureDocDoctorsState(data));
        }
      });
    });

    on<FutureSearchHosEvent>((event, emit) async {
      allSearchHospital = [];
      emit(FutureSearchHospitalsLoadingState());
      (await allSearchHosUsecase.execute(
              cityId: event.cityId, event.name, event.id))
          .fold((failure) {
        emit(FutureSearchHospitalsErrorState(failure: failure));
      }, (data) async {
        allSearchHospital = data;
        if (data.isEmpty) {
          emit(FutureSearchHospitalsEmptyState());
        } else {
          emit(FutureSearchHospitalsState(data));
        }
      });
    });

    on<FutureDocHospitalEvent>((event, emit) async {
      allSearchHospitalNote = [];
      emit(FutureDocHospitalsLoadingState());
      (await allSearchHosNoteUsecase.execute(event.hosId, event.spId)).fold(
          (failure) {
        emit(FutureDocHospitalsErrorState(failure: failure));
      }, (data) async {
        emit(FutureDocHospitalsState(data));

        if (data.isEmpty) {
          emit(FutureDocHospitalsEmptyState());
        } else {
          allSearchHospitalNote = data;
          emit(FutureDocHospitalsState(data));
        }
      });
    });

    on<ToggleSheetEvent>((event, emit) async {
      emit(DocIsExpandedNoteState(index: event.index));
    });

    on<DocNoIsExpandedNoteEvent>((event, emit) async {
      emit(DocNoIsExpandedNoteState());
    });

    on<DoctorInfoEvent>((event, emit) async {
      emit(DoctorInfoLoadingState());
      (await doctorInfoUsecase.execute(event.docId)).fold((failure) {
        emit(DoctorInfoErrorState(failure: failure));
      }, (data) async {
        emit(DoctorInfoState(data));
      });
    });

    on<SearchNoteDoctorEvent>((event, emit) async {
      List<DocdoctorsModel> doctorNote;
      String search = normalizeText(event.contant);
      doctorNote = doctorDetails.where((value) {
        if (normalizeText(value.issue).contains(search)) {
          return true;
        }
        if (normalizeText(value.note).contains(search)) {
          return true;
        }
        if (normalizeText(value.target).contains(search)) {
          return true;
        }
        if (normalizeText(value.repName).contains(search)) {
          return true;
        }
        return false;
      }).toList();
      emit(FutureDocDoctorsState(doctorNote));
    });

    on<SearchNoteHosEvent>((event, emit) async {
      List<SearchHospitalNoteModel> hospitalNote;
      String search = normalizeText(event.contant);
      hospitalNote = allSearchHospitalNote.where((value) {
        if (normalizeText(value.note).contains(search)) {
          return true;
        }
        if (normalizeText(value.issue).contains(search)) {
          return true;
        }
        if (normalizeText(value.target).contains(search)) {
          return true;
        }
        if (normalizeText(value.name).contains(search)) {
          return true;
        }
        return false;
      }).toList();
      emit(FutureDocHospitalsState(hospitalNote));
    });
  }
}
