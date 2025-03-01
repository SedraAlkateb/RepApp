part of 'report_issue_bloc.dart';

@immutable
sealed class ReportIssueState extends Equatable {}

final class ReportIssueInitial extends ReportIssueState {
  @override
List<Object?> get props =>[];}

final class SenAllNoteDoctorsState extends ReportIssueState {
  final List<DoctorIssueModel> doctorIssueModel;
  SenAllNoteDoctorsState(this.doctorIssueModel);
  @override
  List<Object?> get props =>[doctorIssueModel];
}
final class  SenAllNoteDoctorErrorState extends ReportIssueState {
  final Failure failure;
  SenAllNoteDoctorErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  SenAllNoteDoctorLoadingState extends ReportIssueState {
  SenAllNoteDoctorLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  SenAllNoteDoctorEmptyState extends ReportIssueState {
  SenAllNoteDoctorEmptyState();
  @override
  List<Object?> get props =>[];
}

final class SenAsReadState extends ReportIssueState {
  final List<DoctorIssueModel> doctorIssueModel;
  SenAsReadState(this.doctorIssueModel);
  @override
  List<Object?> get props =>[doctorIssueModel];
}