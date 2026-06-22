import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/mapper/mapper.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/plan_brand_usecase.dart';
import 'package:domina_app/domain/usecase/rep_plan_brand_sp_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'plan_management_event.dart';
part 'plan_management_state.dart';

class PlanManagementBloc
    extends Bloc<PlanManagementEvent, PlanManagementState> {
  final RepPlanBrandSpUsecase repPlanBrandSpUsecase;
  final PlanBrandUsecase planBrandUsecase;
  PlanManagementBloc(this.repPlanBrandSpUsecase, this.planBrandUsecase)
      : super(const PlanManagementState()) {
    on<RepPlanBrandSpEvent>(_onFetchBrands);
    on<UpdateBrandQuantityEvent>(_onUpdateQuantity);
    on<SubmitPlanEvent>(_onSubmitPlan);
  }

  // 1. جلب البيانات من الـ API
  Future<void> _onFetchBrands(
      RepPlanBrandSpEvent event, Emitter<PlanManagementState> emit) async {
    emit(state.copyWith(status: PlanStatus.loading));

    final result = await repPlanBrandSpUsecase.execute(event.rep);

    result.fold(
      (failure) =>
          emit(state.copyWith(status: PlanStatus.error, failure: failure)),
      (data) {
        // تأكد أن موديل PlanBrandSp يحتوي على متغير للكمية (مثلاً: quantity)
        emit(state.copyWith(
            status: PlanStatus.success, brands: data?.planBrandSps ?? []));
      },
    );
  }

  // 2. تحديث الكمية محلياً في الذاكرة فوراً وبسرعة فائقة
  void _onUpdateQuantity(
      UpdateBrandQuantityEvent event, Emitter<PlanManagementState> emit) {
    // ننشئ نسخة جديدة من المصفوفة لتجنب تعديل الـ Reference القديم في الذاكرة
    final updatedList = List<PlanBrandSp>.from(state.brands);

    // نقوم بتحديث العنصر المحدد (تأكد من إضافة حقل quantity داخل موديل PlanBrandSp الخاص بك)
    // إذا كان الموديل immutable، يفضل أن يحتوي على دالة copyWith أيضاً
    updatedList[event.index] =
        updatedList[event.index].copyWith(totalAmount: event.quantity);

    emit(state.copyWith(brands: updatedList));
  }

  // 3. الموافقة النهائية
  Future<void> _onSubmitPlan(
      SubmitPlanEvent event, Emitter<PlanManagementState> emit) async {
    emit(state.copyWith(status: PlanStatus.submitting));

    // هنا البيانات النهائية الجاهزة للإرسال مع الكميات المحدثة
    final finalDataToSend = state.brands;

    try {
      await planBrandUsecase.execute(RepPlanBrandBody(
          finalDataToSend.toDomain(UserInfo.otherPlanId ?? -1),
          (UserInfo.repType == "5"
              ? 1
              : UserInfo.repType == "4"
                  ? 2
                  : UserInfo.repType == "6"
                      ? 5
                      : -6)));

      emit(state.copyWith(status: PlanStatus.submitSuccess));
    } catch (e) {
      emit(state.copyWith(status: PlanStatus.error));
    }
  }
}
