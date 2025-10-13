part of 'pharmacy_bloc.dart';

@immutable
sealed class PharmacyEvent extends Equatable {}
class AllPharmacyEvent extends PharmacyEvent{

  @override
  AllPharmacyEvent();
  List<Object?> get props => [];

}

class SearchphEvent extends PharmacyEvent {
  final String contant;
  SearchphEvent(this.contant);
  @override
  List<Object?> get props => [contant];



}
