part of 'doctors_bloc.dart';

abstract class DoctorsEvent extends Equatable {
  const DoctorsEvent();



}
class AllDoctorEvent extends DoctorsEvent {


  @override

  List<Object?> get props => [];
}

class SearchDocEvent extends DoctorsEvent {
  final String contant;
  SearchDocEvent(this.contant);
  @override
  List<Object?> get props => [contant];



}
class CheckReciEvent extends DoctorsEvent {
  final int docId;
  CheckReciEvent(this.docId);
  List<Object?> get props => [docId];
}