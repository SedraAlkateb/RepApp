part of 'report_science_bloc.dart';

@immutable
abstract class ReportScienceEvent extends Equatable{}
class SenSearchNoteDoctorEvent extends ReportScienceEvent{
  final String contant;
  SenSearchNoteDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];

}
class SenAllNoteDoctorEvent extends ReportScienceEvent{
  final  int id;
  @override
  SenAllNoteDoctorEvent(this.id);
  List<Object?> get props => [id];

}
class ChangeReadScienceNoteEvent extends ReportScienceEvent{
  final  int id;
  final  bool isRead;

  @override
  ChangeReadScienceNoteEvent(this.id,this.isRead);
  List<Object?> get props => [id,isRead];

}
class IsExpandedNoteEvent extends ReportScienceEvent{
 final DoctorNoteModel doctorNoteModel;
  @override
  IsExpandedNoteEvent(this.doctorNoteModel);
  List<Object?> get props => [doctorNoteModel];

}
class NoIsExpandedNoteEvent extends ReportScienceEvent{
  @override
  NoIsExpandedNoteEvent();
  List<Object?> get props => [];

}