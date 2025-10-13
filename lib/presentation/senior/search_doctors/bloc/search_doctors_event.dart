part of 'search_doctors_bloc.dart';

@immutable
sealed class SearchDoctorsEvent extends Equatable {}
class FutureSearchDocEvent extends SearchDoctorsEvent {
  final String name;
  FutureSearchDocEvent(this.name);
  @override
  List<Object?> get props => [name];
}
class FutureSearchEvent extends SearchDoctorsEvent {
  final String name;
  FutureSearchEvent(this.name);
  @override
  List<Object?> get props => [name];
}
class FutureDocDoctorsEvent extends SearchDoctorsEvent {
  final int docId;
  FutureDocDoctorsEvent(this.docId);
  @override
  List<Object?> get props => [docId];
}
class DoctorInfoEvent extends SearchDoctorsEvent {
  final int docId;
  DoctorInfoEvent(this.docId);
  @override
  List<Object?> get props => [docId];
}
class SearchNoteDoctorEvent extends SearchDoctorsEvent {
  final String contant;
  SearchNoteDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}