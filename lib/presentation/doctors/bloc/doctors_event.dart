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
  final int st;
  CheckReciEvent(this.docId,this.st);
  List<Object?> get props => [docId];
}
class AllHospitalEvent extends DoctorsEvent {

  AllHospitalEvent();

  @override

  List<Object?> get props => [];
}
class SearchhosEvent extends DoctorsEvent {
  final String contant;
  SearchhosEvent(this.contant);
  @override
  List<Object?> get props => [contant];

}
