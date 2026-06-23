import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/mapper/mapper.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_usecase.dart';
import 'package:domina_app/domain/usecase/check_active_brand_plan_sql_usecase.dart';
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
  final CheckActiveBrandPlanUsecase  checkActiveBrandPlanUsecase;
  final AllPlanBrandsUsecase allPlanBrandsUsecase;
  PlanManagementBloc(this.repPlanBrandSpUsecase, this.planBrandUsecase,this.checkActiveBrandPlanUsecase,this.allPlanBrandsUsecase)
      : super(const PlanManagementState()) {
    on<RepPlanBrandSpEvent>(_onFetchBrands);
    on<UpdateBrandQuantityEvent>(_onUpdateQuantity);
    on<SubmitPlanEvent>(_onSubmitPlan);
    on<GetRepInfoEvent>(_getRepInfo);
    on<RepActivePlanBrandEvent>(_onActiveFetchBrands);
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
            status: PlanStatus.success, brands: data?.planBrandSps ?? [],isEnable: UserInfo.otherstatus==UserInfo.statusPlan));
      },
    );
  }
  Future<void> _onActiveFetchBrands(
      RepActivePlanBrandEvent event, Emitter<PlanManagementState> emit) async {
    emit(state.copyWith(status: PlanStatus.loading));

    final result = await allPlanBrandsUsecase.execute(Rep(UserInfo.activePlanId, 0));
    result.fold(
          (failure) =>
          emit(state.copyWith(status: PlanStatus.error, failure: failure)),
          (data) {
        // تأكد أن موديل PlanBrandSp يحتوي على متغير للكمية (مثلاً: quantity)
        emit(state.copyWith(
            status: PlanStatus.success, brands: data.toDomain(),isEnable: UserInfo.otherstatus==UserInfo.statusPlan));
      },
    );
  }

// 1. جلب بيانات المندوب وحالة الخطة الحالية من الـ API
  Future<void> _getRepInfo(
      GetRepInfoEvent event, Emitter<PlanManagementState> emit) async {
    emit(state.copyWith(status: PlanStatus.loading));

    // استدعاء الـ Usecase المخصص للتحقق من الخطة النشطة بناءً على معرف المندوب
    final result = await checkActiveBrandPlanUsecase.execute(UserInfo.repId);

    result.fold(
          (failure) =>
          emit(state.copyWith(status: PlanStatus.error, failure: failure)),
          (data) {
        // 💡 هنا نقوم بصب البيانات القادمة وتحديث قيم الـ UserInfo محلياً
        // يفترض أن 'data' تعود بـ LoginModel أو كائن يحتوي على تفاصيل خطة المندوب

        UserInfo.activePlanId = data.activePlanId??-1;
        UserInfo.otherPlanId = data.otherPlanId;
        UserInfo.otherstatus = data.otherStatus; // حالة الخطة (مفتوحة 0 أو مغلقة)
        UserInfo.repType = data.repType; // حالة الخطة (مفتوحة 0 أو مغلقة)
        UserInfo.endDate = data.endDate; // حالة الخطة (مفتوحة 0 أو مغلقة)
        UserInfo.startDate = data.startDate; // حالة الخطة (مفتوحة 0 أو مغلقة)
        UserInfo.initializeUserPlan();
        add(RepPlanBrandSpEvent(RepSp(UserInfo.otherPlanId ?? -1, 38, UserInfo.repId)));

        emit(state.copyWith(status: PlanStatus.success));
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
      int status= (UserInfo.repType == "5"
          ? 1
          : UserInfo.repType == "4"
          ? 2
          : UserInfo.repType == "6"
          ? 5
          : -6);
      await planBrandUsecase.execute(RepPlanBrandBody(
          finalDataToSend.toDomain(UserInfo.otherPlanId ?? -1),status
         ));
UserInfo.otherstatus=status;
      emit(state.copyWith(status: PlanStatus.submitSuccess,isEnable: UserInfo.otherstatus==UserInfo.statusPlan));
    } catch (e) {
      emit(state.copyWith(status: PlanStatus.error));
    }
  }
}
