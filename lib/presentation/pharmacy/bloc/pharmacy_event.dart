part of 'pharmacy_bloc.dart';

@immutable
sealed class PharmacyEvent extends Equatable {}
class AllPharmacyEvent extends PharmacyEvent{
 final int id;
  @override
  AllPharmacyEvent(this.id);
  List<Object?> get props => [id];

}
