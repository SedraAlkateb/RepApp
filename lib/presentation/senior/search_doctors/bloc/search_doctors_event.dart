part of 'search_doctors_bloc.dart';

@immutable
sealed class SearchDoctorsEvent extends Equatable {}
class FutureSearchDocEvent extends SearchDoctorsEvent {
  final String name;
  FutureSearchDocEvent(this.name);
  @override
  List<Object?> get props => [name];
}
class FutureDocDoctorsEvent extends SearchDoctorsEvent {
  final int docId;
  FutureDocDoctorsEvent(this.docId);
  @override
  List<Object?> get props => [docId];
}
class SearchNoteDoctorEvent extends SearchDoctorsEvent {
  final String contant;
  SearchNoteDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}
class SearchNoteHosEvent extends SearchDoctorsEvent {
  final String contant;
  SearchNoteHosEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}
class ToggleSheetEvent extends SearchDoctorsEvent {
  final int index;
  ToggleSheetEvent(this.index);
  @override
  List<Object?> get props => [index];
}

class DocNoIsExpandedNoteEvent extends SearchDoctorsEvent {

  @override
  List<Object?> get props => [];
}

class DoctorInfoEvent extends SearchDoctorsEvent {
  final int docId;
  DoctorInfoEvent(this.docId);
  @override
  List<Object?> get props => [docId];
}


class FutureSearchHosEvent extends SearchDoctorsEvent {
  final String name;
  FutureSearchHosEvent(this.name);
  @override
  List<Object?> get props => [name];
}
class FutureDocHospitalEvent extends SearchDoctorsEvent {
  final int hosId;
  final int spId;
  FutureDocHospitalEvent(this.hosId,this.spId);
  @override
  List<Object?> get props => [hosId,spId];
}