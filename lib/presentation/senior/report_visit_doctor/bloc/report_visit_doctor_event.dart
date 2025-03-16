part of 'report_visit_doctor_bloc.dart';

@immutable
sealed class ReportVisitDoctorEvent extends Equatable {}

class AllReportVisitDoctorEvent extends ReportVisitDoctorEvent {
  final VisitRepSen visitRepSen;
  @override
  AllReportVisitDoctorEvent(this.visitRepSen);
  List<Object?> get props => [visitRepSen];
}

class AllReportVisitHospitalEvent extends ReportVisitDoctorEvent {
  final VisitRepSen visitRepSen;
  @override
  AllReportVisitHospitalEvent(this.visitRepSen);
  List<Object?> get props => [visitRepSen];
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
  final int id;
  final bool isRead;
  final int index;
  @override
  ChangeReadDocNoteEvent({required this.id,required this.isRead,required this.index});
  List<Object?> get props => [id, isRead];
}

class ChangeReadHosNoteEvent extends ReportVisitDoctorEvent {
  final int id;
  final bool isRead;
  final index;
  @override
  ChangeReadHosNoteEvent({required this.id,required this.isRead, required this.index});
  List<Object?> get props => [id, isRead];
}

class ExpandedBorder extends ReportVisitDoctorEvent {
  final bool num;

  @override
  ExpandedBorder(this.num);
  List<Object?> get props => [num];
}
