part of 'future_rep_bloc.dart';

@immutable
sealed class FutureRepEvent extends Equatable {}

class FutureSpEvent extends FutureRepEvent {
  final int id;
  FutureSpEvent(this.id);
  @override
  List<Object?> get props => [];
}

class FutureSearchSpecEvent extends FutureRepEvent {
  final String contan;
  FutureSearchSpecEvent(this.contan);
  @override
  List<Object?> get props => [contan];
}

class FutureGetPlanBrandEvent extends FutureRepEvent {
  final Rep rep;
  FutureGetPlanBrandEvent(this.rep);
  @override
  List<Object?> get props => [rep];
}
class FutureChangePlanBrandTypeEvent extends FutureRepEvent {
  final int id;
  final int brandType;

  @override
  FutureChangePlanBrandTypeEvent(this.id, this.brandType);
  List<Object?> get props => [id, brandType];
}
