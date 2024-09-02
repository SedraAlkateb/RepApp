part of 'doctors_bloc.dart';

abstract class DoctorsEvent extends Equatable {
  const DoctorsEvent();

  
  
}
class AllDoctorEvent extends DoctorsEvent {
 int id;
  AllDoctorEvent(this.id);
  
  @override

  List<Object?> get props => throw UnimplementedError();
}