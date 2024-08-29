part of 'place_bloc.dart';

@immutable
abstract class PlaceEvent  extends Equatable{}
class AllPlaceEvent extends PlaceEvent{
  @override
 final int id;
  AllPlaceEvent(this.id);
  List<Object?> get props => [id];

}
