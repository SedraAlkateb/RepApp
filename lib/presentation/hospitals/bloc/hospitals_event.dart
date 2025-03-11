part of 'hospitals_bloc.dart';

abstract class HospitalsEvent extends Equatable {
  const HospitalsEvent();
}
class CheckReciEvent extends HospitalsEvent {
  final int hosId;
  final int st;
  CheckReciEvent(this.hosId,this.st);
  List<Object?> get props => [hosId];
}
class AllHospitalEvent extends HospitalsEvent {

  AllHospitalEvent();

  @override

  List<Object?> get props => [];
}
class SearchhosEvent extends HospitalsEvent {
  final String contant;
  SearchhosEvent(this.contant);
  @override
  List<Object?> get props => [contant];

}
