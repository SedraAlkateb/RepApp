part of 'reci_bloc.dart';

@immutable
sealed class ReciEvent extends Equatable{}
class AllReciEvent extends ReciEvent{
  @override
  AllReciEvent();
  List<Object?> get props => [];

}
class GetReciEvent extends ReciEvent{
 final String id;
  @override
  GetReciEvent(this.id);
  List<Object?> get props => [];

}