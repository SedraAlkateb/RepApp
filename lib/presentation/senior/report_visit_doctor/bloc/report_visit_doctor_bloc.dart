import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_read_sen_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_doctor_rep_sen_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_hospital_rep_sen_usecase.dart';
import 'package:domina_app/domain/usecase/read_visit_usecase%20.dart';
import 'package:domina_app/domain/usecase/visit_read_status.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'report_visit_doctor_event.dart';
part 'report_visit_doctor_state.dart';
class ReportVisitDoctorBloc
    extends Bloc<ReportVisitDoctorEvent, ReportVisitDoctorState> {
  AllVisitDoctorRepSenUsecase allVisitDoctorRepSenUsecase;
  ReadVisitUsecase readVisitUsecase;
  AllReadSenUsecase allReadSenUsecase;
  AllVisitHospitalRepSenUsecase allVisitHospitalRepSenUsecase;
  VisitReadStatus visitReadStatus;
  List<RepVisitsModel> repVisits = [];
  List<RepVisitsModel> repVisitsSearch = [];

  List<RepVisitsModel> repVisitHospital = [];
  bool isExpanded = false;
  bool num = false;
  int index = 0;
  void clear() {
    isExpanded = false;
    num = false;
    index = 0;
  }

  RepVisitsModel doctorNoteModel =
  RepVisitsModel("", "", "", "", "", "", "", "", "", "", false, []);
  ReportVisitDoctorBloc(this.allVisitDoctorRepSenUsecase, this.readVisitUsecase,
      this.allVisitHospitalRepSenUsecase,this.allReadSenUsecase,this.visitReadStatus)
      : super(ReportVisitDoctorInitial()) {
    on<ReportVisitDoctorEvent>((event, emit) async {
      if (event is AllReportVisitDoctorEvent) {
        emit(AllReportVisitDoctorLoadingState());
        (await allVisitDoctorRepSenUsecase.execute(event.visitRepSen)).fold(
                (failure) {
              emit(AllReportVisitDoctorErrorState(failure: failure));
            }, (data) async {
          repVisits = data;
          if(event.isSen==true){
            repVisits.sort((a, b) {
              if (a.flag && !b.flag) return -1; // a=true يجي قبل
              if (!a.flag && b.flag) return 1;  // b=true يجي قبل
              return 0;
            });
          }else{
            repVisits.sort((a, b) {
              if (!a.flag && b.flag) return -1; // a=false يجي قبل
              if (a.flag && !b.flag) return 1;  // b=false يجي قبل
              return 0;
            });

          }
          repVisitsSearch = data;
          if (data.isEmpty) {
            emit(AllReportVisitDoctorEmptyState());
          } else {
            emit(AllReportVisitDoctorsState(data));
          }
        });
      }
      if (event is WhoAllReadEvent) {
        emit(AllWhoAllReadLoadingState());
        (await visitReadStatus.execute(event.visitId,event.visitType))
            .fold(
                (failure) {
              emit(AllWhoAllReadErrorState(failure: failure));
            }, (data) async {
          if (data.isEmpty) {
            emit(AllWhoAllReadEmptyState());
          } else {
            emit(AllWhoAllReadsState(data));
          }
        });
      }
      /////
      if (event is AllReportVisitHospitalEvent) {
        emit(AllReportVisitHospitalLoadingState());
        (await allVisitHospitalRepSenUsecase.execute(event.visitRepSen)).fold(
                (failure) {
              emit(AllReportVisitHospitalErrorState(failure: failure));
            }, (data) async {
          repVisitHospital = data;
          if(event.isSen==true){
            repVisitHospital.sort((a, b) {
              if (a.flag && !b.flag) return -1; // a=true يجي قبل
              if (!a.flag && b.flag) return 1;  // b=true يجي قبل
              return 0;
            });
          }else{
            repVisitHospital.sort((a, b) {
              if (!a.flag && b.flag) return -1; // a=false يجي قبل
              if (a.flag && !b.flag) return 1;  // b=false يجي قبل
              return 0;
            });

          }


          repVisitsSearch = data;
          if (data.isEmpty) {
            emit(AllReportVisitHospitalEmptyState());
          } else {
            emit(AllReportVisitHospitalsState(data));
          }
        });
      } else if (event is SenSearchNoteVisitHospitalEvent) {
        List<RepVisitsModel> hospitalNote;
        String search = normalizeText(event.contant);
        hospitalNote = repVisitHospital.where((value) {
          if (normalizeText(value.docTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.placeTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.spTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.note).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        repVisitsSearch = hospitalNote;
        emit(AllReportVisitHospitalsState(hospitalNote));
      }
      else if (event is SenSearchNoteVisitDoctorEvent) {
        List<RepVisitsModel> doctorNote;
        String search = normalizeText(event.contant);
        doctorNote = repVisits.where((value) {
          if (normalizeText(value.docTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.placeTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.spTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.note).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        repVisitsSearch = doctorNote;
        emit(AllReportVisitDoctorsState(repVisitsSearch));
      }
      else if (event is DocIsExpandedNoteEvent) {
        isExpanded = true;
        doctorNoteModel = event.repVisitsModel;
        index = event.index;
        emit(DocIsExpandedNoteState(event.repVisitsModel, event.index, num));
      }
      else if (event is DocNoIsExpandedNoteEvent) {
        isExpanded = false;
        num = false;
        index = -1;
        emit(DocNoIsExpandedNoteState());
      }
      else if (event is ChangeReadDocNoteEvent) {
        emit(AsReadLoadingState());
        (await readVisitUsecase.execute(AsRead(
            int.parse(event.repVisitsModel.visitId),
            UserInfo.repId,
            !event.repVisitsModel.flag == true ? 1 : 0,
            1)))
            .fold((failure) {
          emit(AsReadErrorState(failure: failure));
        }, (data) async {
          List<RepVisitsModel> doctorNote = List.from(repVisits);
          index = repVisits.indexWhere(
                  (repVisit) => repVisit.visitId == event.repVisitsModel.visitId);
          RepVisitsModel doctorNote1 = RepVisitsModel(
            event.repVisitsModel.visitId,
            event.repVisitsModel.visitDate,
            event.repVisitsModel.placeTitle,
            event.repVisitsModel.docTitle,
            event.repVisitsModel.rate,
            event.repVisitsModel.spTitle,
            event.repVisitsModel.note,
            event.repVisitsModel.issue,
            event.repVisitsModel.special,
            event.repVisitsModel.target,
            !event.repVisitsModel.flag,
            event.repVisitsModel.samples,
          );
          repVisits[index] = doctorNote1;
          repVisitsSearch[event.indexBook] = doctorNote1;
          doctorNote[index] = doctorNote1;
          doctorNoteModel = doctorNote[index];
          emit(SenVisitDoctorAsReadState(repVisitsSearch, doctorNote1));
        });
      }
      else if (event is AllReadDocNoteEvent) {
        //  emit(AllReadLoadingState());
        (await allReadSenUsecase.execute(event.readAll))
            .fold((failure) {
          emit(AllReadErrorState(failure: failure));
        }, (data) async {
          emit(AllReadSucState());
        });
      }

      else if (event is ChangeReadHosNoteEvent) {
        emit(AsReadLoadingState());
        (await readVisitUsecase.execute(AsRead(
            int.parse(event.repVisitsModel.visitId),
            UserInfo.repId,
            !event.repVisitsModel.flag == true ? 1 : 0,
            0)))
            .fold((failure) {
          emit(AsReadErrorState(failure: failure));
        }, (data) async {
          List<RepVisitsModel> doctorNote = List.from(repVisitHospital);
          index = repVisitHospital.indexWhere(
                  (repVisit) => repVisit.visitId == event.repVisitsModel.visitId);
          RepVisitsModel doctorNote1 = RepVisitsModel(
            event.repVisitsModel.visitId,
            event.repVisitsModel.visitDate,
            event.repVisitsModel.placeTitle,
            event.repVisitsModel.docTitle,
            event.repVisitsModel.rate,
            event.repVisitsModel.spTitle,
            event.repVisitsModel.note,
            event.repVisitsModel.issue,
            event.repVisitsModel.special,
            event.repVisitsModel.target,
            !event.repVisitsModel.flag,
            event.repVisitsModel.samples,
          );
          repVisitHospital[index] = doctorNote1;
          doctorNote[index] = doctorNote1;
          doctorNoteModel = doctorNote[index];
          repVisitsSearch[event.indexBook] = doctorNote1;
          emit(SenVisitDoctorAsReadState(repVisitsSearch, doctorNote1));
        });
      } else if (event is ExpandedBorder) {
        num = event.num;
        emit(ExpandedBorderState(event.num));
      }
    });
  }
}
