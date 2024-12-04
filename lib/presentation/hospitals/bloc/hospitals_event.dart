part of 'hospitals_bloc.dart';

abstract class HospitalsEvent extends Equatable {
  const HospitalsEvent();


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
