part of 'place_bloc.dart';

@immutable
abstract class PlaceEvent  extends Equatable{}
class AllPlaceEvent extends PlaceEvent{
  @override
  AllPlaceEvent();
  List<Object?> get props => [];

}
class SearchPlaceEvent extends PlaceEvent{

  final String value;
  SearchPlaceEvent({required this.value});
  @override

  List<Object?> get props => [];

}
