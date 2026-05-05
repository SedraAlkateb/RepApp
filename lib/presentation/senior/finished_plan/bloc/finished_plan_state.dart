part of 'finished_plan_bloc.dart';

@immutable
abstract class FinishedPlanState extends Equatable {
  const FinishedPlanState();

  @override
  List<Object> get props => [];
}

// 1. الحالة الابتدائية قبل أي إجراء
class FinishedPlanInitial extends FinishedPlanState {}

// 2. حالة التحميل (يتم عرض Spinner في الواجهة)
class FinishedPlanLoading extends FinishedPlanState {}

// 3. حالة النجاح (تحتوي على قائمة الخطط المستلمة)
class FinishedPlanLoaded extends FinishedPlanState {
  final List<dynamic> plans; // يمكنك استبدال dynamic بموديل الخطة الخاص بك

  const FinishedPlanLoaded({required this.plans});

  @override
  List<Object> get props => [plans];
}

// 4. حالة الخطأ (تحتوي على رسالة الخطأ)
class FinishedPlanError extends FinishedPlanState {
  final String message;

  const FinishedPlanError({required this.message});

  @override
  List<Object> get props => [message];
}