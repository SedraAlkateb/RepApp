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
class SenAllBrandEvent extends SeniorProfEvent{
  final  int id;
  @override
  SenAllBrandEvent(this.id);
  List<Object?> get props => [id];

}
class getInfoRepEvent extends SeniorProfEvent{
  final  int id;
  @override
  getInfoRepEvent(this.id);
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
class SenSearchBrandEvent extends SeniorProfEvent{
  final String contant;
  SenSearchBrandEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}

class SenSearchVisitDoctorEvent extends SeniorProfEvent{
  final String contant;
  SenSearchVisitDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}


class NoVisitDocEvent extends SeniorProfEvent{
  final  int id;
  final int planId;
  @override
  NoVisitDocEvent(this.id,this.planId);
  List<Object?> get props => [id,planId];

}
class RemainingVisitsDocEvent extends SeniorProfEvent{
  final  int id;
  final int planId;
  @override
  RemainingVisitsDocEvent(this.id,this.planId);
  List<Object?> get props => [id];

}
class VisitDocEvent extends SeniorProfEvent{
  final  int id;
  final  int planId;

  @override
  VisitDocEvent(this.id , this.planId);
  List<Object?> get props => [id];

}

class AllReciEvent extends SeniorProfEvent{
  final int id;
  @override
  AllReciEvent(this.id);
  List<Object?> get props => [id];

}
class GetRepReciEvent extends SeniorProfEvent {
  final int reciId;
  final bool isDoctor;//1 doctor /// 2 hospital
  final String name;
  GetRepReciEvent(this.reciId,this.isDoctor,this.name);
  @override

  List<Object?> get props => [reciId,isDoctor,name];
}
