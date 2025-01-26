part of 'report_science_bloc.dart';

@immutable
sealed class ReportScienceState extends Equatable{}

final class ReportScienceInitial extends ReportScienceState {
  @override
  List<Object?> get props =>[];
}
final class SenAllNoteDoctorsState extends ReportScienceState {
  final List<DoctorNoteModel> doctorNoteModel;
  SenAllNoteDoctorsState(this.doctorNoteModel);
  @override
  List<Object?> get props =>[doctorNoteModel];
}
final class  SenAllNoteDoctorErrorState extends ReportScienceState {
  final Failure failure;
  SenAllNoteDoctorErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class  SenAllNoteDoctorLoadingState extends ReportScienceState {
  SenAllNoteDoctorLoadingState();
  @override
  List<Object?> get props =>[];
}
final class  SenAllNoteDoctorEmptyState extends ReportScienceState {
  SenAllNoteDoctorEmptyState();
  @override
  List<Object?> get props =>[];
}
final class SenAsReadState extends ReportScienceState {
  final List<DoctorNoteModel> doctorNoteModel;
  SenAsReadState(this.doctorNoteModel);
  @override
  List<Object?> get props =>[doctorNoteModel];
}