import 'package:bloc/bloc.dart';
import 'package:domina_app/app/user_info.dart';
import 'package:domina_app/data/mapper/mapper.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_plan_brands_usecase.dart';
import 'package:domina_app/domain/usecase/check_active_brand_plan_sql_usecase.dart';
import 'package:domina_app/domain/usecase/get_info_plan_brands_usecase.dart';
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
  GetInfoPlanBrandsUsecase getInfoPlanBrandsUsecase;
  PlanManagementBloc(this.repPlanBrandSpUsecase, this.planBrandUsecase,this.checkActiveBrandPlanUsecase,this.getInfoPlanBrandsUsecase)
      : super(const PlanManagementState()) {
    on<RepPlanBrandSpEvent>(_onFetchBrands);
    on<UpdateBrandQuantityEvent>(_onUpdateQuantity);
    on<SubmitPlanEvent>(_onSubmitPlan);
    on<GetRepInfoEvent>(_getRepInfo);
    on<RepActivePlanBrandEvent>(_onActiveFetchBrands);
    on<SearchPlanBrandEvent>(_onSearchBrands);
    on<SearchActivePlanBrandEvent>(_onSearchBrandsActive);

  }
  // 1. جلب البيانات من الـ API
  // Future<void> _onFetchBrands(
  //     RepPlanBrandSpEvent event, Emitter<PlanManagementState> emit) async {
  //   emit(state.copyWith(status: PlanStatus.loading));
  //
  //   final result = await repPlanBrandSpUsecase.execute(event.rep);
  //
  //   result.fold(
  //         (failure) =>
  //         emit(state.copyWith(status: PlanStatus.error, failure: failure)),
  //         (data) {
  //       // تأكد أن موديل PlanBrandSp يحتوي على متغير للكمية (مثلاً: quantity)
  //       emit(state.copyWith(
  //           status: PlanStatus.success, brands: data?.planBrandSps ?? [],isEnable: UserInfo.otherstatus==UserInfo.statusPlan));
  //     },
  //   );
  // }
  // Future<void> _onActiveFetchBrands(
  //     RepActivePlanBrandEvent event, Emitter<PlanManagementState> emit) async {
  //   emit(state.copyWith(status: PlanStatus.loading));
  //
  //   final result = await allPlanBrandsUsecase.execute(Rep(UserInfo.activePlanId, 0));
  //   result.fold(
  //         (failure) =>
  //         emit(state.copyWith(status: PlanStatus.error, failure: failure)),
  //         (data) {
  //       // تأكد أن موديل PlanBrandSp يحتوي على متغير للكمية (مثلاً: quantity)
  //       emit(state.copyWith(
  //           status: PlanStatus.success, brands: data.toDomain(),isEnable: UserInfo.otherstatus==UserInfo.statusPlan));
  //     },
  //   );
  // }

// 1. جلب بيانات المندوب وحالة الخطة الحالية من الـ API
  Future<void> _getRepInfo(
      GetRepInfoEvent event, Emitter<PlanManagementState> emit) async {
    emit(state.copyWith(futureStatus: PlanStatus.loading));

    // استدعاء الـ Usecase المخصص للتحقق من الخطة النشطة بناءً على معرف المندوب
    final result = await checkActiveBrandPlanUsecase.execute(UserInfo.repId);

    result.fold(
          (failure) =>
          emit(state.copyWith(futureStatus: PlanStatus.error, futureFailure: failure)),
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

        emit(state.copyWith(futureStatus: PlanStatus.success));
      },
    );
  }

  // 3. الموافقة النهائية
  Future<void> _onSubmitPlan(
      SubmitPlanEvent event, Emitter<PlanManagementState> emit) async {
    emit(state.copyWith(futureStatus: PlanStatus.submitting));

    // هنا البيانات النهائية الجاهزة للإرسال مع الكميات المحدثة
    final finalDataToSend = state.futureBrands;

    try {
      int status= (UserInfo.repType.i == 5
          ? 1
          : UserInfo.repType.i == 4
          ? 2
          : UserInfo.repType.i == 6
          ? 5
          : -6);
      await planBrandUsecase.execute(RepPlanBrandBody(
          finalDataToSend.toDomain(UserInfo.otherPlanId ?? -1),status
         ));
UserInfo.otherstatus=status;
      emit(state.copyWith(futureStatus: PlanStatus.submitSuccess,isEnable: UserInfo.otherstatus==UserInfo.statusPlan));
    } catch (e) {
      emit(state.copyWith(futureStatus: PlanStatus.error));
    }
  }

