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

class DoctorSpEvent extends SpecializationEvent{
  final int sp;
  DoctorSpEvent(this.sp);
  @override
  List<Object?> get props => [sp];

}
class HospitalSpEvent extends SpecializationEvent{
  final int sp;
  HospitalSpEvent(this.sp);
  @override
  List<Object?> get props => [sp];

}