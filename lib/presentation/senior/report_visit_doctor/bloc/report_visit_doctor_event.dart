part of 'report_visit_doctor_bloc.dart';

@immutable
sealed class ReportVisitDoctorEvent extends Equatable {}

class AllReportVisitDoctorEvent extends ReportVisitDoctorEvent {
  final VisitRepSen visitRepSen;
  final bool isSen;//true genReport // false myReport
  @override
  AllReportVisitDoctorEvent(this.visitRepSen,this.isSen);
  List<Object?> get props => [visitRepSen,isSen];
}
class WhoAllReadEvent extends ReportVisitDoctorEvent {
  final String visitId;
  final String visitType;
  @override
  WhoAllReadEvent(this.visitId,this.visitType);
  List<Object?> get props => [visitId,visitType];
}
class AllReportVisitHospitalEvent extends ReportVisitDoctorEvent {
  final VisitRepSen visitRepSen;
  final bool isSen;//true genReport // false myReport
  @override
  AllReportVisitHospitalEvent(this.visitRepSen,this.isSen);
  List<Object?> get props => [visitRepSen,isSen];
}

class SenSearchNoteVisitDoctorEvent extends ReportVisitDoctorEvent {
  final String contant;
  SenSearchNoteVisitDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}

class SenSearchNoteVisitHospitalEvent extends ReportVisitDoctorEvent {
  final String contant;
  SenSearchNoteVisitHospitalEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}

class DocIsExpandedNoteEvent extends ReportVisitDoctorEvent {
  final RepVisitsModel repVisitsModel;
  final int index;
  @override
  DocIsExpandedNoteEvent(this.repVisitsModel, this.index);
  List<Object?> get props => [repVisitsModel, index];
}

class DocNoIsExpandedNoteEvent extends ReportVisitDoctorEvent {
  @override
  DocNoIsExpandedNoteEvent();
  List<Object?> get props => [];
}

class ChangeReadDocNoteEvent extends ReportVisitDoctorEvent {
  final RepVisitsModel repVisitsModel;
  final indexBook;
  final int index;
  @override
  ChangeReadDocNoteEvent({required this.repVisitsModel,required this.index,required this.indexBook});
  List<Object?> get props => [repVisitsModel, index];
}
class AllReadDocNoteEvent extends ReportVisitDoctorEvent {
  final ReadAll readAll;
  @override
  AllReadDocNoteEvent({required this.readAll});
  List<Object?> get props => [readAll];
}
class ChangeReadHosNoteEvent extends ReportVisitDoctorEvent {
  final RepVisitsModel repVisitsModel;
  final indexBook;
  final int index;
  @override
  ChangeReadHosNoteEvent({required this.repVisitsModel,required this.index, required this.indexBook});
  List<Object?> get props => [repVisitsModel, index,indexBook];
}

class ExpandedBorder extends ReportVisitDoctorEvent {
  final bool num;

  @override
  ExpandedBorder(this.num);
  List<Object?> get props => [num];
}
