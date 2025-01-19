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
