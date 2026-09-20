import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/get_info_plan_brands_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'active_plan_event.dart';
part 'active_plan_state.dart';

class ActivePlanBloc extends Bloc<ActivePlanEvent, ActivePlanState> {
  List<ActivePlanBrandModel> activePlan = [];
  List<ActivePlanBrandModel> activePlanSearch = [];
  GetInfoPlanBrandsUsecase getInfoPlanBrandsUsecase;
  ActivePlanBloc(this.getInfoPlanBrandsUsecase)
      : super(ActivePlanBlocInitial()) {
    on<GetActivePlanEvent>((event, emit) async {
      emit(AllActivePlanLoadingState());
      (await getInfoPlanBrandsUsecase.execute(event.index, status: 0)).fold(
          (failure) {
        emit(AllActivePlanErrorState(failure: failure));
        return false;
      }, (data) async {
        final updatedData = data.map((brand) {
          int sum = 0;

          for (var plan in brand.spPlan) {
            // تحويل النص إلى رقم وحسابه، وإذا كانت القيمة ليست رقمية يتم تجاهلها (تعتبر 0)
            sum += int.tryParse(plan.amount) ?? 0;
          }

          // إسناد المجموع إلى متغيّر total
          brand.total = sum;

          return brand;
        }).toList();
        activePlan = updatedData;

        activePlanSearch = updatedData;
        emit(AllActivePlanState(data));
      });
    });

    on<SearchActivePlanEvent>((event, emit) async {
      final String search = normalizeText(event.search);

      activePlanSearch = activePlan.where((value) {
        if (normalizeText(value.title).contains(search)) {
          return true;
        } else if (value.spPlan.any(
          (specialty) => normalizeText(specialty.name).contains(search),
        )) {
          return true;
        } else if (normalizeText(value.pharmaceuticalFormTitle)
            .contains(search)) {
          return true;
        } else if (normalizeText(value.type.name).contains(search)) {
          return true;
        }
        return false;
      }).toList();

      emit(AllActivePlanState(activePlanSearch));
    });
  }
}
