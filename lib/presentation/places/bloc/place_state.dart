part of 'place_bloc.dart';

@immutable
abstract class PlaceState extends Equatable{}

final class PlaceInitial extends PlaceState {
  @override
  // TODO: implement props
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

final class SearchPlaceState extends PlaceState {
final List<PlaceModel> places;
  SearchPlaceState(this.places);
  @override
  List<Object?> get props =>[places];
}

////////////
final class CheckRepState extends PlaceState {
final bool isCheck;
  CheckRepState(this.isCheck);
  @override
  List<Object?> get props =>[isCheck];
}
final class CheckRepErrorState extends PlaceState {
  final Failure failure;
  CheckRepErrorState({required this.failure});
  @override

  List<Object?> get props =>[failure];
}
final class CheckRepLoadingState extends PlaceState {
  @override
  CheckRepLoadingState();
  @override
  List<Object?> get props =>[];
}