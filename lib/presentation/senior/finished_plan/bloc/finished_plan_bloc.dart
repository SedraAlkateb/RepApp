import 'package:bloc/bloc.dart';
import 'package:domina_app/data/network/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/all_city_usecase.dart';
import 'package:domina_app/domain/usecase/finished_plans_usecase.dart';
import 'package:domina_app/domain/usecase/get_pan_reps_usecase.dart';
import 'package:domina_app/presentation/senior/all_city/bloc/bloc/all_city_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'finished_plan_event.dart';
part 'finished_plan_state.dart';

class FinishedPlanBloc extends Bloc<FinishedPlanEvent, FinishedPlanState> {
  // تعريف الـ Usecase كمتغير نهائي لضمان عدم تغييره
  final FinishedPlansUsecase finishedPlansUsecase;
  final GetPanRepsUsecase getPanRepsUsecase;
  final AllCityUsecase allcityUsecase;
  FinishedPlanBloc(this.finishedPlansUsecase,this.getPanRepsUsecase,this.allcityUsecase) : super(FinishedPlanInitial()) {
    // تسجيل الأحداث: هنا نربط الحدث بالدالة المسؤولة عنه فقط
    on<GetFinishedPlansEvent>(_onGetFinishedPlans);
    on<GetPlanRepsEvent>(_onGetPlanReps);
    on<GetAllCityEventForPlan>(_onGetCity);

  }

  /// الدالة المسؤولة عن معالجة جلب الخطط المنتهية
  /// تم فصلها لسهولة القراءة والصيانة
  Future<void> _onGetFinishedPlans(
      GetFinishedPlansEvent event,
      Emitter<FinishedPlanState> emit,
      ) async {
    // 1. تغيير الحالة إلى "تحميل" لإبلاغ الواجهة
    emit(FinishedPlanLoading());

    // 2. طلب البيانات من طبقة الـ Domain وانتظار النتيجة
    final result = await finishedPlansUsecase.execute(event.cityId);

    // 3. معالجة النتيجة القادمة (إما فشل Failure أو نجاح Success)
    result.fold(
          (failure) {
        // في حال حدوث خطأ، نرسل حالة الخطأ مع الرسالة
        emit(FinishedPlanError(message: failure.massage));
      },
          (plans) {
        // في حال النجاح، نرسل البيانات المستلمة للواجهة
        emit(FinishedPlanLoaded(plans: plans));
      },
    );
  }

  Future<void> _onGetPlanReps(
      GetPlanRepsEvent event,
      Emitter<FinishedPlanState> emit,
      ) async {
    // 1. تغيير الحالة إلى "تحميل" لإبلاغ الواجهة
    emit(PlanRepsLoading());

    // 2. طلب البيانات من طبقة الـ Domain وانتظار النتيجة
    final result = await getPanRepsUsecase.execute(event.planId);

    // 3. معالجة النتيجة القادمة (إما فشل Failure أو نجاح Success)
    result.fold(
          (failure) {
        // في حال حدوث خطأ، نرسل حالة الخطأ مع الرسالة
        emit(PlanRepsError(message: failure.massage));
      },
          (data) {
        // في حال النجاح، نرسل البيانات المستلمة للواجهة
        emit(PlanRepsLoaded(data));
      },
    );
  }

  Future<void> _onGetCity(
      GetAllCityEventForPlan event,
      Emitter<FinishedPlanState> emit,
      ) async {
    // 1. تغيير الحالة إلى "تحميل" لإبلاغ الواجهة
    emit(AllCityLoadingState());

    // 2. طلب البيانات من طبقة الـ Domain وانتظار النتيجة
    final result = await allcityUsecase.execute();

    // 3. معالجة النتيجة القادمة (إما فشل Failure أو نجاح Success)
    result.fold(
          (failure) {
        // في حال حدوث خطأ، نرسل حالة الخطأ مع الرسالة
        emit(AllCityErrorState( failure: failure));
      },
          (data) {
        // في حال النجاح، نرسل البيانات المستلمة للواجهة
        emit(GetAllCityState(data));
      },
    );
  }
}