// 2. تحديث دالة جلب البيانات لتملأ القائمتين معاً في البداية:
  Future<void> _onFetchBrands(
      RepPlanBrandSpEvent event, Emitter<PlanManagementState> emit) async {
    emit(state.copyWith(futureStatus: PlanStatus.loading));
    final result = await repPlanBrandSpUsecase.execute(event.rep);
    result.fold(
          (failure) => emit(state.copyWith(futureStatus: PlanStatus.error, futureFailure: failure)),
          (data) {
        final list = data?.planBrandSps ?? [];
        emit(state.copyWith(
            futureStatus: PlanStatus.success,
            futureBrands: list,
            searchFutureBrands: list, // 👈 تملأ قائمة البحث أيضاً عند التحميل لأول مرة
            isEnable: UserInfo.otherstatus == UserInfo.statusPlan));
      },
    );
  }

// 3. تحديث دالة الـ Active أيضاً بنفس الطريقة:
  Future<void> _onActiveFetchBrands(
      RepActivePlanBrandEvent event, Emitter<PlanManagementState> emit) async {
    emit(state.copyWith(activeStatus: PlanStatus.loading));
    final result = await getInfoPlanBrandsUsecase.execute(UserInfo.activePlanId);
    result.fold(
          (failure) => emit(state.copyWith(activeStatus: PlanStatus.error, activeFailure: failure)),
          (data) {
        emit(state.copyWith(
            activeStatus: PlanStatus.success,
            activeBrands: data,
            searchActiveBrands: data, // 👈 تملأ قائمة البحث
            isEnable: UserInfo.otherstatus == UserInfo.statusPlan));
      },
    );
  }

// 4. دالة تحديث الكمية (إصلاح الـ Index ليتوافق مع القائمة المفلترة):
  void _onUpdateQuantity(
      UpdateBrandQuantityEvent event, Emitter<PlanManagementState> emit) {
    final fullList = List<PlanBrandSp>.from(state.futureBrands);
    final filteredList = List<PlanBrandSp>.from(state.searchFutureBrands);

    // جلب العنصر الحالي من القائمة المفلترة بناءً على الـ index الخاص بها في الـ UI
    final currentBrand = filteredList[event.index];
    final updatedBrand = currentBrand.copyWith(totalAmount: event.quantity);

    // تحديث القائمة المفلترة
    filteredList[event.index] = updatedBrand;

    // تحديث القائمة الأصلية الكاملة عن طريق البحث عن الـ ID الثابت
    final originalIndex = fullList.indexWhere((element) => element.id == currentBrand.id);
    if (originalIndex != -1) {
      fullList[originalIndex] = updatedBrand;
    }

    // عمل emit بدون تغيير الحالة (Status) لكي لا يتم إعادة بناء الشاشة بالكامل بقيمة الـ Loading
    emit(state.copyWith(futureBrands: fullList, searchFutureBrands: filteredList));
  }

// 5. دالة البحث الجديدة المضافة للـ Bloc:
  void _onSearchBrands(
      SearchPlanBrandEvent event, Emitter<PlanManagementState> emit) {
    if (event.query.isEmpty) {
      emit(state.copyWith(searchFutureBrands: state.futureBrands));
    } else {
      final filtered = state.futureBrands
          .where((brand) =>
          brand.titleAr.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(state.copyWith(searchFutureBrands: filtered));
    }
  }
  void _onSearchBrandsActive(
      SearchActivePlanBrandEvent event, Emitter<PlanManagementState> emit) {
    if (event.query.isEmpty) {
      emit(state.copyWith(searchActiveBrands: state.activeBrands));
    } else {
      final filtered = state.activeBrands
          .where((brand) =>
          brand.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(state.copyWith(searchActiveBrands: filtered));
    }
  }
}
