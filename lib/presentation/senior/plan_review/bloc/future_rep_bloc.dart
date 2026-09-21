import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_spec_usecase.dart';
import 'package:domina_app/domain/usecase/change_rep_plan_status.dart';
import 'package:domina_app/domain/usecase/doc_sp_search_usecase.dart';
import 'package:domina_app/domain/usecase/hos_sp_search_usecase.dart';
import 'package:domina_app/domain/usecase/rep_plan_brand_sp_usecase.dart';
import 'package:domina_app/domain/usecase/update_rep_plan_brand_amount.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'future_rep_event.dart';
part 'future_rep_state.dart';

class FutureRepBloc extends Bloc<FutureRepEvent, FutureRepState> {
  final AllSpeUsecase allSpeUsecase;
  final RepPlanBrandSpUsecase repPlanBrandSpUsecase;
  final UpdateRepPlanBrandAmount updateRepPlanBrandAmount;
  final ChangeRepPlanStatus changeRepPlanStatus;
  final DocSpSearchUsecase docSpSearchUsecase;
  final HosSpSearchUsecase hosSpSearchUsecase;
  int sumBrandsAmount = 0;
  List<SpecDModel> specialization = [];
  AllPlanBrandSp planBrandSp = AllPlanBrandSp([], 0, BrandAmountModel(0, 0, 0));
  List<BrandAmountRequestModel> planBrandSpSend = [];
  SumBrandAmountModel sumTargetAss = SumBrandAmountModel(0, 0, 0);
  int baseAmount = 0;
  int calculatedMaxAmount = 0;
  int percent = 0;
  int sampleCount = 0;
  FutureRepBloc(
    this.allSpeUsecase,
    this.repPlanBrandSpUsecase,
    this.updateRepPlanBrandAmount,
    this.changeRepPlanStatus,
    this.docSpSearchUsecase,
    this.hosSpSearchUsecase,
  ) : super(FutureRepInitial()) {
    on<FutureSpEvent>(_onFutureSp);
    on<FutureSearchSpecEvent>(_onFutureSearchSpec);
    on<SearchPlanBrandsEvent>(_onSearchPlanBrands);
    on<FutureRepPlanBrandSpEvent>(_onFutureRepPlanBrandSp);
    on<ChangeFieldEvent>(_onChangeField);
    on<UpdateAmountEvent>(_onUpdateAmount);
    on<EditePlanStatusEvent>(_onEditePlanStatus);
    on<DocSpSearchEvent>(_onGetDocSpSearch);
    on<HosSpSearchEvent>(_onGetHosSpSearch);
  }

  Future<void> _onFutureSp(
    FutureSpEvent event,
    Emitter<FutureRepState> emit,
  ) async {
    specialization = [];
    emit(FutureSpRepLoadingState());

    final result = await allSpeUsecase.execute(event.id, planId: event.planId);
    result.fold(
      (failure) => emit(FutureSpRepErrorState(failure: failure)),
      (data) {
        planBrandSpSend = [];
        specialization = data;
        emit(FutureSpRepState(data));
      },
    );
  }

  void _onFutureSearchSpec(
    FutureSearchSpecEvent event,
    Emitter<FutureRepState> emit,
  ) {
    final search = normalizeText(event.contan);
    final specializationSearch = specialization.where((value) {
      return normalizeText(value.title).contains(search);
    }).toList();

    emit(FutureSpRepState(specializationSearch));
  }

  void _onSearchPlanBrands(
    SearchPlanBrandsEvent event,
    Emitter<FutureRepState> emit,
  ) {
    final search = normalizeText(event.contant);
    final planBrandSp2 = planBrandSp.planBrandSps.where((value) {
      return normalizeText(value.titleAr).contains(search) ||
          normalizeText(value.brandType.name).contains(search) ||
          normalizeText(value.phTitle).contains(search);
    }).toList();

    emit(FutureRepPlanBrandSpState(
      planBrandSp2,
      planBrandSp.brandAmountModel,
      sumTargetAss,
    ));
  }

  Future<void> _onFutureRepPlanBrandSp(
    FutureRepPlanBrandSpEvent event,
    Emitter<FutureRepState> emit,
  ) async {
    sumTargetAss = SumBrandAmountModel(0, 0, 0);
    planBrandSp = AllPlanBrandSp([], 0, BrandAmountModel(0, 0, 0));
    emit(FutureRepPlanBrandSpLoadingState());

    final result = await repPlanBrandSpUsecase.execute(event.rep);
    result.fold(
      (failure) => emit(FutureRepPlanBrandSpErrorState(failure: failure)),
      (data) {
        if (data == null) return;
        sampleCount = event.sampleCount;
        percent = event.percent ?? 0;
        planBrandSp = data;
        baseAmount = data.amount;
        calculatedMaxAmount = data.amount * event.sampleCount;

        if (data.planBrandSps.isEmpty) {
          emit(FutureRepPlanBrandSpEmptyState(data));
        } else {
          for (var item in data.planBrandSps) {
            final amount = item.totalAmount;
            if (item.brandType.i == 2) {
              sumTargetAss.assistantAmount += amount;
            } else {
              sumTargetAss.targetAmount += amount;
            }
            sumTargetAss.totalAmount += amount;
          }

          sumBrandsAmount = _sumBrandAmount(data.planBrandSps);
          emit(FutureRepPlanBrandSpState(
            data.planBrandSps,
            data.brandAmountModel,
            sumTargetAss,
          ));
        }
      },
    );
  }

