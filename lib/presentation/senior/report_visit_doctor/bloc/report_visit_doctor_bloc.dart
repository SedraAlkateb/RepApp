import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_visit_doctor_rep_sen_usecase.dart';
import 'package:domina_app/domain/usecase/all_visit_hospital_rep_sen_usecase.dart';
import 'package:domina_app/domain/usecase/read_visit_usecase%20.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'report_visit_doctor_event.dart';
part 'report_visit_doctor_state.dart';

class ReportVisitDoctorBloc
    extends Bloc<ReportVisitDoctorEvent, ReportVisitDoctorState> {
  AllVisitDoctorRepSenUsecase allVisitDoctorRepSenUsecase;
  ReadVisitUsecase readVisitUsecase;
  AllVisitHospitalRepSenUsecase allVisitHospitalRepSenUsecase;
  List<RepVisitsModel> repVisits = [];
  List<RepVisitsModel> repVisitHospital = [];
  bool isExpanded = false;
  bool num = false;
  int index = 0;
  RepVisitsModel doctorNoteModel =
      RepVisitsModel("", "", "", "", "", "", "", "", "", "", false, []);
  ReportVisitDoctorBloc(this.allVisitDoctorRepSenUsecase, this.readVisitUsecase,
      this.allVisitHospitalRepSenUsecase)
      : super(ReportVisitDoctorInitial()) {
    on<ReportVisitDoctorEvent>((event, emit) async {
      if (event is AllReportVisitDoctorEvent) {
        emit(AllReportVisitDoctorLoadingState());
        (await allVisitDoctorRepSenUsecase.execute(event.visitRepSen)).fold(
            (failure) {
          emit(AllReportVisitDoctorErrorState(failure: failure));
        }, (data) async {
          repVisits = data;
          if (data.isEmpty) {
            emit(AllReportVisitDoctorEmptyState());
          } else {
            emit(AllReportVisitDoctorsState(data));
          }
        });
      }
      if (event is AllReportVisitHospitalEvent) {
        emit(AllReportVisitHospitalLoadingState());
        (await allVisitHospitalRepSenUsecase.execute(event.visitRepSen)).fold(
            (failure) {
          emit(AllReportVisitHospitalErrorState(failure: failure));
        }, (data) async {
          repVisitHospital = data;
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
        emit(AllReportVisitHospitalsState(hospitalNote));
      } else if (event is SenSearchNoteVisitDoctorEvent) {
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
        emit(AllReportVisitDoctorsState(doctorNote));
      } else if (event is DocIsExpandedNoteEvent) {
        isExpanded = true;
        doctorNoteModel = event.repVisitsModel;
        index = event.index;
        emit(DocIsExpandedNoteState(event.repVisitsModel, event.index, num));
      } else if (event is DocNoIsExpandedNoteEvent) {
        isExpanded = false;
        num = false;
        index = -1;
        emit(DocNoIsExpandedNoteState());
      } else if (event is ChangeReadDocNoteEvent) {
        emit(AsReadLoadingState());
        List<RepVisitsModel> doctorNote = List.from(repVisits);
        (await readVisitUsecase.execute(AsRead(
                int.parse(repVisits[event.id].visitId),
                UserInfo.repId,
                event.isRead == true ? 1 : 0,
                1)))
            .fold((failure) {
          emit(AsReadErrorState(failure: failure));
        }, (data) async {
          index = event.id;
          RepVisitsModel doctorNote1 = RepVisitsModel(
            doctorNote[event.id].visitId,
            doctorNote[event.id].visitDate,
            doctorNote[event.id].placeTitle,
            doctorNote[event.id].docTitle,
            doctorNote[event.id].rate,
            doctorNote[event.id].spTitle,
            doctorNote[event.id].note,
            doctorNote[event.id].issue,
            doctorNote[event.id].special,
            doctorNote[event.id].target,
            event.isRead,
            doctorNote[event.id].samples,
          );
          repVisits[event.id] = doctorNote1;
          doctorNote[event.id] = doctorNote1;
          doctorNoteModel = doctorNote[event.id];
          emit(SenVisitDoctorAsReadState(doctorNote, doctorNote1));
        });
      } else if (event is ChangeReadHosNoteEvent) {
        emit(AsReadLoadingState());

        List<RepVisitsModel> doctorNote = List.from(repVisits);
        (await readVisitUsecase.execute(AsRead(
                int.parse(repVisits[event.id].visitId),
                UserInfo.repId,
                0,
                event.isRead == true ? 1 : 0)))
            .fold((failure) {
          emit(AsReadErrorState(failure: failure));
        }, (data) async {
          RepVisitsModel doctorNote1 = RepVisitsModel(
            doctorNote[event.id].visitId,
            doctorNote[event.id].visitDate,
            doctorNote[event.id].placeTitle,
            doctorNote[event.id].docTitle,
            doctorNote[event.id].rate,
            doctorNote[event.id].spTitle,
            doctorNote[event.id].note,
            doctorNote[event.id].issue,
            doctorNote[event.id].special,
            doctorNote[event.id].target,
            event.isRead,
            doctorNote[event.id].samples,
          );
          index = event.id;
          repVisits[event.id] = doctorNote1;
          doctorNote[event.id] = doctorNote1;
          doctorNoteModel = doctorNote[event.id];
          emit(SenVisitDoctorAsReadState(doctorNote, doctorNote1));
        });
      } else if (event is ExpandedBorder) {
        num = event.num;
        emit(ExpandedBorderState(event.num));
      }
    });
  }
}
