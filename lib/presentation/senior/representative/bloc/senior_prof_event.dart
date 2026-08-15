part of 'senior_prof_bloc.dart';

@immutable
abstract class SeniorProfEvent extends Equatable {}

class SenAllPlaceEvent extends SeniorProfEvent {
  final int id;
  @override
  SenAllPlaceEvent(this.id);
  List<Object?> get props => [id];
}

class SenAllHospitalEvent extends SeniorProfEvent {
  final int id;
  @override
  SenAllHospitalEvent(this.id);
  List<Object?> get props => [id];
}

class SenAllBrandEvent extends SeniorProfEvent {
  final int id;
  @override
  SenAllBrandEvent(this.id);
  List<Object?> get props => [id];
}

class getInfoRepEvent extends SeniorProfEvent {
  final int id;
  final int planId;
  @override
  getInfoRepEvent(this.id, this.planId);
  List<Object?> get props => [id, planId];
}

class SenAllDoctorEvent extends SeniorProfEvent {
  final int id;
  @override
  SenAllDoctorEvent(this.id);
  List<Object?> get props => [id];
}

class SenAllSpecEvent extends SeniorProfEvent {
  final int id;
  @override
  SenAllSpecEvent(this.id);
  List<Object?> get props => [id];
}

class LogoutDeleteAllEvent extends SeniorProfEvent {
  @override
  List<Object?> get props => [];
}

class SenSearchSpecEvent extends SeniorProfEvent {
  final String contant;
  SenSearchSpecEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}
class SearchSenAllPlaceEvent extends SeniorProfEvent {
  final String contant;
  final List<PlaceModel> places;

  SearchSenAllPlaceEvent(this.contant,this.places);
  @override
  List<Object?> get props => [contant,places];
}
class SearchDocHosEvent extends SeniorProfEvent {
  final String content;

  /// 0 = doctors
  /// 1 = hospitals
  final int tabIndex;

  /// القوائم الأصلية وليست نتيجة بحث سابقة
  final List<DoctorSenModel> doctors;
  final List<HospitalSpModel> hospitals;

  SearchDocHosEvent({
    required this.content,
    required this.tabIndex,
    required this.doctors,
    required this.hospitals,
  });

  @override
  List<Object?> get props => [
    content,
    tabIndex,
    doctors,
    hospitals,
  ];
}
class SenSearchHospEvent extends SeniorProfEvent {
  final String contant;
  SenSearchHospEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}

class SenSearchDoctorEvent extends SeniorProfEvent {
  final String contant;
  SenSearchDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}

class SenSearchNoVisitDoctorEvent extends SeniorProfEvent {
  final String contant;
  SenSearchNoVisitDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}

class SenSearchRemainingVisitsDoctorEvent extends SeniorProfEvent {
  final String contant;
  SenSearchRemainingVisitsDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}

class SenSearchBrandEvent extends SeniorProfEvent {
  final String contant;
  SenSearchBrandEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}

class SenSearchVisitDoctorEvent extends SeniorProfEvent {
  final String contant;

  SenSearchVisitDoctorEvent(this.contant);
  @override
  List<Object?> get props => [contant];
}

class NoVisitDocEvent extends SeniorProfEvent {
  final int id;
  final int planId;
  @override
  NoVisitDocEvent(this.id, this.planId);
  List<Object?> get props => [id, planId];
}

class NoVisitHosEvent extends SeniorProfEvent {
  final int id;
  final int planId;
  @override
  NoVisitHosEvent(this.id, this.planId);
  List<Object?> get props => [id, planId];
}

class RemainingVisitsDocEvent extends SeniorProfEvent {
  final int id;
  final int planId;
  @override
  RemainingVisitsDocEvent(this.id, this.planId);
  List<Object?> get props => [id];
}

class RemainingVisitsHosEvent extends SeniorProfEvent {
  final int id;
  final int planId;
  @override
  RemainingVisitsHosEvent(this.id, this.planId);
  List<Object?> get props => [id];
}

class VisitDocEvent extends SeniorProfEvent {
  final int id;
  final int planId;

  @override
  VisitDocEvent(this.id, this.planId);
  List<Object?> get props => [id];
}

class VisitHosEvent extends SeniorProfEvent {
  final int id;
  final int planId;

  @override
  VisitHosEvent(this.id, this.planId);
  List<Object?> get props => [id];
}

class AllReciEvent extends SeniorProfEvent {
  final int id;
  @override
  AllReciEvent(this.id);
  List<Object?> get props => [id];
}

class GetRepReciEvent extends SeniorProfEvent {
  final int reciId;
  final bool isDoctor; //1 doctor /// 2 hospital
  final String name;
  GetRepReciEvent(this.reciId, this.isDoctor, this.name);
  @override
  List<Object?> get props => [reciId, isDoctor, name];
}

class DocHosEvent extends SeniorProfEvent {
  final int repDet;
  final int? spId;
  final int? placeId;

  DocHosEvent(this.repDet, {this.spId, this.placeId});
  @override
  List<Object?> get props => [repDet, spId,placeId];
}
