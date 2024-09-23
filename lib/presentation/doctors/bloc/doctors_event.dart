part of 'doctors_bloc.dart';

abstract class DoctorsEvent extends Equatable {
  const DoctorsEvent();



}
class AllDoctorEvent extends DoctorsEvent {


  @override

  List<Object?> get props => throw UnimplementedError();
}

class SearchDocEvent extends DoctorsEvent {
  final String contant;
  SearchDocEvent(this.contant);
  @override
  List<Object?> get props => [contant];



}
