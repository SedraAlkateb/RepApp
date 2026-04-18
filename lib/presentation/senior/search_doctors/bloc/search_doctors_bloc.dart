import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
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
  int value=0;
  String name1 = ' ';
  SearchDoctorsBloc(
    this.searchDoctorsUsecase,
    this.docDoctorsUseCase,
      this.doctorInfoUsecase,
      this.allSearchHosUsecase,
      this.allSearchHosNoteUsecase
  ) : super(EditBrandPlanInitial()) {
    on<SearchDoctorsEvent>((event, emit) async {
      if (event is FutureSearchDocEvent) {
        representative = [];
        emit(FutureSearchDoctorsLoadingState());
        (await searchDoctorsUsecase.execute(UserInfo.cityId, event.name)).fold(
            (failure) {
          emit(FutureSearchDoctorsErrorState(failure: failure));
        }, (data) async {
          representative = data;
          if(data.isEmpty){
            emit(FutureSearchDoctorsEmptyState());

          }else{
            emit(FutureSearchDoctorsState(data));

          }
        });
      }
      else if (event is FutureDocDoctorsEvent) {
        doctorDetails = [];
        emit(FutureDocDoctorsLoadingState());
        (await docDoctorsUseCase.execute(event.docId)).fold((failure) {
          emit(FutureDocDoctorsErrorState(failure: failure));
        }, (data) async {
             emit(FutureDocDoctorsState(data));
        
         if (data.isEmpty) {
              emit(FutureDocDoctorsEmptyState());
            } else {
            doctorDetails = data;
              emit(FutureDocDoctorsState(data));
            }
         }
         );
      }

     else if (event is FutureSearchHosEvent) {
        allSearchHospital = [];
        emit(FutureSearchHospitalsLoadingState());
        (await allSearchHosUsecase.execute( event.name)).fold(
                (failure) {
              emit(FutureSearchHospitalsErrorState(failure: failure));
            }, (data) async {
          allSearchHospital = data;
          if(data.isEmpty){
            emit(FutureSearchHospitalsEmptyState());

          }else{
            emit(FutureSearchHospitalsState(data));

          }
        });
      }
      else if (event is FutureDocHospitalEvent) {
        allSearchHospitalNote = [];
        emit(FutureDocHospitalsLoadingState());
        (await allSearchHosNoteUsecase.execute(event.hosId,event.spId)).fold((failure) {
          emit(FutureDocHospitalsErrorState(failure: failure));
        }, (data) async {
          emit(FutureDocHospitalsState(data));

          if (data.isEmpty) {
            emit(FutureDocHospitalsEmptyState());
          } else {
            allSearchHospitalNote = data;
            emit(FutureDocHospitalsState(data));
          }
        }
        );
      }


      else if(event is ToggleSheetEvent){
   emit( DocIsExpandedNoteState(index: event.index));
} else if (event is DocNoIsExpandedNoteEvent) {
  emit( DocNoIsExpandedNoteState());
}
      
  else if (event is DoctorInfoEvent) {

        emit(DoctorInfoLoadingState());
        (await doctorInfoUsecase.execute(event.docId)).fold((failure) {
          emit(DoctorInfoErrorState(failure: failure));
        }, (data) async {
          emit(DoctorInfoState(data));
        }
        );
      }
  ///////////////////////////////////////
      else if (event is DoctorInfoEvent) {

        emit(DoctorInfoLoadingState());
        (await doctorInfoUsecase.execute(event.docId)).fold((failure) {
          emit(DoctorInfoErrorState(failure: failure));
        }, (data) async {
          emit(DoctorInfoState(data));
        }
        );
      }
      else if (event is SearchNoteDoctorEvent) {
        List<DocdoctorsModel> doctorNote;
        String search = normalizeText(event.contant);
        doctorNote = doctorDetails.where((value) {
          if (normalizeText(value.issue).contains(search)) {
            return true;
          }
          if (normalizeText(value.note).contains(search)) {
            return true;
          }
          if (normalizeText(value.repName).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(FutureDocDoctorsState(doctorNote));
      }
      else if (event is SearchNoteHosEvent) {
        List<SearchHospitalNoteModel> hospitalNote;
        String search = normalizeText(event.contant);
        hospitalNote = allSearchHospitalNote.where((value) {
          if (normalizeText(value.note).contains(search)) {
            return true;
          }
          if (normalizeText(value.issue).contains(search)) {
            return true;
          }
          if (normalizeText(value.name).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(FutureDocHospitalsState(hospitalNote));
      }
    });
  }
}
