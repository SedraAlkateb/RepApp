part of 'place_bloc.dart';

@immutable
abstract class PlaceEvent  extends Equatable{}
class AllPlaceEvent extends PlaceEvent{
  @override
  AllPlaceEvent();
  List<Object?> get props => [];

}
class NumVisitEvent extends PlaceEvent{
  @override
  NumVisitEvent();
  List<Object?> get props => [];

}
class CheckRepEvent extends PlaceEvent{
  @override
  CheckRepEvent();
  List<Object?> get props => [];

}
class SearchPlaceEvent extends PlaceEvent{

  final String value;
  SearchPlaceEvent({required this.value});
  @override

  List<Object?> get props => [];

}
class NumEvent extends PlaceEvent{

  NumEvent();
  @override

  List<Object?> get props => [];

}
class DoctorArchiveByPlace extends PlaceEvent{
  final  int placeId;
  final current;
  DoctorArchiveByPlace(this.placeId,this.current);
  @override
  List<Object?> get props => [placeId,current];
}
class HospitalArchiveByPlace extends PlaceEvent{
  final  int placeId;
  final current;
  HospitalArchiveByPlace(this.placeId,this.current);
  @override
  List<Object?> get props => [placeId,current];
}
class SearchDoctorArchive extends PlaceEvent{
  final  String search;
  final List<DoctorModel> doctors;
  SearchDoctorArchive(this.search,this.doctors);
  @override
  List<Object?> get props => [search,];
}
class SearchHospitalArchive extends PlaceEvent{
  final  String search;
  final List<HospitalModel> hospital;

  SearchHospitalArchive(this.search,this.hospital);
  @override
  List<Object?> get props => [search];
}