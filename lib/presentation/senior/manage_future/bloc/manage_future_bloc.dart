import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_reps_future_usecase.dart';
import 'package:domina_app/domain/usecase/change_rep_plan_status.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'manage_future_event.dart';
part 'manage_future_state.dart';

class ManageFutureBloc extends Bloc<ManageFutureEvent, ManageFutureState> {
  List<AllRepresentativeFuture> allRepresentative = [];
  AllRepsFutureUsecase allRepsFutureUsecase;
  ChangeRepPlanStatus changeRepPlanStatus;

  ManageFutureBloc(this.allRepsFutureUsecase,
      this.changeRepPlanStatus
      ) : super(ManageFutureInitial()) {
    on<ManageFutureEvent>((event, emit) async {

      if (event is AllSeniorRepFutureEvent) {
        emit(AllSeniorRepLoadingState());

        (await allRepsFutureUsecase.execute(UserInfo.repId)).fold((failure) {
          emit(AllSeniorRepErrorState(failure: failure));
        }, (data) async {
          data.sort((a, b) {
            // أوزان التيم ليدر (5 -> 0 -> 6 -> 1)
            int getTeamLeaderWeight(int flagValue) {
              switch (flagValue) {
                case 5: return 1;
                case 0: return 2;
                case 6: return 3;
                case 1: return 4;
                default: return 99;
              }
            }

            // أوزان السوبرفايزر (1 -> 5 -> 0 -> 6 -> 4)
            int getSupervisorWeight(int flagValue) {
              switch (flagValue) {
                case 1: return 1;
                case 5: return 2;
                case 0: return 3;
                case 6: return 4;
                case 4: return 5;
                default: return 99;
              }
            }
            int weightA = 0;
            int weightB = 0;
            if (UserInfo.repType.i == 5) {
              weightA = getTeamLeaderWeight(a.flag.flag);
              weightB = getTeamLeaderWeight(b.flag.flag);
            } else if (UserInfo.repType.i == 4) {
              weightA = getSupervisorWeight(a.flag.flag);
              weightB = getSupervisorWeight(b.flag.flag);
            } else {
              weightA = a.flag.flag;
              weightB = b.flag.flag;
            }
            return weightA.compareTo(weightB);
          });

          allRepresentative = data;
          emit(AllSeniorRepState(data));
        });
      }
      else if (event is SenSearchRepFutureEvent) {
        List<AllRepresentativeFuture> allRepresentativeModel = [];
        String search = normalizeText(event.contant);
        allRepresentativeModel = allRepresentative.where((value) {
          if (normalizeText(value.name).contains(search)) {
            return true;
          }
          return false;
        }).toList();
        emit(AllSeniorRepState(allRepresentativeModel));
      }
      else if (event is ChangPlanStatusEvent) {
        emit(ChangPlanStatusLoadingState());
        (await changeRepPlanStatus.execute(event.id,event.brandType)).fold((failure) {
          emit(ChangPlanStatusErrorState(failure: failure));
        }, (data) async {
              allRepresentative[event.index].flag=FlagModel(event.brandType);
          emit(ChangPlanStatusState(allRepresentative));
        });
      }
    });
  }
}
