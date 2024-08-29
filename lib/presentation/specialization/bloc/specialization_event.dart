part of 'specialization_bloc.dart';

@immutable
abstract class SpecializationEvent extends Equatable {}
class SpecEvent extends SpecializationEvent{
  int id;
  SpecEvent(this.id);
  @override
  List<Object?> get props => [];

}
