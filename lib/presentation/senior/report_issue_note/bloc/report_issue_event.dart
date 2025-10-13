part of 'report_issue_bloc.dart';

@immutable
sealed class ReportIssueEvent extends Equatable {}
class SenSearchIssueDoctorEvent extends ReportIssueEvent{
  final String contant;
  SenSearchIssueDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}
class SenAllIssueDoctorEvent extends ReportIssueEvent{
  final  int id;
  @override
  SenAllIssueDoctorEvent(this.id);
  List<Object?> get props => [id];
}
class ChangeReadIssueNoteEvent extends ReportIssueEvent{
  final  int id;
  final  bool isRead;
  @override
  ChangeReadIssueNoteEvent(this.id,this.isRead);
  List<Object?> get props => [id,isRead];
}