  void _onChangeField(
    ChangeFieldEvent event,
    Emitter<FutureRepState> emit,
  ) {
// البحث عن العنصر باستخدام itemId بدلاً من index
    final targetIndex = planBrandSp.planBrandSps.indexWhere(
      (item) => item.id == event.itemId,
    );

    // إذا لم يتم العثور على العنصر تجنب متابعة التنفيذ
    if (targetIndex == -1) return;

    final targetItem = planBrandSp.planBrandSps[targetIndex];

    // التحقق من حد المندوب في حال كان repType == 7
    // التخفيض مسموح دائماً حتى لو بقي الاختصاص متجاوزاً للحد،
    // حتى يتمكن المستخدم من النزول تدريجياً والعودة تحت الحد
    if (UserInfo.repType == 7) {
      int sumF = sumBrandsAmount - targetItem.totalAmount + event.number;

      if (sumF > planBrandSp.amount && event.number > targetItem.totalAmount) {
        emit(SumErrorState(
          failure: Failure(4, "لقد تجاوزت الحد المسموح لهذا الاختصاص"),
        ));
        return;
      }
      sumBrandsAmount = sumF;
    }

    // إعادة حساب مجاميع الأصناف (هدف / مساعد) بعد اجتياز التحقق
    if (targetItem.brandType.i == 1) {
      sumTargetAss.targetAmount =
          sumTargetAss.targetAmount - targetItem.totalAmount + event.number;
    } else {
      sumTargetAss.assistantAmount =
          sumTargetAss.assistantAmount - targetItem.totalAmount + event.number;
    }
    sumTargetAss.totalAmount =
        sumTargetAss.totalAmount - targetItem.totalAmount + event.number;

    // تحديث الكمية في القائمة الأصلية
    targetItem.totalAmount = event.number;

    // تحديث العناصر المجهزة للإرسال
    final existingIndex = planBrandSpSend.indexWhere(
      (item) => item.id == targetItem.id,
    );

    if (existingIndex == -1) {
      planBrandSpSend.add(BrandAmountRequestModel(
        targetItem.id,
        targetItem.totalAmount,
      ));
    } else {
      planBrandSpSend[existingIndex].amount = targetItem.totalAmount;
    }

    emit(AmountState(
      sumTargetAss.targetAmount,
      sumTargetAss.assistantAmount,
      sumTargetAss.totalAmount,
    ));
  }

  Future<void> _onUpdateAmount(
    UpdateAmountEvent event,
    Emitter<FutureRepState> emit,
  ) async {
    if (planBrandSpSend.isNotEmpty) {
      emit(UpdateAmountLoadingState());

      final result = await updateRepPlanBrandAmount.execute(
        BrandAmountRequestBody(planBrandSpSend),
      );

      result.fold(
        (failure) => emit(FutureSpRepErrorState(failure: failure)),
        (data) {
          emit(UpdateAmountState());
          planBrandSpSend = [];
        },
      );
    } else {
      emit(ISEmptyState());
    }
  }

  Future<void> _onEditePlanStatus(
    EditePlanStatusEvent event,
    Emitter<FutureRepState> emit,
  ) async {
    emit(EditeStatusLoadingState());

    final result = await changeRepPlanStatus.execute(event.id, event.status);

    result.fold(
      (failure) => emit(EditeStatusFailureState(failure: failure)),
      (data) => emit(EditeStatusState()),
    );
  }

  Future<void> _onGetHosSpSearch(
    HosSpSearchEvent event,
    Emitter<FutureRepState> emit,
  ) async {
    emit(DocHosSpSearchLoadingState());

    final result =
        await hosSpSearchUsecase.execute(event.repPlanId, event.spId);

    result.fold(
      (failure) => emit(DocHosSpSearchFailureState(failure: failure)),
      (data) => emit(DocHosSpSearchState(data)),
    );
  }

  Future<void> _onGetDocSpSearch(
    DocSpSearchEvent event,
    Emitter<FutureRepState> emit,
  ) async {
    emit(DocHosSpSearchLoadingState());

    final result =
        await docSpSearchUsecase.execute(event.repPlanId, event.spId);

    result.fold(
      (failure) => emit(DocHosSpSearchFailureState(failure: failure)),
      (data) => emit(DocHosSpSearchState(data)),
    );
  }

  int _sumBrandAmount(List<PlanBrandSp> planBrands) {
    return planBrands.fold(0, (sum, item) => sum + item.totalAmount);
  }
}
