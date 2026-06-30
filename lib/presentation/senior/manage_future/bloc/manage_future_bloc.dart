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
            // 1️⃣ فحص المطابقة مع حالة الخطة الحالية
            final bool aMatches = a.flag.flag == UserInfo.statusPlan;
            final bool bMatches = b.flag.flag == UserInfo.statusPlan;

            // 🚀 التعديل هنا: جعل العناصر المطابقة تنزل لأسفل القائمة (العكس)
            if (aMatches && !bMatches) return -1;  // a ينزل للأسفل
            if (!aMatches && bMatches) return 1; // b ينزل للأسفل

            // 2️⃣ إذا تساويا في التطابق، نلتزم بالترتيب السابق تصاعدياً بدون أي تغيير
            return a.flag.flag.compareTo(b.flag.flag);
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
