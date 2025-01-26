part of 'senior_prof_bloc.dart';

@immutable
abstract class SeniorProfEvent extends Equatable{}

class SenAllPlaceEvent extends SeniorProfEvent{
  final  int id;
  @override
  SenAllPlaceEvent(this.id);
  List<Object?> get props => [id];

}
class SenAllHospitalEvent extends SeniorProfEvent{
  final  int id;
  @override
  SenAllHospitalEvent(this.id);
  List<Object?> get props => [id];

}
class SenAllDoctorEvent extends SeniorProfEvent{
  final  int id;
  @override
  SenAllDoctorEvent(this.id);
  List<Object?> get props => [id];
}
class SenAllSpecEvent extends SeniorProfEvent{
  final  int id;
  @override
  SenAllSpecEvent(this.id);
  List<Object?> get props => [id];

}
class SenSearchSpecEvent extends SeniorProfEvent{
  final String contant;
  SenSearchSpecEvent(this.contant);
  @override
  List<Object?> get props => [contant];

}
class SenSearchHospEvent extends SeniorProfEvent{
  final String contant;
  SenSearchHospEvent(this.contant);
  @override
  List<Object?> get props => [contant];

}
class SenSearchDoctorEvent extends SeniorProfEvent{
  final String contant;
  SenSearchDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}
class SenSearchNoVisitDoctorEvent extends SeniorProfEvent{
  final String contant;
  SenSearchNoVisitDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];

}

class SenSearchNoteDoctorEvent extends SeniorProfEvent{
  final String contant;
  SenSearchNoteDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];

}
class SenSearchVisitDoctorEvent extends SeniorProfEvent{
  final String contant;
  SenSearchVisitDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}
class SenAllNoteDoctorEvent extends SeniorProfEvent{
  final  int id;
  @override
  SenAllNoteDoctorEvent(this.id);
  List<Object?> get props => [id];

}

class NoVisitDocEvent extends SeniorProfEvent{
  final  int id;
  @override
  NoVisitDocEvent(this.id);
  List<Object?> get props => [id];

}
class VisitDocEvent extends SeniorProfEvent{
  final  int id;
  @override
  VisitDocEvent(this.id);
  List<Object?> get props => [id];

}