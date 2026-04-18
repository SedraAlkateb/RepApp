import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/senior_by_cityid_usecase.dart';
import 'package:domina_app/domain/usecase/team_leader_and_city_usecase.dart';
import 'package:equatable/equatable.dart';

part 'general_reports_event.dart';
part 'general_reports_state.dart';

class GeneralReportsBloc extends Bloc<GeneralReportsEvent, GeneralReportsState> {
      List<SeniorCityModel> dataseniors = [];
        List<SeniorCityModel> dataseniorsbycityid = [];
      SeniorByCityIdUsecase seniorbycityidUsecase;
      TeamLeaderAndCityUsecase teamLeaderAndCityUsecase;
  GeneralReportsBloc(this.seniorbycityidUsecase, this.teamLeaderAndCityUsecase) : super(GeneralReportsInitial()) {
    on<GeneralReportsEvent>((event, emit)async {
      if (event is GetSeniorByCityIdEvent) {
          emit(const SeniorByCityIdLoadingState());
        (await seniorbycityidUsecase.execute(event.cityId)).fold(
            (failure) {
          emit(SeniorByCityIdErrorState(failure: failure));
          return false;
        }, (data) async {
              emit(const SeniorByCityIdEmptyState());
           if (data.isEmpty) {
              emit(const SeniorByCityIdEmptyState());
            } else{
       dataseniorsbycityid = data;
          emit(SeniorByCityIdState(data));
            }
   
        }
        );
      }else  if (event is TeamLeaderAndCityEvent) {
          emit(const TeamLeaderAndCityLoadingState());
        (await teamLeaderAndCityUsecase.execute()).fold(
            (failure) {
          emit(TeamLeaderAndCityErrorState(failure: failure));
          return false;
        }, (data) async {
          dataseniors = data;
          emit(TeamLeaderAndCityState(data));
        }
        );
      }
    });
  }
}
