part of 'general_reports_bloc.dart';

sealed class GeneralReportsEvent extends Equatable {
  const GeneralReportsEvent();

 @override
 List<Object?> get props => [];
}
class GetSeniorByCityIdEvent extends GeneralReportsEvent{
final  int cityId;
 const GetSeniorByCityIdEvent(this.cityId);
  @override
 List<Object?> get props => [cityId];

}
class TeamLeaderAndCityEvent extends GeneralReportsEvent {

 const TeamLeaderAndCityEvent();
  @override
  List<Object?> get props => [];
}
