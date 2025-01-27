import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_visit_notes_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'report_science_event.dart';
part 'report_science_state.dart';

class ReportScienceBloc extends Bloc<ReportScienceEvent, ReportScienceState> {
  List<DoctorNoteModel> doctorNoteModel = [];
  AllVisitNotesUsecase allVisitNotesUsecase;
  ReportScienceBloc(
      this.allVisitNotesUsecase
      ) : super(ReportScienceInitial()) {
    on<ReportScienceEvent>((event, emit)async {
      if (event is SenSearchNoteDoctorEvent) {
        List<DoctorNoteModel> doctorNote;
        String search = normalizeText(event.contant);
        doctorNote = doctorNoteModel.where((value) {
          if (normalizeText(value.docTitle).contains(search)) {
            return true;
          }
          if (normalizeText(value.address).contains(search)) {
            return true;
          }
          if (normalizeText(value.spTitle).contains(search)) {
            return true;
          }
          if( value.note!=null){
            if( normalizeText(value.note!).contains(search)) {
              return true;
            }
          }
          return false;
        }).toList();
        emit(SenAllNoteDoctorsState(doctorNote));
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
    else  if(event is ChangeReadScienceNoteEvent){
      print(event.isRead);
      List<DoctorNoteModel> doctorNote = List.from(doctorNoteModel);
      DoctorNoteModel doctorNote1=DoctorNoteModel(doctorNote[event.id].docTitle, doctorNote[event.id].spTitle,
          doctorNote[event.id].address, doctorNote[event.id].visitDate, doctorNote[event.id].note, event.isRead) ;
      doctorNoteModel[event.id]=doctorNote1;
      doctorNote[event.id]=doctorNote1;
      emit(SenAsReadState(doctorNote));
      }
    });
  }
}
