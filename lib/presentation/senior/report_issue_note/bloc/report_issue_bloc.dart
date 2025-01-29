import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_visit_issue_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'report_issue_event.dart';
part 'report_issue_state.dart';

class ReportIssueBloc extends Bloc<ReportIssueEvent, ReportIssueState> {
  List<DoctorIssueModel> doctorIssueModel = [];
  AllVisitIssueUsecase allVisitIssueUsecase;
  ReportIssueBloc(this.allVisitIssueUsecase) : super(ReportIssueInitial()) {

    on<ReportIssueEvent>((event, emit)async {
      if (event is SenSearchIssueDoctorEvent) {
        List<DoctorIssueModel> doctorNote;
        String search = normalizeText(event.contant);
        doctorNote = doctorIssueModel.where((value) {
          if (normalizeText(value.docTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.address).contains(search)) {
            return true;
          }
          if (normalizeText(value.spTitle).contains(search)) {
            return true;
          }

          return false;
        }).toList();
        emit(SenAllNoteDoctorsState(doctorNote));
      }
      else if (event is SenAllIssueDoctorEvent) {
        emit(SenAllNoteDoctorLoadingState());
        (await allVisitIssueUsecase.execute(event.id)).fold((failure) {
          emit(SenAllNoteDoctorErrorState(failure: failure));
        }, (data) async {
          doctorIssueModel=data;
          if(data.isEmpty){
            emit(SenAllNoteDoctorEmptyState());
          }else{
            emit(SenAllNoteDoctorsState(data));
          }

        });
      }
      else  if(event is ChangeReadIssueNoteEvent){
        print(event.isRead);
        List<DoctorIssueModel> doctorNote = List.from(doctorIssueModel);
        DoctorIssueModel Note1=DoctorIssueModel(doctorNote[event.id].docTitle, doctorNote[event.id].spTitle,
            doctorNote[event.id].address, doctorNote[event.id].visitDate,doctorNote[event.id].issue, event.isRead) ;
        doctorIssueModel[event.id]=Note1;
        doctorNote[event.id]=Note1;
        emit(SenAsReadState(doctorNote));
      }
    });
  }
}