part of 'report_visit_doctor_bloc.dart';

@immutable
sealed class ReportVisitDoctorState extends Equatable{}

final class ReportVisitDoctorInitial extends ReportVisitDoctorState {
  @override
  List<Object?> get props => [];
}
final class AllReportVisitDoctorsState extends ReportVisitDoctorState {
  final List<RepVisitsModel> repVisitsModel;
  AllReportVisitDoctorsState(this.repVisitsModel);
  @override
  List<Object?> get props =>[repVisitsModel];
}
final class  AllReportVisitDoctorErrorState extends ReportVisitDoctorState {
  final Failure failure;
  AllReportVisitDoctorErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  AllReportVisitDoctorLoadingState extends ReportVisitDoctorState {
  AllReportVisitDoctorLoadingState();
  @override
  List<Object?> get props =>[];
}

final class  AllReportVisitDoctorEmptyState extends ReportVisitDoctorState {
  AllReportVisitDoctorEmptyState();
  @override
  List<Object?> get props =>[];
}
final class AllWhoAllReadsState extends ReportVisitDoctorState {
  final List<WhoReadModel> whoReadModel;
  AllWhoAllReadsState(this.whoReadModel);
  @override
  List<Object?> get props =>[whoReadModel];
}
final class  AllWhoAllReadErrorState extends ReportVisitDoctorState {
  final Failure failure;
  AllWhoAllReadErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  AllWhoAllReadLoadingState extends ReportVisitDoctorState {
  AllWhoAllReadLoadingState();
  @override
  List<Object?> get props =>[];
}

final class  AllWhoAllReadEmptyState extends ReportVisitDoctorState {
  AllWhoAllReadEmptyState();
  @override
  List<Object?> get props =>[];
}

final class SenVisitDoctorAsReadState extends ReportVisitDoctorState {
  final List<RepVisitsModel> doctorNoteModel;
  final RepVisitsModel repVisitsModel;
  SenVisitDoctorAsReadState(this.doctorNoteModel,this.repVisitsModel);
  @override
  List<Object?> get props =>[doctorNoteModel,repVisitsModel];
}
final class DocIsExpandedNoteState extends ReportVisitDoctorState {
  final RepVisitsModel doctorNoteModel;
  final int index;
  final bool num;
  DocIsExpandedNoteState(this.doctorNoteModel,this.index,this.num);
  @override
  List<Object?> get props =>[doctorNoteModel,index,num];
}
final class   DocNoIsExpandedNoteState extends ReportVisitDoctorState {
  DocNoIsExpandedNoteState();
  @override
  List<Object?> get props =>[];
}
final class  AsReadErrorState extends ReportVisitDoctorState {
  final Failure failure;
  AsReadErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AsReadLoadingState extends ReportVisitDoctorState {
  AsReadLoadingState();
  @override
  List<Object?> get props =>[];
}

final class AllReportVisitHospitalsState extends ReportVisitDoctorState {
  final List<RepVisitsModel> repVisitsModel;
  AllReportVisitHospitalsState(this.repVisitsModel);
  @override
  List<Object?> get props =>[repVisitsModel];
}
final class  AllReportVisitHospitalErrorState extends ReportVisitDoctorState {
  final Failure failure;
  AllReportVisitHospitalErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  AllReportVisitHospitalLoadingState extends ReportVisitDoctorState {
  AllReportVisitHospitalLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  AllReportVisitHospitalEmptyState extends ReportVisitDoctorState {
  AllReportVisitHospitalEmptyState();
  @override
  List<Object?> get props =>[];
}
class ExpandedBorderState extends ReportVisitDoctorState{
  final  bool num;
  @override
  ExpandedBorderState(this.num);
  List<Object?> get props => [num];

}
final class  AllReadErrorState extends ReportVisitDoctorState {
  final Failure failure;
  AllReadErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllReadLoadingState extends ReportVisitDoctorState {
  AllReadLoadingState();
  @override
  List<Object?> get props =>[];
}
final class AllReadSucState extends ReportVisitDoctorState {
  AllReadSucState();
  @override
  List<Object?> get props =>[];
}
