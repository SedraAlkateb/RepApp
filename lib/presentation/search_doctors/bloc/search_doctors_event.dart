part of 'search_doctors_bloc.dart';

@immutable
sealed class SearchDoctorsEvent extends Equatable {}
class FutureSearchDocEvent extends SearchDoctorsEvent {
  final String name;
  FutureSearchDocEvent(this.name);
  @override
  List<Object?> get props => [name];
}
class FutureDocDoctorsEvent extends SearchDoctorsEvent {
  final int docId;
  FutureDocDoctorsEvent(this.docId);
  @override
  List<Object?> get props => [docId];
}