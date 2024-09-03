part of 'hospitals_bloc.dart';

abstract class HospitalsEvent extends Equatable {
  const HospitalsEvent();


}
class AllHospitalEvent extends HospitalsEvent {
 int id;
  AllHospitalEvent(this.id);
  
  @override

  List<Object?> get props => throw UnimplementedError();
}