part of 'specialization_bloc.dart';

@immutable
abstract class SpecializationEvent extends Equatable {}
class SpecEvent extends SpecializationEvent{
  SpecEvent();
  @override
  List<Object?> get props => [];

}
class SearchSpecEvent extends SpecializationEvent{
  final String contan;
  SearchSpecEvent(this.contan);
  @override
  List<Object?> get props => [contan];

}