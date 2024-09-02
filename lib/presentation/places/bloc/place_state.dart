part of 'place_bloc.dart';

@immutable
abstract class PlaceState extends Equatable{}

final class PlaceInitial extends PlaceState {
  @override

  List<Object?> get props => throw UnimplementedError();
}
final class AllPlaceState extends PlaceState {
final List<PlaceModel> places;
  AllPlaceState(this.places);
  @override
  List<Object?> get props =>[places];
}
final class AllPlaceErrorState extends PlaceState {
  final Failure failure;
  AllPlaceErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class AllPlaceLoadingState extends PlaceState {
  @override
  AllPlaceLoadingState();
  @override
  List<Object?> get props =>[];
}